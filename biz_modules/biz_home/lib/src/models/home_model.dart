class HomeModel {
  String? title;

  HomeModel({required String title});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    HomeModel model = HomeModel(title: json['title']);
    return model;
  }
  Map<String, dynamic> toJson() {
    return {'title': title ?? ''};
  }
}
