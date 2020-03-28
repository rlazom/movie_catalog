class CFG {
  static const loguotMutation = r'''
            mutation logout {
              users{
                logOut
              }
            }
   ''';
  static const queryAllCategorias = r'''
            query categorias {
              categorias(order: categoria_ASC) {
                edges {
                  node {
                    objectId
                    categoria
                    id_padre
                  }
                }
              }
            }
          ''';
  static const findAudiovisualQuerySearch = r'''
            query searchAudiovisual($where: AudiovisualWhereInput) {
  audiovisuals(order: titulo_ASC, where: $where) {
     edges{
      node{
				...audiovisual
			}
    }
  }
}

fragment audiovisual on Audiovisual {
  objectId
	titulo
  updatedAt
  image {
    image {
      url
    }
  }
}

          ''';
  static const findAudiovisualQuery = r'''
            query searchAudiovisual($limit: Int, $skip: Int, $where:audiovisualConstraints) {
              objects {    
                findaudiovisual(
                  order:titulo_ASC,
                  limit:$limit,
                  skip:$skip,
                  where:$where
                ) {
                  results{
                    ...audiovisual
                  }
                }
              }
            }

            fragment audiovisual on audiovisualClass {
              titulo
              sinopsis
              updatedAt
              tamanno
              formato
              capitulos
              director
              anno
              productora
              duracion
              idioma
              reparto
              pais
              image{
                image{
                  url
                }
              }        
              category{
                categoria
              }
              genre{
                categoria
              }
            }
          ''';
  static const countAudiovisuales = r'''
            query cantidad($category: categoriaPointer, $genre: categoriaPointer) {
              objects {
                findaudiovisual(
                  where: { category: { _eq: $category }, genre: { _eq: $genre } }
                ) {
                  count
                }
              }
            }
''';
  static const countAudiovisualesByCategory = r'''
            query cantidad($category: categoriaPointer) {
              objects {
                findaudiovisual(
                  where: { category: { _eq: $category }}
                ) {
                  count
                }
              }
            }
''';
}
