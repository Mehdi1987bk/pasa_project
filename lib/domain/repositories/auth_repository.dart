import 'dart:io';

import 'package:dio/dio.dart';

import '../../data/network/response/getImages_by_ids_resposne.dart';
import '../../data/network/response/get_captions_response.dart';
import '../../data/network/response/get_instances_response.dart';

abstract class AuthRepository {
  Future<List<int>> getIdByCats(List<int> ids);

  Future<List<GetImagesByIdsResponse>> getImagesByIds(List<int> imageIds);

  Future<List<GetInstancesResponse>> getInstances(List<int> imageIds);

  Future<List<GetCaptionsResponse>> getCaptions(List<int> imageIds);
}
