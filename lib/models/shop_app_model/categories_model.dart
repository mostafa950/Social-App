class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModelForCategories> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataModelForCategories.fromJson(element));
    });
  }
}

class DataModelForCategories {
  int? id;
  String? name;
  String? image;

  DataModelForCategories.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
  }
}
