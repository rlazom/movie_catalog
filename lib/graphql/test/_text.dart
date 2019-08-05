import 'package:catalogo/graphql/test/_search.dart';

class text {

  search _search;

	text.fromJsonMap(Map<String, dynamic> map):
		_search = search.fromJsonMap(map["_search"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_search'] = _search == null ? null : _search.toJson();
		return data;
	}
}
