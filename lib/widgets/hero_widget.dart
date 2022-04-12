import 'package:flutter/material.dart';
import 'package:marver_list/models/marvel_hero.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroWidget extends StatelessWidget {
  final MarvelHero _hero;

  const HeroWidget(this._hero, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * .01;
    final picSize = size * 25;
    final fontSize = size * 8;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // CachedNetworkImage является аналогом Picasso
            CachedNetworkImage(
              width: picSize,
              height: picSize,
              fit: BoxFit.cover,
              imageUrl: _hero.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
            Expanded(
              child: Text(
                _hero.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
