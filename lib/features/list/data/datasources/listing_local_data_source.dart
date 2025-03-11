import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_to_eclipse/core/services/storage/preferences.dart';

import '../models/picture_model.dart';

abstract class ListingLocalDataSourceContract {
  Future<void> store(List<PictureModel> pictures);
  Future<List<PictureModel>?> retrieve();
  Future< Preferences> getInstance();
}

class ListingLocalDataSource extends ListingLocalDataSourceContract {
  static const _preferencesKey = 'k_listing';

  @override
  Future< Preferences> getInstance()async{
      final provider = await SharedPreferences.getInstance();
     
     return   Preferences(provider);
  }

 

  
  @override
  Future<List<PictureModel>?> retrieve() async {
    final preferences = await getInstance();
    final stored = preferences.get<String>(_preferencesKey);
    if (stored == null || stored.isEmpty) {
      return null;
    }

    return (jsonDecode(stored) as List).map((e) => PictureModel.fromJson(e)).toList();
  }

  @override
  Future<void> store(List<PictureModel> pictures) async {
      final preferences = await getInstance();
    if (pictures.isEmpty) {
      return;
    }

    await preferences.set<String>(_preferencesKey, jsonEncode(pictures.map((e) => e.toJson()).toList()));
  }
}
