import 'package:flutter/material.dart';

import 'features/Product/presentation/screens/add_and_update.dart';
import 'features/Product/presentation/screens/detail.dart';
import 'features/Product/presentation/screens/home.dart';
import 'features/Product/presentation/screens/search.dart';
import 'features/Product/presentation/widgets/scroller.dart';

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
