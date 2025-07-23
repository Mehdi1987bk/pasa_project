// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_instances_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInstancesResponse _$GetInstancesResponseFromJson(
        Map<String, dynamic> json) =>
    GetInstancesResponse(
      imageId: json['image_id'] as int,
      segmentation: json['segmentation'] as String,
      categoryId: json['category_id'] as int,
    );

Map<String, dynamic> _$GetInstancesResponseToJson(
        GetInstancesResponse instance) =>
    <String, dynamic>{
      'image_id': instance.imageId,
      'segmentation': instance.segmentation,
      'category_id': instance.categoryId,
    };
