import 'package:catalogo/graphql/test/titulo.dart';
import 'package:catalogo/graphql/test/category.dart';
import 'package:catalogo/graphql/test/genre.dart';

class AudiovisualConstraints {

  Titulo titulo;
  Category category;
  Genre genre;

	AudiovisualConstraints.fromJsonMap(Map<String, dynamic> map): 
//		titulo = Titulo.fromJsonMap(map["titulo"]),
		category = Category.fromJsonMap(map["category"]),
		genre = Genre.fromJsonMap(map["genre"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['titulo'] = titulo == null ? null : titulo.toJson();
		data['category'] = category == null ? null : category.toJson();
		data['genre'] = genre == null ? null : genre.toJson();
		return data;
	}
}
