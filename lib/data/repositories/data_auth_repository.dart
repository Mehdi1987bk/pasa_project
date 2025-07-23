import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../main.dart';
import '../network/api/auth_api.dart';
import '../network/response/getImages_by_ids_resposne.dart';
import '../network/response/get_captions_response.dart';
import '../network/response/get_instances_response.dart';

const tokenRefreshTimeOut = 60 * 60 * 1000;

class DataAuthRepository implements AuthRepository {
  final AuthApi _authApi = sl.get<AuthApi>();

  @override
  Future<List<int>> getIdByCats(List<int> ids) {
    final data = <String, dynamic>{
      'querytype': 'getImagesByCats',
      'category_ids[]': ids,
    };
    return _authApi.getIdByCats(data);
  }

  @override
  Future<List<GetImagesByIdsResponse>> getImagesByIds(List<int> imageIds) {
    final data = <String, dynamic>{
      'querytype': 'getImages',
      'image_ids[]': imageIds,
    };
    return _authApi.getImagesByIds(data);
  }

  @override
  Future<List<GetInstancesResponse>> getInstances(List<int> imageIds) {
    final data = <String, dynamic>{
      'querytype': 'getInstances',
      'image_ids[]': imageIds,
    };
    return _authApi.getInstances(data);
  }

  @override
  Future<List<GetCaptionsResponse>> getCaptions(List<int> imageIds) {
    final data = <String, dynamic>{
      'querytype': 'getCaptions',
      'image_ids[]': imageIds,
    };
    return _authApi.getCaptions(data);
  }
}
