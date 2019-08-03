import 'dart:collection';

import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:graphql/client.dart';

class Resolver {
  final uri = 'http://172.18.0.1:1337/graphql';
  final appId = 'yourappid';
  final masterKey = 'yourmasterkey';

  GraphQLClient client() {
    final HttpLink _httpLink = HttpLink(uri: uri, headers: <String, String>{
      'X-Parse-Application-Id': 'yourappid',
      'X-Parse-Master-Key': 'yourmasterkey'
    });

    final AuthLink _authLink = AuthLink(
      getToken: () async => 'Bearer ',
    );

    final Link _link = _authLink.concat(_httpLink as Link);

    return GraphQLClient(
      cache: InMemoryCache(),
//      link: _httpLink as Link,
      link: _link,
    );
  }

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      List<CategoryModel> resultList = [];
      final GraphQLClient _client = client();

      const String query = r'''
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

      final QueryResult result =
          await _client.query(QueryOptions(document: query));

      if (!result.hasErrors) {
        final List<dynamic> list =
        result.data['objects']['findcategoria']['results'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(CategoryModel.fromGraphqlObject(c));
        });
      }

      return await new Future<List<CategoryModel>>(() => resultList);
    } catch (e) {
      return null;
    }

  }

  //TODO FIX!!!!!!!!!!!!
  Future<List<AudiovisualModel>> findAudiovisual() async {
    try {
      List<AudiovisualModel> resultList = [];
      final GraphQLClient _client = client();

      const String query = r'''
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

      final QueryResult result =
      await _client.query(QueryOptions(document: query));

      if (!result.hasErrors) {
        final List<dynamic> list =
        result.data['objects']['findcategoria']['results'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(AudiovisualModel.fromGraphqlObject(c));
        });
      }

      return await new Future<List<AudiovisualModel>>(() => resultList);
    } catch (e) {
      return null;
    }

  }

  createCategory(CategoryModel category) {}

  updateCategory(CategoryModel category) {}

  deleteCategory(String id) {}

  deleteAllCategory() {}
}
