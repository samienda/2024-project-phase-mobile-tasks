
import 'package:flutter/material.dart';
import 'package:product_6/add_and_update.dart';
import 'package:product_6/detail.dart';
import 'package:product_6/home.dart';
import 'package:product_6/search.dart';

void main() {
  runApp(
    MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/details': (context) => const DetailPage(),
        '/add_product': (context) => const AddProduct(),
        '/search': (context) => const Search(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
