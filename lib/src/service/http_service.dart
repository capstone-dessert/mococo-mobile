import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/models/codi_list.dart';
import 'package:mococo_mobile/src/models/weather.dart';

String server = dotenv.get('SERVER');

Future<ClothesList> fetchClothesAll() async {
  try {
    final response = await http.get(Uri.parse('$server/api/clothing/all'));
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = {};
      jsonData['list'] = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < jsonData['list'].length; i++) {
        var id = jsonData['list'][i]['id'];
        var imageResponse = await http.get(
            Uri.parse('$server/api/clothing/image/$id'));
        jsonData['list'][i]['image'] = imageResponse.bodyBytes;
      }
      var parsingData = ClothesList.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load all clothes');
    }
  } catch (e) {
    throw Exception('Error fetching all clothes: $e');
  }
}

Future<Clothes> fetchClothes(int id) async {
  try {
    final response = await http.get(Uri.parse('$server/api/clothing/$id'));
    final imageResponse = await http.get(
        Uri.parse('$server/api/clothing/image/$id'));
    if (response.statusCode ~/ 100 == 2 && imageResponse.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = jsonDecode(
          utf8.decode(response.bodyBytes));
      jsonData['image'] = imageResponse.bodyBytes;
      var parsingData = Clothes.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load clothes');
    }
  } catch (e) {
    throw Exception('Error fetching clothes: $e');
  }
}

Future<Map<String, dynamic>> classifyImage(XFile imageFile) async {
  final url = Uri.parse('$server/api/image/classify');
  var request = http.MultipartRequest('POST', url);

  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile('file', stream, length, filename: imageFile.name);

  request.files.add(multipartFile);

  try {
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode ~/ 100 == 2) {
      var responseBody = await streamedResponse.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to classify image. Status code: ${streamedResponse.statusCode}');
    }
  } catch (e) {
    throw Exception('Error classifying image: $e');
  }
}

Future<void> addClothes(Map<String, dynamic> data) async{
  final url = Uri.parse('$server/api/clothing/add');

  var request = http.MultipartRequest('POST', url);

  request.fields['category'] = data['category'];
  request.fields['subcategory'] = data['subcategory'];

  List<String> colors = (data['colors'] as List).map((color) => color.toString()).toList();
  request.fields['colors'] = colors.join(',');

  List<String> styles = (data['styles'] as List).map((style) => style.toString()).toList();
  request.fields['styles'] = styles.join(',');

  List<String> tags = (data['tags'] as List).map((tag) => tag.toString()).toList();
  request.fields['tags'] = tags.join(',');

  XFile imageFile = data['image'] as XFile;
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile('image', stream, length, filename: imageFile.name);

  request.files.add(multipartFile);

  try {
    var streamedResponse = await request.send();
    streamedResponse.printInfo();
    if (streamedResponse.statusCode ~/ 100 == 2) {
      log('[SUCCESS] Clothes added successfully!');
    } else {
      throw Exception('Failed to add clothes. Status code: ${streamedResponse.statusCode}');
    }
  } catch (e) {
    throw Exception('Error adding clothes: $e');
  }
}

Future<void> editClothes(int id, Map<String, dynamic> data) async{
  final url = Uri.parse('$server/api/clothing/$id');

  var request = http.MultipartRequest('PUT', url);

  request.fields['category'] = data['category'];
  request.fields['subcategory'] = data['subcategory'];

  List<String> styles = (data['styles'] as List).map((style) => style.toString()).toList();
  request.fields['styles'] = styles.join(',');

  List<String> colors = (data['colors'] as List).map((color) => color.toString()).toList();
  request.fields['colors'] = colors.join(',');

  List<String> tags = (data['tags'] as List).map((tag) => tag.toString()).toList();
  request.fields['tags'] = tags.join(',');

  final tempDir = Directory.systemTemp;
  final tempPath = tempDir.path;
  final filePath = '$tempPath/temp_image.jpg';
  File(filePath).writeAsBytesSync(data['image']);

  var multipartFile = await http.MultipartFile.fromPath('image', filePath);

  request.files.add(multipartFile);

  try {
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode ~/ 100 == 2) {
      log('[SUCCESS] Clothes edited successfully!');
    } else {
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      throw Exception('Failed to edit clothes. Status code: ${streamedResponse.statusCode}');
    }
  } catch (e) {
    throw Exception('Error editing clothes: $e');
  }
}

