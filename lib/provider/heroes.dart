import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:marver_list/models/marvel_hero.dart';

import '../main.dart';

class Heroes extends ChangeNotifier {
  List<MarvelHero> _heroes = [];
  List<MarvelHero> get heroes => _heroes;

  Future<void> fetchFromCache() async {
    final List<MarvelHero> loadedHeroes = [];
    final jsonCache = await Hive.box(API_BOX).get("heroes", defaultValue: []);

    if (jsonCache.isNotEmpty) {
      List<dynamic> heroesCache = await json.decode(jsonCache);
      if (heroesCache.isNotEmpty) {
        for (var value in heroesCache) {
          loadedHeroes.add(MarvelHero.fromJson(value));
        }
        _heroes = loadedHeroes;
        notifyListeners();
      }
    } else {
      await _fetchFromInternet();
    }
  }

  Future<void> _fetchFromInternet() async {
    final List<MarvelHero> loadedHeroes = [];
    final url = Uri.parse('https://www.simplifiedcoding.net/demos/marvel');
    final res = await http.get(url);
    if (res.statusCode != 200) return;

    final data = await json.decode(res.body) as List<dynamic>;
    if (data == null) return;

    Hive.box(API_BOX).put("heroes", res.body);

    // Create list of heroes from json
    for (var value in data) {
      loadedHeroes.add(MarvelHero.fromJson(value));
    }
    _heroes = loadedHeroes;
    notifyListeners();
  }
}
