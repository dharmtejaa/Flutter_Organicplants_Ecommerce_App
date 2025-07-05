import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:organicplants/models/all_plants_model.dart';


// base url for the API
String baseUrl = 'https://organicplants143.web.app/json_files/';

/// class to get the data from the API
class Plantservices {
  /// function to get the data of all plants
  /// from the API

  static Future<List<AllPlantsModel>> loadAllPlantsApi() async {
    final allPlantsResponse = await http.get(
      Uri.parse('${baseUrl}all_plants.json'),
    );
    if (allPlantsResponse.statusCode == 200) {
      List<dynamic> allPlantsList = json.decode(allPlantsResponse.body);
      return allPlantsList.map((e) => AllPlantsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to Load plants data');
    }
  }
}
