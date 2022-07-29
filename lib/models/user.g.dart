// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      age: json['age'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'phone': instance.phone,
      'age': instance.age,
    };
