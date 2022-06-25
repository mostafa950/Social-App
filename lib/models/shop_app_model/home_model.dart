class ShopHomeModel {
  bool? status;
  HomeData? data;

  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  List<BannersData>? banners;

  List<ProductsData>? products;

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(BannersData.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(ProductsData.fromJson(v));
      });
    }
  }
}

class BannersData {
  int? id;
  String? image;

  BannersData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
  }
}

class ProductsData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? favorites;
  bool? cart;

  ProductsData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = json['price'];
    this.oldPrice = json['old_price'];
    this.discount = json['discount'];
    this.image = json['image'];
    this.name = json['name'];
    this.favorites = json['in_favorites'];
    this.cart = json['in_cart'];
  }
}
