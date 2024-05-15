import 'package:mococo_mobile/src/models/codi.dart';

class CodiList {
  final List<Codi>? list;

  const CodiList({
    required this.list
  });

  factory CodiList.fromJson(Map<String, dynamic> json) {
    return CodiList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => Codi.fromJson(e as Map<String, dynamic>))
          .toList()
    );
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list
    };

  Codi? getCodiById(int id) {
    if (list == null) return null;
    for (var item in list!) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}