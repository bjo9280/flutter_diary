import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'database/drift_database.dart';

import 'screens/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting();
  final database = LocalDatabase();
  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDiaryScreen(),
    );
  }
}
