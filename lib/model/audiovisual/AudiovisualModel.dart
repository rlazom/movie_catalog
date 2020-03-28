import 'package:catalogo/model/audiovisual/image.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/audiovisual/genre.dart';

class AudiovisualModel {
  final String id;
  String titulo;
  String sinopsis;
  String updatedAt;
  String tamanno;
  String formato;
  Image image;
  Category category;
  Genre genre;
  String score;
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
      this.formato, this.imageUrl, this.category, this.genre, this.id);

  AudiovisualModel.build(
      {this.titulo,
      this.sinopsis,
      this.updatedAt,
      this.tamanno,
      this.formato,
      Image image,
      Category category,
      this.score,
      this.genre,
      this.imageUrl,
      this.capitulos,
      this.director,
      this.anno,
      this.productora,
      this.duracion,
      this.idioma,
      this.reparto,
      this.pais,
      this.id});

//  AudiovisualModel.fromJsonMap(Map<String, dynamic> map)
//      : titulo = map["titulo"],
//        sinopsis = map["sinopsis"],
//        updatedAt = map["updatedAt"],
//        tamanno = map["tamanno"],
//        formato = map["formato"],
//        image = Image.fromJsonMap(map["image"]),
//        category = Category.fromJsonMap(map["category"]),
//        genre = Genre.fromJsonMap(map["genre"]);

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
        Genre.fromJsonMap(
          a['genre'],
        ),
        a['objectId']);
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

  static AudiovisualModel fromAudiovisualDbTableData(dynamic a) {
    var audiovisualModel = AudiovisualModel(
        a['titulo'],
        a['sinopsis'],
        a['updatedAt'],
        a['tamanno'],
        a['formato'],
        null,
        Category.fromJsonMap(a['category']),
        Genre.fromJsonMap(a['genre']),
        a['id']);
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
