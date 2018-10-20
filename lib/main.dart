import 'package:flutter/material.dart';
import 'main_page.dart';
import 'global_config.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: GlobalConfig.themeData,
      home: new MainPage(title: '磁力搜'),
    );
  }
}
