
import 'package:json_annotation/json_annotation.dart';
part 'getImages_by_ids_resposne.g.dart';


@JsonSerializable(fieldRename:  FieldRename.snake)
class GetImagesByIdsResponse{
  final  int id;
  final String cocoUrl;
  final String flickrUrl;

  GetImagesByIdsResponse(this.id, this.cocoUrl, this.flickrUrl);


  factory GetImagesByIdsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetImagesByIdsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetImagesByIdsResponseToJson(this);




}
