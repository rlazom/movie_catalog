class CategoryModel {
  String name;
  String _idParent;
  String _id;
  List<CategoryModel> genres = [];

  String get idParent => _idParent;

  set idParent(String value) {
    _idParent = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  CategoryModel(this.name, this._idParent, this._id);

  static CategoryModel fromGraphqlObject(dynamic c) {
    return CategoryModel(c['categoria'], c['id_padre'], c['objectId']);
  }
}
