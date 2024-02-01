class OnboardingModel {
  String? title;
  String? message;
  DataModel? data;

  OnboardingModel({this.title, this.message, this.data});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataModel {
  String? userToken;
  dynamic id;
  String? name;
  String? mobile;
  String? email;

  DataModel({this.userToken, this.id, this.name, this.mobile, this.email});

  DataModel.fromJson(Map<String, dynamic> json) {
    userToken = json['user_token'];
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_token'] = userToken;
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
