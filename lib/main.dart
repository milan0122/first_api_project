import 'package:first_api/Get_Method/Complex_api.dart';
import 'package:first_api/Get_Method/home_screen.dart';
import 'package:first_api/Get_Method/photos_api.dart';
import 'package:first_api/Get_Method/user_api.dart';
import 'package:first_api/Get_Method/user_api2.dart';
import 'package:first_api/Post_method/login_page.dart';
import 'package:first_api/Post_method/singup_page.dart';
import 'package:first_api/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}

