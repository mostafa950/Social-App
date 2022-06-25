class ChangeFavoritesModel
{
  bool? status ;
  String? message ;
  ChangeFavoritesModel.fromJson(Map<String , dynamic> json){
    this.status = json['status'];
    this.message = json['message'];
  }
}