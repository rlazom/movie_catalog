import 'package:catalogo/model/audiovisual/image.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/audiovisual/genre.dart';

class AudiovisualModel {
  String titulo;
  String sinopsis;
  String updatedAt;
  String tamanno;
  String formato;
  Image image;
  Category category;
  Genre genre;
  String imageUrl;
  String capitulos;
  String director;
  String anno;
  String productora;
  String duracion;
  String idioma;
  String reparto;
  String pais;

  AudiovisualModel(this.titulo, this.sinopsis, this.updatedAt, this.tamanno,
      this.formato, this.imageUrl, this.category, this.genre);

  AudiovisualModel.fromJsonMap(Map<String, dynamic> map)
      : titulo = map["titulo"],
        sinopsis = map["sinopsis"],
        updatedAt = map["updatedAt"],
        tamanno = map["tamanno"],
        formato = map["formato"],
        image = Image.fromJsonMap(map["image"]),
        category = Category.fromJsonMap(map["category"]),
        genre = Genre.fromJsonMap(map["genre"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = titulo;
    data['sinopsis'] = sinopsis;
    data['updatedAt'] = updatedAt;
    data['tamanno'] = tamanno;
    data['formato'] = formato;
    data['image'] = image == null ? null : image.toJson();
    data['category'] = category == null ? null : category.toJson();
    data['genre'] = genre == null ? null : genre.toJson();
    return data;
  }

  static AudiovisualModel fromGraphqlObject(dynamic a) {
    var imageUrl;
    if (a['image'] != null) {
      imageUrl =
          a['image']['image']['url'].toString().replaceFirst('graphq', 'parse');
    }
    var audiovisualModel = AudiovisualModel(
        a['titulo'],
        a['sinopsis'],
        a['updatedAt'],
        a['tamanno'],
        a['formato'],
        imageUrl,
        Category.fromJsonMap(a['category']),
        Genre.fromJsonMap(a['genre']));
    audiovisualModel.capitulos = a['capitulos'];
    audiovisualModel.director = a['director'];
    audiovisualModel.anno = a['anno'];
    audiovisualModel.productora = a['productora'];
    audiovisualModel.duracion = a['duracion'];
    audiovisualModel.idioma = a['idioma'];
    audiovisualModel.reparto = a['reparto'];
    audiovisualModel.pais = a['pais'];
    return audiovisualModel;
  }
}
