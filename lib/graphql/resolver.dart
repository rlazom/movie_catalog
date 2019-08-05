import 'package:catalogo/graphql/queries.dart';
import 'package:catalogo/graphql/test/AudiovisualConstraints.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:graphql/client.dart';

class Resolver {
  final uri = 'http://10.42.0.1:1337/graphql';
  // final uri = 'http://172.18.0.1:1337/graphql';
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
      link: _link,
    );
  }

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      List<CategoryModel> resultList = [];
      final GraphQLClient _client = client();

      final QueryResult result =
          await _client.query(QueryOptions(document: CFG.queryAllCategorias));

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

  Future<List<AudiovisualModel>> findAudiovisualList(
      int limit, int skip, String category, String genre, String title) async {
    List<AudiovisualModel> resultList = [];
    try {
      final GraphQLClient _client = client();

      var options = QueryOptions(document: CFG.findAudiovisualQuery);
      var variables = <String, dynamic>{'limit': limit, 'skip': skip};

      List<String> wheres = [];
      if (category != null && category.isNotEmpty) {
        wheres.add('category: {_eq: "$category"}');
      }
      if (genre != null && genre.isNotEmpty) {
        wheres.add('genre: {_eq: "$genre"}');
      }
      if (title != null && title.isNotEmpty) {
        wheres.add('titulo: {_text: {_search: {_term: "$title"}}}');
      }
      if (wheres.isNotEmpty) {
        variables.putIfAbsent('where', () {
          return AudiovisualConstraints.fromJsonMap({
//            "titulo": {"_text": {"_search": {"_term": ""}}},
            "category": {"_eq": category},
            "genre": {"_eq": genre}
          }).toJson();
        });
//        variables.putIfAbsent('where', () => wheres.join(','));
      }

      options.variables = variables;
      final QueryResult result = await _client.query(options);

      if (!result.hasErrors) {
        final List<dynamic> list =
            result.data['objects']['findaudiovisual']['results'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(AudiovisualModel.fromGraphqlObject(c));
        });
      } else print(result.errors[0].message);
    } catch (e) {
      print(e);
    }
    return await new Future<List<AudiovisualModel>>(() => resultList);
  }

  createCategory(CategoryModel category) {}

  updateCategory(CategoryModel category) {}

  deleteCategory(String id) {}

  deleteAllCategory() {}
}
