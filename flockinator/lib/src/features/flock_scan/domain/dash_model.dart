import 'package:freezed_annotation/freezed_annotation.dart';

part 'dash_model.freezed.dart';
part 'dash_model.g.dart';

@freezed
abstract class DashModel with _$DashModel {
  const factory DashModel({
    required String name,
    required int major,
    required int minor,
    required bool active,
  }) = _DashModel;

  factory DashModel.fromJson(Map<String, dynamic> json) =>
      _$DashModelFromJson(json);
}