Future<void> deleteClothes(List<int> idList) async {
  for (var id in idList) {
    try {
      var response = await http.delete(Uri.parse('$server/api/clothing/$id'));
      print(response.body);
      if (response.statusCode ~/ 100 == 2) {
        log('[SUCCESS] Clothes($id) deleted successfully!');
      } else {
        throw Exception('Failed to delete clothes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting clothes(id: $id): $e');
    }
  }
}

Future<ClothesList> searchClothes(Map<String, dynamic> selectedInfo) async {
  Map<String, dynamic> data = {};
  if (selectedInfo['category'] != null) {
    data["category"] = selectedInfo['category'];
  }
  if (selectedInfo['subcategory'] != null) {
    data["subcategory"] = selectedInfo['subcategory'];
  }
  if (selectedInfo['colors'] != null) {
    data["colors"] = selectedInfo['colors'];
  }
  if (selectedInfo['tags'] != null) {
    data["tags"] = selectedInfo['tags'];
  }

  final url = Uri.parse('$server/api/clothing/search');
  try {
    final response = await http.post(url, body: jsonEncode(data),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = {};
      jsonData['list'] = jsonDecode(response.body);
      for (int i = 0; i < jsonData['list'].length; i++) {
        var id = jsonData['list'][i]['id'];
        var imageResponse = await http.get(
            Uri.parse('$server/api/clothing/image/$id'));
        jsonData['list'][i]['image'] = imageResponse.bodyBytes;
      }
      var parsingData = ClothesList.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load search result: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error searching clothes: $e');
  }
}

Future<CodiList> fetchCodiAll() async {
  try {
    final response = await http.get(Uri.parse('$server/api/outfit/all'));
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = {};
      jsonData['list'] = jsonDecode(response.body);
      for (int i = 0; i < jsonData['list'].length; i++) {
        jsonData['list'][i]['image'] = "assets/images/tmp.png";
      }
      var parsingData = CodiList.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load all codis');
    }
  } catch (e) {
    throw Exception('Error fetching all codis: $e');
  }
}

Future<Codi> fetchCodi(int id) async {
  try {
    final response = await http.get(Uri.parse('$server/api/outfit/$id'));
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      jsonData['image'] = "assets/images/tmp.png";
      for (int i = 0; i < jsonData["clothingItems"].length; i++) {
        var imageResponse = await http.get(Uri.parse('$server/api/clothing/image/$id'));
        jsonData["clothingItems"][i]['image'] = imageResponse.bodyBytes;
      }

      var parsingData = Codi.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load codi');
    }
  } catch (e) {
    throw Exception('Error fetching codi: $e');
  }
}

Future<void> addCodi(Map<String, dynamic> data) async {
  data["date"] = DateFormat('yyyy-MM-dd').format(data['date']);

  final url = Uri.parse('$server/api/outfit/add');
  try {
    final response = await http.post(url, body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    if (response.statusCode ~/ 100 == 2) {
      log('[SUCCESS] Codi added successfully!');
    } else {
      throw Exception('Failed to adding codi. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error adding codi: $e');
  }
}

Future<void> editCodi(int id, Map<String, dynamic> data) async {
  data['id'] = id;
  data["date"] = DateFormat('yyyy-MM-dd').format(data['date']);

  final url = Uri.parse('$server/api/outfit/update');
  try {
    final response = await http.put(url, body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    if (response.statusCode ~/ 100 == 2) {
      log('[SUCCESS] Codi edited successfully!');
    } else {
      throw Exception('Failed to editing codi. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error editing codi: $e');
  }

}

Future<void> deleteCodi(int id) async {
  try {
    final response = await http.delete(Uri.parse('$server/api/outfit/$id'));
    if (response.statusCode ~/ 100 == 2) {
      log('[SUCCESS] Codi deleted successfully!');
    } else {
      throw Exception('Failed to delete codi. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error deleting codi: $e');
  }
}

Future<Weather> getWeatherByGeo(DateTime date, double latitude, double longitude) async {
  Map<String, dynamic> data = {
    'date': DateFormat('yyyy-MM-dd').format(date),
    'latitude': latitude,
    'longitude': longitude
  };
  final url = Uri.parse('$server/api/weather/geo');
  String queryString = Uri(queryParameters: data).query;

  try {
    var response = await http.get(Uri.parse('$url?$queryString'));
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      var parsingData = Weather.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to get weather. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error get weather: $e');
  }
}

Future<Weather> getWeatherByAddress(DateTime date, String address) async {
  Map<String, dynamic> data = {
    'date': DateFormat('yyyy-MM-dd').format(date),
    'address': address
  };
  final url = Uri.parse('$server/api/weather/address');
  String queryString = Uri(queryParameters: data).query;

  try {
    var response = await http.get(Uri.parse('$url?$queryString'));
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      var parsingData = Weather.fromJson(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to get weather. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error get weather: $e');
  }
}