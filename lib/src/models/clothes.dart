class Clothes {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;
  final String primaryCategory;
  final String subCategory;
  final Set colors;
  final Set detailTags;
  final int wearCount;
  final String? lastWornDate;

  const Clothes({
    required this.id,
    required this.image,
    required this.primaryCategory,
    required this.subCategory,
    required this.colors,
    required this.detailTags,
    required this.wearCount,
    required this.lastWornDate,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'] as int,
      image: json['image'],
      primaryCategory: json['primaryCategory'] as String,
      subCategory: json['subCategory'] as String,
      colors: json['colors'] as Set,
      detailTags: json['detailTags'] as Set,
      wearCount: json['wearCount'] as int,
      lastWornDate: json['wearCount'] == 0 ? null : json['lastWornDate'],
    );
  }


  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image': image,
      'primaryCategory': primaryCategory,
      'subCategory': subCategory,
      'colors': colors,
      'detailTags': detailTags,
      'wearCount': wearCount,
      'lastWornDate': lastWornDate,
    };
}