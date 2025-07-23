import 'package:json_annotation/json_annotation.dart';


part 'get_instances_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class GetInstancesResponse {
  final int imageId;
  final String segmentation;
  final int categoryId;

  GetInstancesResponse(
      {required this.imageId, required this.segmentation, required this.categoryId});

  factory GetInstancesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInstancesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInstancesResponseToJson(this);
}
