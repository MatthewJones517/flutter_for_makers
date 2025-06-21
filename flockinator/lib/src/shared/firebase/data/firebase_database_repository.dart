import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_database_repository.g.dart';

@riverpod
DatabaseReference firebaseDatabaseRepository(Ref ref) {
  return FirebaseDatabase.instance.ref();
}
