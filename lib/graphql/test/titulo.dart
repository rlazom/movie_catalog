import 'package:catalogo/graphql/test/_text.dart';

class Titulo {

  text _text;

	Titulo.fromJsonMap(Map<String, dynamic> map): 
		_text = text.fromJsonMap(map["_text"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_text'] = _text == null ? null : _text.toJson();
		return data;
	}
}
