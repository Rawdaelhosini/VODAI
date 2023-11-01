class LogoutModel {
  int? id;
  String? token;

  LogoutModel.fromjson({required Map<String, dynamic> data}) {
    id = data['id'];
    token = data['token'];
  }
}
