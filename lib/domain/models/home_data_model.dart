class HomeDataModel {
  final List<BannerModel> banners;
  final List<HomeDataModelItem> services;
  final List<HomeDataModelItem> stores;

  HomeDataModel({
    required this.banners,
    required this.services,
    required this.stores,
  });
}

class HomeDataModelItem {
  final String id;
  final String title;
  final String image;

  HomeDataModelItem({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannerModel extends HomeDataModelItem {
  final String link;

  BannerModel({
    required super.id,
    required super.title,
    required super.image,
    required this.link,
  });
}
