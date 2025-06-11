import 'package:hive/hive.dart';

part 'hero_model.g.dart';
@HiveType(typeId: 0)
class HeroModel {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? gender;
  @HiveField(3)
  bool? favorite;
  @HiveField(4)
  int? id;
  @HiveField(5)
  String key = '';


  HeroModel({
    this.image,
    this.name,
    this.gender,
    this.id,
    this.favorite,
  });

  HeroModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    gender = json['gender'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['id'] = this.id;
    return data;
  }
}