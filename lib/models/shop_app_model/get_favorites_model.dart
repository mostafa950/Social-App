class GetFavorites {
  bool? status;
  FavoritesDataModel? data;

  GetFavorites.fromJson(Map<String , dynamic> json){
    this.status = json['status'];
    this.data = json['data'] != null ? FavoritesDataModel.fromJson(json['data']) : null;
  }
}

class FavoritesDataModel {
  int? currentPage;
  int? last_page;
  int? from;
  int? per_page;
  int? to;
  int? total;
  String? first_page_url;
  String? last_page_url;
  String? path;
  dynamic next_page_url;
  dynamic prev_page_url;
  List<FavoritesData> data = [];
  FavoritesDataModel.fromJson(Map<String , dynamic> json)
  {
    json['data'].forEach((element){
      this.data.add(FavoritesData.fromJson(element));
    });
    this.currentPage = json['current_page'];
    this.first_page_url = json['first_page_url'];
    this.from = json['from'];
    this.last_page = json['last_page'];
    this.last_page_url = json['last_page_url'];
    this.next_page_url = json['next_page_url'];
    this.path = json['path'];
    this.per_page = json['per_page'];
    this.prev_page_url = json['prev_page_url'];
    this.to = json['to'];
    this.total = json['total'];
  }
}

class FavoritesData {
  int? favoritesId;
  FavoritesProduct? product ;

  FavoritesData.fromJson(Map<String , dynamic> json)
  {
    this.favoritesId = json['id'];
    this.product = FavoritesProduct.fromJson(json['product']);
  }
}

class FavoritesProduct {
  int? productId;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoritesProduct.fromJson(
   Map<String , dynamic> json
  ){
    this.productId = json['id'];
    this.price = json['price'];
    this.old_price = json['old_price'];
    this.discount = json['discount'];
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
  }
}
