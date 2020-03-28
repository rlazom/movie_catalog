import 'package:catalogo/graphql/queries.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:graphql/client.dart';

class Resolver {
  // final parseUrl = 'http://192.168.1.107:1337';
  final String parseUrl = 'http://172.17.0.1:1337';
  // final String parseUrl = 'http://10.42.0.1:1337';

  // final uri = '$parseUrl/graphql';
  final appId = 'yourappid';
  final masterKey = 'yourmasterkey';

  var user;
  var token;

  Resolver() {
    // Parse().initialize(appId, '$parseUrl/parse', debug: true);
  }

  Future<bool> logout() async {
    try {
      final GraphQLClient _client = await client();
      var logoutResult = false;

      final QueryResult result =
          await _client.mutate(MutationOptions(document: CFG.loguotMutation));
      if (!result.hasErrors) {
        logoutResult = result.data['users']['logOut'];
        if (logoutResult) {
//          await service.clearLoginData();
        }
      }
      return await new Future<bool>(() => logoutResult);
    } catch (e) {
      print(e);
      return await new Future<bool>(() => false);
    }
  }

  Future<GraphQLClient> client() async {
//    String myToken = await service.getString(TOKEN_KEY);

    final HttpLink _httpLink = HttpLink(
        uri: '$parseUrl/graphql',
        headers: <String, String>{
          'X-Parse-Application-Id': 'yourappid',
//          'X-Parse-Session-Token': myToken
        });

    final Link _link = _httpLink as Link;

    var client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
    return new Future<GraphQLClient>(() => client);
  }

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      List<CategoryModel> resultList = [];
      final GraphQLClient _client = await client();

      final QueryResult result =
          await _client.query(QueryOptions(document: CFG.queryAllCategorias));

      if (!result.hasErrors) {
        final List<dynamic> list =
            result.data['categorias']['edges'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(CategoryModel.fromGraphqlObject(c['node']));
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
      final GraphQLClient _client = await client();

      var options = QueryOptions(document: CFG.findAudiovisualQuerySearch);
//      var options = QueryOptions(document: CFG.findAudiovisualQuery);
//     var variables = <String, dynamic>{'limit': limit, 'skip': skip};
       var variables = <String, dynamic>{};

      Map<String, dynamic> map = {};

      if (category != null && category.isNotEmpty) {
        await map.putIfAbsent('category', () {
          return {'have': {'objectId': {'equalTo': category}}};
        });
      }
      if (genre != null && genre.isNotEmpty) {
        await map.putIfAbsent('genre', () {
          return {'have': {'objectId': {'equalTo': genre}}};
        });
      }
      if (title != null && title.isNotEmpty) {
        await map.putIfAbsent(
            'titulo', () => {"matchesRegex": title, "options": 'i'});
      }
      if (map.isNotEmpty) {
        variables.putIfAbsent('where', () {
          return map;
        });
      }

      options.variables = variables;
      final QueryResult result = await _client.query(options);

      if (!result.hasErrors) {
        final List<dynamic> list = result.data['audiovisuals']['edges'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(AudiovisualModel.fromGraphqlObject(c['node']));
        });
      } else
        print(result.errors[0].message);
    } catch (e) {
      print(e);
    }
    return await new Future<List<AudiovisualModel>>(() => resultList);
  }

  Future<int> findAudiovisualCount(String category, {String genre}) async {
    int resultCount = -1;
    try {
      final GraphQLClient _client = await client();

      var options = genre != null
          ? QueryOptions(document: CFG.countAudiovisuales)
          : QueryOptions(document: CFG.countAudiovisualesByCategory);
      var variables = <String, dynamic>{'category': category};
      if (genre != null && genre.isNotEmpty) {
        await variables.putIfAbsent('genre', () => genre);
      }

      options.variables = variables;
      final QueryResult result = await _client.query(options);

      if (!result.hasErrors) {
        resultCount = result.data['objects']['findaudiovisual']['count'];
      } else
        print(result.errors[0].message);
    } catch (e) {
      print(e);
    }
    return await new Future<int>(() => resultCount);
  }

  createCategory(CategoryModel category) {}

  updateCategory(CategoryModel category) {}

  deleteCategory(String id) {}

  deleteAllCategory() {}
}
