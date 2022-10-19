class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String , dynamic >? json) {
    this.name = json!['name'];
    this.phone = json['phone'];
    this.email = json['email'];
    this.password = json['password'];
    this.uId = json['uId'];
    this.image = json['image'];
    this.cover = json['cover'];
    this.bio = json['bio'];
    this.isEmailVerified = json['isEmailVerified'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'password' : password,
      'uId' : uId,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }
}
