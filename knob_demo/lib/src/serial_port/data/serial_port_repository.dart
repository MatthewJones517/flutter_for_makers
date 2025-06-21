import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'serial_port_repository.g.dart';

@riverpod
SerialPort serialPortRepository(Ref ref) {
  final List<String> availablePorts = SerialPort.availablePorts;

  final ports = availablePorts.map((String address) {
    return SerialPort(address);
  }).toList();

  return ports.firstWhere((port) => port.productName == 'FT232R USB UART');
}
