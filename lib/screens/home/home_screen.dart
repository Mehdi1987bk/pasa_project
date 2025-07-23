import 'package:flutter/material.dart';
import 'package:pasa_project/presentation/bloc/base_screen.dart';
import 'package:pasa_project/screens/home/home_bloc.dart';
import 'package:pasa_project/screens/home/widget/%D1%81ategory_item.dart';
 import 'package:pasa_project/screens/home/widget/category_list.dart';
import 'package:pasa_project/screens/home/widget/choose_category_button.dart';
import 'package:pasa_project/screens/home/widget/selected_categories_widget.dart';
import '../../../data/network/response/getImages_by_ids_resposne.dart';
import '../../../data/network/response/get_instances_response.dart';
import '../../../data/network/response/get_captions_response.dart';

class HomeScreen extends BaseScreen {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  final int itemsPerPage = 5;

  List<int> allIds = [];
  List<GetImagesByIdsResponse> displayedImages = [];
  Map<int, List<GetInstancesResponse>> imageInstances = {};
  Map<int, List<GetCaptionsResponse>> imageCaptions = {};

  int currentPage = 0;
  bool _isPaginationInitialized = false;

  Future<void> _loadNextPage() async {
    final start = currentPage * itemsPerPage;
    if (start >= allIds.length) return;

    final nextIds = allIds.skip(start).take(itemsPerPage).toList();

    final newImages = await bloc.getImagesByIds(nextIds);
    final instances = await bloc.getInstances(nextIds);
    final captions = await bloc.getCaptions(nextIds);

    final groupedInstances = <int, List<GetInstancesResponse>>{};
    for (var instance in instances) {
      groupedInstances.putIfAbsent(instance.imageId, () => []).add(instance);
    }

    final groupedCaptions = <int, List<GetCaptionsResponse>>{};
    for (var caption in captions) {
      groupedCaptions.putIfAbsent(caption.imageId, () => []).add(caption);
    }

    setState(() {
      currentPage += 1;
      displayedImages.addAll(newImages);
      imageInstances.addAll(groupedInstances);
      imageCaptions.addAll(groupedCaptions);
    });
  }

  Future<void> _initPagination(List<int> ids) async {
    allIds = ids;
    currentPage = 0;
    displayedImages.clear();
    imageInstances.clear();
    imageCaptions.clear();
    _isPaginationInitialized = false;

    await _loadNextPage();

    setState(() {
      _isPaginationInitialized = true;
    });
  }

  @override
  Widget body() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CategoryButton(onTap: () => _openCategoryDialog(context)),

          if (bloc.selectedCategoryIds.isNotEmpty)
            SelectedCategoriesWidget(
              selectedCategoryIds: bloc.selectedCategoryIds,
              onDelete: (id) {
                setState(() {
                  bloc.selectedCategoryIds.remove(id);
                  bloc.getIdByCatsFuture = null;
                  allIds.clear();
                  displayedImages.clear();
                  imageInstances.clear();
                  imageCaptions.clear();
                  currentPage = 0;
                  _isPaginationInitialized = false;
                });
              },
              onSearch: () {
                setState(() {
                  bloc.fetchIdsForSelectedCategories();
                });
              },
            ),

          if (bloc.getIdByCatsFuture != null)
            FutureBuilder<List<int>>(
              future: bloc.getIdByCatsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Ошибка: \${snapshot.error}');
                }

                if (snapshot.hasData) {
                  if (!_isPaginationInitialized) {
                    _initPagination(snapshot.requireData);
                    return const Center(child: CircularProgressIndicator());
                  }

                  final hasMore = displayedImages.length < allIds.length;

                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: displayedImages.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final image = displayedImages[index];
                          final instances = imageInstances[image.id] ?? [];
                          final captions = imageCaptions[image.id] ?? [];
                          return CategoryItem(
                            image: image,
                            instances: instances,
                            captions: captions,
                            id: snapshot.requireData[index],
                          );
                        },
                      ),

                      if (hasMore)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            onPressed: _loadNextPage,
                            child: const Text("Загрузить ещё"),
                          ),
                        ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
        ],
      ),
    );
  }

  Future<void> _openCategoryDialog(BuildContext context) async {
    final selected = await showDialog<List<int>>(
      context: context,
      builder: (_) => CategorySelectorDialog(
        initiallySelected: bloc.selectedCategoryIds,
      ),
    );

    if (selected != null) {
      setState(() {
        bloc.updateSelectedCategories(selected);
        bloc.getIdByCatsFuture = null;
        allIds.clear();
        displayedImages.clear();
        imageInstances.clear();
        imageCaptions.clear();
        currentPage = 0;
        _isPaginationInitialized = false;
      });
    }
  }

  @override
  HomeBloc provideBloc() => HomeBloc();
}