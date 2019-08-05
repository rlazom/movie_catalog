
class Category {

  String _eq;

	Category.fromJsonMap(Map<String, dynamic> map): 
		_eq = map["_eq"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_eq'] = _eq;
		return data;
	}
}
