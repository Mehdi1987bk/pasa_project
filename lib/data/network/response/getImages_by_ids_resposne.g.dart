// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getImages_by_ids_resposne.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImagesByIdsResponse _$GetImagesByIdsResponseFromJson(
        Map<String, dynamic> json) =>
    GetImagesByIdsResponse(
      json['id'] as int,
      json['coco_url'] as String,
      json['flickr_url'] as String,
    );

Map<String, dynamic> _$GetImagesByIdsResponseToJson(
        GetImagesByIdsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coco_url': instance.cocoUrl,
      'flickr_url': instance.flickrUrl,
    };
