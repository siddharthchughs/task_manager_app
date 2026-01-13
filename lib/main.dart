import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/add_task/add_task_screen.dart';
import 'package:task_manager_app/pages/home_page.dart';

void main() async {
  //this step is for iinitlaizing the Hive in teh flutter app.
  await Hive.initFlutter('hive_boxes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePageScreen(),
        'add_task': (context) => AddTaskScreen(),
      },
    );
  }
}
