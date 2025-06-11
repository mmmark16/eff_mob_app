import 'package:eff_mob_app/models/hero_model.dart';
import 'package:eff_mob_app/services/boxes.dart';
import 'package:flutter/material.dart';
import '../global.dart';

class HeroCard extends StatefulWidget {
  HeroCard({
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
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isBlack ? Colors.blueGrey : Color.fromRGBO(135, 206, 250, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 4, right: 4),
                  child: Container(
                    child: widget.image != null
                        ? Image.network(widget.image ?? "")
                        : Image.asset("assets/default.png"),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsetsGeometry.all(1),
                    onPressed: () async {
                      if (widget.favorite == false) {
                        widget.favorite = true;
                        allHeros[widget.id - 1].favorite = true;
                        final box = Boxes.getHero();
                        box.add(
                          HeroModel(
                            name: widget.name,
                            image: widget.image,
                            gender: widget.gender,
                            favorite: widget.favorite,
                            id: widget.id,
                          ),
                        );
                        setState(() {});
                      }
                    },
                    icon: widget.favorite
                        ? Icon(
                            Icons.star,
                            color: isBlack ? Colors.white : Colors.yellow,
                          )
                        : Icon(
                            Icons.star_border,
                            color: isBlack ? Colors.white : Colors.yellow,
                          ),
                  ),
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
