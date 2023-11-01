class CategoriesModel {
  int? id;
  String? url;
  String? title;

  CategoriesModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    url = data['image'];
    title = data['name'];
  }
}
