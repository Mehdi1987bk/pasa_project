import 'package:json_annotation/json_annotation.dart';

part 'get_captions_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetCaptionsResponse {
  final String caption;
  final int imageId;

  GetCaptionsResponse({required this.caption, required this.imageId});

  factory GetCaptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCaptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCaptionsResponseToJson(this);
}
