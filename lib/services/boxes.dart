import 'package:hive/hive.dart';
import '../models/hero_model.dart';

class Boxes{
  static Box<HeroModel> getHero () =>
      Hive.box<HeroModel>('favHero');
  static Box<HeroModel> getcashHero () =>
      Hive.box<HeroModel>('cashHero');
}