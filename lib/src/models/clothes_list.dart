import 'package:mococo_mobile/src/models/clothes_preview.dart';

import 'clothes.dart';

class ClothesList {
  final List<ClothesPreview> list;
  final List<Clothes> listAll;

  const ClothesList({
    required this.list,
    required this.listAll
  });

  factory ClothesList.fromJson(Map<String, dynamic> json) {
    if (json['list'] == []) {
      return const ClothesList(list: [], listAll: []);
    } else {
      return ClothesList(
        list: (json['list'] as List<dynamic>)
          .map((e) => ClothesPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
        listAll: (json['list'] as List<dynamic>)
            .map((e) => Clothes.fromJson(e as Map<String, dynamic>))
            .toList());
    }
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list,
      'listAll': listAll,
    };

  ClothesPreview? getClothesPreviewById(int id) {
    for (var item in list) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Clothes? getClothesById(int id) {
    for (var item in listAll) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}