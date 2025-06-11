import 'package:eff_mob_app/models/hero_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../global.dart';
import '../services/boxes.dart';
import '../widgets/favorite_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Favorite Page"),
      ),
      body: ValueListenableBuilder<Box<HeroModel>>(
        valueListenable: Boxes.getHero().listenable(),
        builder: (context, Box<HeroModel> box, _) {
          if (box.values.isEmpty)
            return Center(
              child: Text("Избранных персонажей нет"),
            );
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              HeroModel res = box.getAt(index)!;
              return Dismissible(
                background: Container(color: Theme.of(context).scaffoldBackgroundColor),
                key: UniqueKey(),
                onDismissed: (direction) {
                  box.deleteAt(index);
                  allHeros[res!.id!-1].favorite = false;
                },
                child: FavoriteCard(image: res!.image!, name: res!.name!, gender: res!.gender!, favorite: res!.favorite!, id: res!.id!),
              );
            },
          );
        },
      ),
    );
  }
}

