import 'package:flutter/material.dart';
import 'package:languagetranslator/language_translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Langyage translator',
      debugShowCheckedModeBanner: false,

      home: LanguageTranslation(),
    );
  }
}
