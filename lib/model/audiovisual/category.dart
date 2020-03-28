
class Category {

  String categoria;

	Category.fromJsonMap(Map<String, dynamic> map): 
		categoria = map != null ? map["categoria"] : null;

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categoria'] = categoria;
		return data;
	}
}
