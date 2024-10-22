// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:covid_app_new/Model/world_states_model.dart';
import 'package:http/http.dart' as http;

import 'Utilities/app_url.dart';

class StatesServices {
  Future<WorldStatesModel> worldStatesRecordsApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
