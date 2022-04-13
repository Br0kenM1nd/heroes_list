import 'package:flutter/material.dart';
import 'package:marver_list/provider/heroes.dart';
import 'package:marver_list/widgets/hero_widget.dart';
import 'package:provider/provider.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({Key? key}) : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  @override
  Widget build(BuildContext context) {
    final heroesList = Provider.of<Heroes>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: heroesList.fetchFromCache(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (heroesList.heroes.isNotEmpty) {
            // ListView является аналогом RecyclerView
            return ListView.builder(
              itemCount: heroesList.heroes.length,
              itemBuilder: (ctx, i) => HeroWidget(heroesList.heroes[i]),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(
              child: Text('Oh no! Unknown error occurred'),
            );
          }
        },
      ),
    );
  }
}
