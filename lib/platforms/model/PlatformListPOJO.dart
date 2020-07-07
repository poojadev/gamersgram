import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
part 'PlatformListPOJO.g.dart';



@JsonSerializable()
class PlatformList
{
  int count;
  List<PlatformListDetails>results;

  PlatformList(this.count,this.results);
  factory PlatformList.fromJson(Map<String, dynamic> json) => _$PlatformListFromJson(json);
  Map<String, dynamic> toJson() => _$PlatformListToJson(this);

}

@JsonSerializable()
class PlatformListDetails
{
    int id;
    String name;
    String image_background;
    PlatformListDetails(this.id,this.name,this.image_background);
    factory PlatformListDetails.fromJson(Map<String, dynamic> json) =>_$PlatformListDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$PlatformListDetailsToJson(this);

}


@JsonSerializable()
class PlatformDescription
{  int id;
String name;
String image_background;
  String description;

PlatformDescription(this.id,this.name,this.image_background,this.description);
factory PlatformDescription.fromJson(Map<String, dynamic> json) =>_$PlatformDescriptionFromJson(json);
Map<String, dynamic> toJson() => _$PlatformDescriptionToJson(this);

}