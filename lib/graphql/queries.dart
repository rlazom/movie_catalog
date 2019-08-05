class CFG {
  static const queryAllCategorias = r'''
            query AllCategorias {
              objects {
                findcategoria {
                  results{
                    objectId
                    categoria
                    id_padre
                  }
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
}