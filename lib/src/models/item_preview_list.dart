import 'package:mococo_mobile/src/models/item_preview.dart';

class ItemPreviewList {
  final List<ItemPreview>? list;

  const ItemPreviewList({
    required this.list
  });

  factory ItemPreviewList.fromJson(Map<String, dynamic> json) {
    return ItemPreviewList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => ItemPreview.fromJson(e as Map<String, dynamic>))
          .toList()
    );
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      'list': list
    };
}