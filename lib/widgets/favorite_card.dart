import 'package:eff_mob_app/models/hero_model.dart';
import 'package:eff_mob_app/services/boxes.dart';
import 'package:flutter/material.dart';
import '../global.dart';

class FavoriteCard extends StatefulWidget {
  FavoriteCard({
    super.key,
    required this.image,
    required this.name,
    required this.gender,
    required this.favorite,
    required this.id,
  });

  final String image;
  final String name;
  final String gender;
  bool favorite;
  final int id;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: isBlack ? Colors.blueGrey : Color.fromRGBO(135, 206, 250, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.image != null
                ? Image.network(
                    widget.image ?? "",
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 3.5,
                  )
                : Image.asset("assets/default.png"),
            Column(
              children: [
                Text(
                  'Имя персонажа:',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  widget.name ?? "Ошибка получения данных",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text('Гендер', style: Theme.of(context).textTheme.displayLarge),
                Text(
                  widget.gender ?? "Ошибка получения данных",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text('swipe to delete', style: TextStyle(fontSize: 12),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
