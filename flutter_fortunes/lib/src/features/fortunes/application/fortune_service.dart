import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fortunes.dart';

part 'fortune_service.g.dart';

@riverpod
String fortuneService(Ref ref) {
  final random = Random();

  return fortunes[random.nextInt(fortunes.length)];
}