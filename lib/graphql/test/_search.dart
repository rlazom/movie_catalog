
class search {

  String _term;

	search.fromJsonMap(Map<String, dynamic> map):
		_term = map["_term"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_term'] = _term;
		return data;
	}
}
