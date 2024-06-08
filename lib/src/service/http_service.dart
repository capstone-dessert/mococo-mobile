import 'dart:convert';
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
    Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    jsonData['image'] = imageResponse.bodyBytes;
    print(jsonData);
    var parsingData = Clothes.fromJson(jsonData);
    return parsingData;
  } else {
    throw Exception('Failed to load clothes');
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
    if (streamedResponse.statusCode == 200) {
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
    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
      print('Clothes added successfully!');
    } else {
      throw Exception('Failed to add clothes. Status code: ${streamedResponse.statusCode}');
    }
  } catch (e) {
    throw Exception('Error adding clothes: $e');
  }
}

Future<void> editClothes(int id, Map<String, dynamic> data) async{
  print(data);
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
    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
      print('Clothes edited successfully!');
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
        print('Clothes($id) deleted successfully!');
      } else {
        throw Exception('Failed to delete clothes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting clothes($id): $e');
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
  final response = await http.post(url, body:jsonEncode(data), headers: {"Content-Type": "application/json"});
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
    throw Exception('Failed to load search result: ${response.statusCode}');
  }
}

Future<CodiList> fetchCodiAll() async {
  final response = await http.get(Uri.parse('$server/api/outfit/all'));
  if (response.statusCode == 200) {
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
}

// TODO: [014] 코디 기록 상세 조회 - fetchCodi
Future<Codi> fetchCodi(int id) async {
  final response = await http.get(Uri.parse('$server/api/outfit/$id'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

    jsonData['image'] = "assets/images/tmp.png";
    print(jsonData["clothingItems"].length);
    for (int i = 0; i < jsonData["clothingItems"].length; i++) {
      var imageResponse = await http.get(Uri.parse('$server/api/clothing/image/$id'));
      jsonData["clothingItems"][i]['image'] = imageResponse.bodyBytes;
    }

    var parsingData = Codi.fromJson(jsonData);
    return parsingData;
  } else {
    throw Exception('Failed to load codi');
  }
}

// TODO: [013] 코디 기록 추가 - addCodi
Future<void> addCodi(Map<String, dynamic> data) async {
  data["date"] = DateFormat('yyyy-MM-dd').format(data['date']);

  final url = Uri.parse('$server/api/outfit/add');
  try {
    final response = await http.post(url, body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    if (response.statusCode ~/ 100 == 2) {
      print('Codi added successfully!');
    } else {
      throw Exception('Failed to adding codi. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error adding codi: $e');
  }
}

// TODO: [015] 코디 기록 수정 - editCodi
// TODO: [016] 코디 기록 삭제 - deleteCodi