import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String? status;
  final String? token;
  final UserData? data;

  AuthResponse({this.status, this.token, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  final UserModel? user;

  UserData({this.user});

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
