// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) => WeightModel(
      weightNo: json['weightNo'] as num?,
     // dateCreated: json['dateCreated'] as DateTime?,

       dateCreated:/*  DateTime.fromMillisecondsSinceEpoch(json['dateCreated']) */
        json['dateCreated'] 
    );

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'weightNo': instance.weightNo,
      'dateCreated': instance.dateCreated,
    };
