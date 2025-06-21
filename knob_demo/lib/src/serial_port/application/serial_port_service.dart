import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:knob_demo/src/serial_port/data/serial_port_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'serial_port_service.g.dart';

@Riverpod(keepAlive: true, dependencies: [serialPortRepository])
class SerialPortService extends _$SerialPortService {
  late SerialPort _port;
  SerialPortReader? _reader;
  StreamController<String>? _controller;
  String _buffer = '';

  @override
  Stream<String> build() {
    _port = ref.watch(serialPortRepositoryProvider);
    _port.openReadWrite();

    _port.config = SerialPortConfig()
      ..baudRate = 9600
      ..bits = 8
      ..stopBits = 1
      ..parity = SerialPortParity.none
      ..setFlowControl(SerialPortFlowControl.none);

    _reader = SerialPortReader(_port);
    _controller = StreamController<String>();

    _reader!.stream.listen(
      (data) => _processIncomingData(data),
      onError: (error) => _controller?.addError(error),
    );

    ref.onDispose(() {
      _reader?.close();
      _port.close();
      _controller?.close();
    });

    return _controller!.stream;
  }

  void _processIncomingData(Uint8List data) {
    _buffer += String.fromCharCodes(data);

    while (_buffer.contains('\n')) {
      final newlineIndex = _buffer.indexOf('\n');
      final message = _buffer.substring(0, newlineIndex);

      // The \r might not always be present, but clean it if it is.
      final cleanMessage = message.replaceAll('\r', '').trim();

      if (cleanMessage.isNotEmpty) {
        _controller?.add(cleanMessage);
      }

      _buffer = '';
    }
  }

  bool writeString(String data) {
    if (!_port.isOpen) {
      throw StateError('Port is not open');
    }
    return _port.write(Uint8List.fromList(data.codeUnits)) > 0;
  }
}
