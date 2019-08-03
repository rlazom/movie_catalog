
class Image {

  String url;

	Image.fromJsonMap(Map<String, dynamic> map): 
		url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = url;
		return data;
	}
}
