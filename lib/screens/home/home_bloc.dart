import 'package:pasa_project/main.dart';
import '../../data/network/response/getImages_by_ids_resposne.dart';
import '../../data/network/response/get_captions_response.dart';
import '../../data/network/response/get_instances_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/base_bloc.dart';

class HomeBloc extends BaseBloc {
  final userRepository = sl.get<AuthRepository>();
  List<int> selectedCategoryIds = [];

  Future<List<int>>? getIdByCatsFuture;

  void updateSelectedCategories(List<int> newIds) {
    selectedCategoryIds = newIds;
    getIdByCatsFuture = null;
  }

  void fetchIdsForSelectedCategories() {
    if (selectedCategoryIds.isNotEmpty) {
      getIdByCatsFuture = userRepository.getIdByCats(selectedCategoryIds);
    }
  }

  Future<List<GetImagesByIdsResponse>> getImagesByIds(List<int> imageIds) =>
      userRepository.getImagesByIds(imageIds);

  Future<List<GetInstancesResponse>> getInstances(List<int> imageIds) =>
      userRepository.getInstances(imageIds);

  Future<List<GetCaptionsResponse>> getCaptions(List<int> imageIds) =>
      userRepository.getCaptions(imageIds);
}
