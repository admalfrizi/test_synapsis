import 'package:flutter/material.dart';
import 'package:test_synapsis/presentation/details/DetailsSurveyScreen.dart';
import 'package:test_synapsis/presentation/home/ListSurveyScreen.dart';
import 'package:test_synapsis/presentation/login/LoginScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}
