import 'package:eff_mob_app/models/hero_model.dart';
import 'package:eff_mob_app/pages/main_page_with_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'global.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HeroModelAdapter());
  var box = await Hive.openBox<HeroModel>('favHero');
  var cashbox = await Hive.openBox<HeroModel>('cashHero');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: isBlack
            ? TextTheme(
          displayLarge: TextStyle(fontSize: 16, color: Colors.white),
          displayMedium: TextStyle(fontSize: 24, color: Colors.white),
        )
            : TextTheme(
            displayLarge: TextStyle(fontSize: 16, color: Colors.black),
            displayMedium: TextStyle(fontSize: 24, color: Colors.black)),
      ),
      home: MainPage(indexPage: 0,),
    );
  }
}
