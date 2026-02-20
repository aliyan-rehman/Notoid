import 'package:flutter/material.dart';
import 'package:notes_app/data/local/db_helper.dart';
import 'package:notes_app/db_provider.dart';
import 'package:notes_app/notes_home_page.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBProvider(dbhelper: DBHelper.getInstance),),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<ThemeProvider>().getThemeValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFF6F8F72)),
        primaryColor: Color(0xFF6F8F72),
        scaffoldBackgroundColor: Color(0xFFE8E2D8),

      ),

      debugShowCheckedModeBanner: false,
      home: NotesHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes App")),
      body: Container(),
    );
  }
}
