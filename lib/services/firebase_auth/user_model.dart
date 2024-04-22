import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class AuthUserModel {
  AuthUserModel({
    required this.email,
    required this.password,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => _$AuthUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);

  final String? email;
  final String? password;
}
