class IMModel {
  String? title;

  IMModel({required String title});
  factory IMModel.fromJson(Map<String, dynamic> json) {
    IMModel model = IMModel(title: json['title']);
    return model;
  }
  Map<String, dynamic> toJson() {
    return {'title': title ?? ''};
  }
}
