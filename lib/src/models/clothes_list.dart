import 'package:mococo_mobile/src/models/clothes.dart';

class ClothesList {
  final List<Clothes>? list;

  const ClothesList({
    required this.list
  });

  factory ClothesList.fromJson(Map<String, dynamic> json) {
    return ClothesList(
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => Clothes.fromJson(e as Map<String, dynamic>))
            .toList()
    );
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list
    };
}