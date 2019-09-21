import 'package:catalogo/graphql/queries.dart';
import 'package:catalogo/graphql/test/AudiovisualConstraints.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/service.dart';
import 'package:graphql/client.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

LoginService service = new LoginService();

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
    Parse().initialize(appId, '$parseUrl/parse', debug: true);
  }

  Future login(String user, String pass) async {
    try {
      var loginResult;
      var parseUser = ParseUser(user, pass, null);
      dynamic response = await parseUser.login();
      if (response.success) {
        loginResult = response.result;
        token = response.result.sessionToken;
      }

      return await new Future(() => loginResult);
    } catch (e) {
      print(e);
      return await new Future(() => null);
    }
  }

  Future signUp(String user, String pass, String email) async {
    try {
      var parseUser = ParseUser(user, pass, email) /*.create()*/;
      var response = await parseUser.signUp();
      var signResult;
      if (response.success) {
        signResult = response.result;
      }
      return await new Future(() => signResult);
    } catch (e) {
      print(e);
      return await new Future(() => null);
    }
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
          await service.clearLoginData();
        }
      }
      return await new Future<bool>(() => logoutResult);
    } catch (e) {
      print(e);
      return await new Future<bool>(() => false);
    }
  }

  Future<GraphQLClient> client() async {
    String myToken = await service.getString(TOKEN_KEY);

    final HttpLink _httpLink = HttpLink(
        uri: '$parseUrl/graphql',
        headers: <String, String>{
          'X-Parse-Application-Id': 'yourappid',
          'X-Parse-Session-Token': myToken
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

  Future<List<AudiovisualModel>> findAudiovisualList(int limit, int skip,
      String category, String genre, String title) async {
    List<AudiovisualModel> resultList = [];
    try {
      final GraphQLClient _client = await client();

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
        final List<dynamic> list = result.data['objects']['findaudiovisual']
        ['results'] as List<dynamic>;
        list.forEach((c) {
          resultList.add(AudiovisualModel.fromGraphqlObject(c));
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
