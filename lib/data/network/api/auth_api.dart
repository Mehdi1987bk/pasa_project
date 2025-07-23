import 'dart:io';

import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';

import '../../../main.dart';
import '../response/getImages_by_ids_resposne.dart';
import '../response/get_captions_response.dart';
import '../response/get_instances_response.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @PUT('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery')
  @Headers({'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'})
  Future<List<int>> getIdByCats(@Body() Map<String, dynamic> body);


  @PUT('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery')
  @Headers({'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'})
  Future<List<GetImagesByIdsResponse>> getImagesByIds(@Body() Map<String, dynamic> body);


  @PUT('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery')
  @Headers({'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'})
  Future<List<GetInstancesResponse>> getInstances(@Body() Map<String, dynamic> body);


  @PUT('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery')
  @Headers({'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'})
  Future<List<GetCaptionsResponse>> getCaptions(@Body() Map<String, dynamic> body);

}
