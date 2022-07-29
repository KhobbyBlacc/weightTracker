
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String? name;
  String? password;
  String? phone;
  String? age;

  UserModel({this.email, this.name, this.password, this.age, this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

