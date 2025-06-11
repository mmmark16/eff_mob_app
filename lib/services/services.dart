import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../global.dart';
import '../models/hero_model.dart';

Future getHero() async{
  var dio = Dio();
  try {
    var response = await dio.get(
      "https://rickandmortyapi.com/api/character",
    );
    if (response.statusCode == 200) {
      final _json = response.data;
      allPageHero = List<HeroModel>.from(
          _json['results'].map((model) => HeroModel.fromJson(model)));

      return "success";
    }
  } on DioException catch (e) {
    print("getPerson fail " +
        DateTime.now().toString() +
        " reason " +
        e.message.toString());
    return "error" + (e.message ?? "");
  }
}
