class SocialMessageModel {
  String? receivedId;
  String? senderId;
  String? text;
  String? dateTime;


  SocialMessageModel({
    this.receivedId,
    this.senderId,
    this.text,
    this.dateTime,


  });

  SocialMessageModel.fromJson(Map<String , dynamic >? json) {
    this.receivedId = json!['receivedId'];
    this.senderId = json['senderId'];
    this.text = json['text'];
    this.dateTime = json['dateTime'];
  }

  Map<String , dynamic> toMap(){
    return {
      'receivedId' : receivedId,
      'senderId' : senderId,
      'text' : text,
      'dateTime' : dateTime,
    };
  }
}
