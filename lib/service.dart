import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String wasHereKey = 'KEY_WAS_HERE_BEFORE';

  Future<bool> wasHereBefore() async {
    final SharedPreferences prefs = await _prefs;
    bool wasHere = false;
    if (prefs.containsKey(wasHereKey)) {
      wasHere = prefs.getBool(wasHereKey);
    }

    return await new Future<bool>(() => wasHere);
  }

  Future<void> setWasHereBefore() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(wasHereKey, true);
  }
}

class FavoriteService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String favsKey = 'KEY_FAVORITE';

  Future<List<String>> getFavouriteList() async {
    final SharedPreferences prefs = await _prefs;
    List<String> tempList = List<String>();
    if (prefs.containsKey(favsKey)) {
      tempList = prefs.getStringList(favsKey);
    }

    return await new Future<List<String>>(() => tempList);
  }

  Future<bool> isFav(String id) async {
    final SharedPreferences prefs = await _prefs;
    bool fav = false;
    if (prefs.containsKey(favsKey)) {
      var favList = prefs.getStringList(favsKey);
      if (favList != null && favList.isNotEmpty) {
        fav = favList.contains(id);
      }
    }

    return await new Future<bool>(() => fav);
  }

  Future<bool> addFavorite(String id) async {
    final SharedPreferences prefs = await _prefs;
    var favList = List<String>();
    if (prefs.containsKey(favsKey)) {
      favList = prefs.getStringList(favsKey);
    }
    if (favList != null && !favList.contains(id)) {
      favList.add(id);
    }
    await prefs.setStringList(favsKey, favList);
    return new Future<bool>(() => true);
  }

  Future<bool> removeFavorite(String id) async {
    final SharedPreferences prefs = await _prefs;
    var favList = List();
    if (prefs.containsKey(favsKey)) {
      favList = prefs.getStringList(favsKey);
      if (favList != null && favList.isNotEmpty && favList.contains(id)) {
        favList.remove(id);
      }
    }
    await prefs.setStringList(favsKey, favList);
    return new Future<bool>(() => false);
  }
}

  const String USERNAME_KEY = 'KEY_USER';
  const String TOKEN_KEY = 'KEY_TOKEN';
  const String EMAIL_KEY = 'KEY_EMAIL';
  const String PASSWORD_KEY = 'PASSWORD_KEY';

class LoginService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    String result;
    try {
      result = prefs.getString(key);
    } catch (e) {}
    return await new Future<String>(() => result);
  }

  Future setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future clearLoginData() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(USERNAME_KEY);
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(EMAIL_KEY);
    await prefs.remove(PASSWORD_KEY);
  }
}
