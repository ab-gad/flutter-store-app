import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer_content.dart';
import 'package:flutter_store_app/presentation/main/pages/home/veiw_model/home_view_model.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

import '../../../../../domain/models/state_renderer_content_data.dart';
import '../../../../../generated/locale_keys.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final noDataWidget = StateRendererContent(
    stateData: StateRendererContentData(
      imageUrl: AppImages.emptyStateJsonImage,
      message: LocaleKeys.noData.tr(),
    ),
  );

  final _homeViewModel = sl<HomeViewModel>();

  @override
  void initState() {
    _homeViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateRendererData>(
      stream: _homeViewModel.stateRendererStream,
      builder: (context, snapshot) => snapshot.data != null
          ? StateRenderer(
              stateRendererData: snapshot.data!,
              content: _buildHomeContent(context),
            )
          : const Center(
              child: Text("No Initial State"),
            ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return StreamBuilder<HomeDataModel>(
        stream: _homeViewModel.homeDataStream,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      //============================================
                      //--------------[Banners Carousel]
                      //============================================
                      const SizedBox(
                        height: AppValues.v10,
                      ),
                      _buildBannersCarousel(snapshot.data!.banners),
                      //============================================
                      //--------------[Services List view]
                      //============================================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.v10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppValues.v20,
                                bottom: AppValues.v10,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  LocaleKeys.services.tr(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            _buildServicesListView(snapshot.data!.services),
                          ],
                        ),
                      ),
                      //============================================
                      //--------------[Stores Grid]
                      //============================================
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: AppValues.v20,
                          bottom: AppValues.v10,
                          start: AppValues.v10,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            LocaleKeys.stores.tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      _buildStoreWrapper(snapshot.data!.stores),
                    ]),
                  ),
                )
              : const Center(
                  child: Text("No Home Data State"),
                );
        });
  }

  Widget _buildBannersCarousel(List<BannerModel> banners) {
    return banners.isEmpty
        ? noDataWidget
        : CarouselSlider(
            items: banners.map(_buildBannerCarouselSlide).toList(),
            options: CarouselOptions(
              viewportFraction: .8,
              height: AppValues.v100 * 2,
            ));
  }

  Widget _buildServicesListView(List<HomeDataModelItem> services) {
    return services.isEmpty
        ? noDataWidget
        : SizedBox(
            height: AppValues.v100 * 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: services.map(_buildServiceListViewItem).toList(),
            ),
          );
  }

  Widget _buildStoreWrapper(List<HomeDataModelItem> stores) {
    return stores.isEmpty
        ? noDataWidget
        : Wrap(
            spacing: AppValues.v10,
            runSpacing: AppValues.v10,
            children: stores.map(_buildStoresGridItem).toList(),
          );
  }

  Widget _buildBannerCarouselSlide(BannerModel banner) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: AppValues.v1_5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.v10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.v10),
          child: Image.network(
            banner.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceListViewItem(HomeDataModelItem service) {
    return Card(
      elevation: AppValues.v4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.v10)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppValues.v10),
            child: Image.network(
              service.image,
              height: (AppValues.v100 * 1.5),
              width: (AppValues.v100 * 1.8),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Center(
                  child: Text(
            service.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ))),
        ],
      ),
    );
  }

  Widget _buildStoresGridItem(HomeDataModelItem store) {
    return SizedBox(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        height: (MediaQuery.of(context).size.width - 30) / 2,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              RoutesManager.storeDetails,
              arguments: store,
            );
          },
          child: Image.network(
            store.image,
            fit: BoxFit.cover,
          ),
        ));
  }
}
