import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weights.g.dart';

@JsonSerializable()
class WeightModel {
  num? weightNo;
  Timestamp? dateCreated;

  WeightModel({this.weightNo, this.dateCreated});

  factory WeightModel.fromJson(Map<String, dynamic> json) =>
      _$WeightModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeightModelToJson(this);

  //get data
  WeightModel.fromSnapshot(snapshot)
      : weightNo = snapshot/* data() */['weightNo'],
        dateCreated = snapshot/* .data() */['dataCreated'].toDate();

}
