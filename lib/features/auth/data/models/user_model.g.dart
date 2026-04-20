// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt(),
  mongoId: json['_id'] as String?,
  name: json['name'] as String?,
  fName: json['fName'] as String?,
  lName: json['lName'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  '_id': instance.mongoId,
  'name': instance.name,
  'fName': instance.fName,
  'lName': instance.lName,
  'email': instance.email,
  'role': instance.role,
};
