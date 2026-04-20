import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  @JsonKey(name: '_id')
  final String? mongoId;
  final String? name;
  final String? fName;
  final String? lName;
  final String? email;
  final String? role;

  UserModel({this.id, this.mongoId, this.name, this.fName, this.lName, this.email, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
