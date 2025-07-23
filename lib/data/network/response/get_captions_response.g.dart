// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_captions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCaptionsResponse _$GetCaptionsResponseFromJson(Map<String, dynamic> json) =>
    GetCaptionsResponse(
      caption: json['caption'] as String,
      imageId: json['image_id'] as int,
    );

Map<String, dynamic> _$GetCaptionsResponseToJson(
        GetCaptionsResponse instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'image_id': instance.imageId,
    };
