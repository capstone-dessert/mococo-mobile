import 'package:mococo_mobile/src/models/clothes_preview.dart';

class ClothesList {
  final List<ClothesPreview> list;

  const ClothesList({
    required this.list
  });

  factory ClothesList.fromJson(Map<String, dynamic> json) {
    if (json['list'] == []) {
      return const ClothesList(list: []);
    } else {
      return ClothesList(
        list: (json['list'] as List<dynamic>)
          .map((e) => ClothesPreview.fromJson(e as Map<String, dynamic>))
          .toList());
    }
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list
    };

  ClothesPreview? getClothesPreviewById(int id) {
    for (var item in list) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}