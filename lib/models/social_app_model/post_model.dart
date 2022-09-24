class PostModel {
  String? name;
  String? dateTime;
  String? text;
  String? postImage;
  String? uId;
  String? imageProfile;

  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.postImage,
    this.uId,
    this.imageProfile,
  });

  PostModel.fromJson(Map<String , dynamic >? json) {
    this.name = json!['name'];
    this.dateTime = json['dateTime'];
    this.text = json['text'];
    this.postImage = json['postImage'];
    this.uId = json['uId'];
    this.imageProfile = json['imageProfile'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'dateTime' : dateTime,
      'text' : text,
      'postImage' : postImage,
      'uId' : uId,
      'imageProfile' : imageProfile,
    };
  }
}
