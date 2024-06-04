import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

Future<Map<String, dynamic>> classifyImage(XFile imageFile) async {
  final url = Uri.parse('$server/api/image/classify');
  var request = http.MultipartRequest('POST', url);

  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile('file', stream, length, filename: imageFile.name);

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseData = {};
      responseData['primaryCategory'] = responseBody;
      return responseData;
    } else {
      throw Exception('Failed to classify image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error classifying image: $e');
  }
}

// TODO: [002] 의류 등록 - addClothes
// void addClothes(Map<String, dynamic> data) {
//   http.post(Uri.parse('$server/api/clothing/add'), headers: {'Content-Type': 'multipart/form-data'}, body: );
// }

// TODO: [004] 의류 정보 수정 - editClothes
// TODO: [006][007] 의류 삭제 - deleteClothes
// TODO: [008] 의류 검색 - searchClothes

// TODO: [011] 코디 기록 전체 조회 - fetchAllCodi
// TODO: [012] 코디 기록 날짜별 조회 - ?
// TODO: [013] 코디 기록 - addCodi
// TODO: [014] 코디 기록 상세 조회 - fetchCodi
// TODO: [015] 코디 기록 삭제 - deleteCodi