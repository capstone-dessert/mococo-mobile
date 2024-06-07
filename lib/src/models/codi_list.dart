import 'package:mococo_mobile/src/models/codi_preview.dart';

class CodiList {
  final List<CodiPreview> list;

  const CodiList({
    required this.list
  });

  factory CodiList.fromJson(Map<String, dynamic> json) {
    if (json['list'] == []) {
      return const CodiList(list: []);
    } else {
      return CodiList(
        list: (json['list'] as List<dynamic>)
          .map((e) => CodiPreview.fromJson(e as Map<String, dynamic>))
          .toList());
    }
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list
    };
}