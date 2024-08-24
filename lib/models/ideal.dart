import 'package:freezed_annotation/freezed_annotation.dart';

part 'ideal.freezed.dart';
part 'ideal.g.dart';

@freezed
class Ideal with _$Ideal {
  const factory Ideal({
    required int id,
    required int crime,
    required String body,
    required String md5,
    required DateTime createdAt,
    required String color,
  }) = _Ideal;

  factory Ideal.fromJson(Map<String, dynamic> json) => _$IdealFromJson(json);
}
