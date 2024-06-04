import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';

String server = dotenv.get('SERVER');

Future<ClothesList> fetchClothesAll() async {
  final response = await http.get(Uri.parse('$server/api/clothing/all'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = {};
    jsonData['list'] = jsonDecode(response.body);
    for (int i = 0; i < jsonData['list'].length; i++) {
      var id = jsonData['list'][i]['id'];
      var imageResponse = await http.get(Uri.parse('$server/api/clothing/image/$id'));
      jsonData['list'][i]['image'] = imageResponse.bodyBytes;
    }
    var parsingData = ClothesList.fromJson(jsonData);
    return parsingData;
  } else {
    throw Exception('Failed to load all clothes');
  }
}

Future<Clothes> fetchClothes(int id) async {
  final response = await http.get(Uri.parse('$server/api/clothing/$id'));
  final imageResponse = await http.get(Uri.parse('$server/api/clothing/image/$id'));
  if (response.statusCode == 200 && imageResponse.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['image'] = imageResponse.bodyBytes;
    var parsingData = Clothes.fromJson(jsonData);
    return parsingData;
  } else {
    throw Exception('Failed to load clothes');
  }
}