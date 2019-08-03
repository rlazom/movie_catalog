
class Genre {

  String categoria;

	Genre.fromJsonMap(Map<String, dynamic> map): 
		categoria = map["categoria"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categoria'] = categoria;
		return data;
	}
}
