import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marver_list/pages/heroes_page.dart';
import 'package:marver_list/provider/heroes.dart';
import 'package:provider/provider.dart';

const String API_BOX = 'api_data';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(API_BOX);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Heroes())],
      child: const MarvelListApp(),
    ),
  );
}

class MarvelListApp extends StatelessWidget {
  const MarvelListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeroesPage(),
    );
  }
}
