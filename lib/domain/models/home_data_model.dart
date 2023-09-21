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
  final int id;
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

class HomeStoreItemDetailsModel {
  final String details;
  final String services;
  final String about;

  HomeStoreItemDetailsModel({
    required this.details,
    required this.services,
    required this.about,
  });
}
