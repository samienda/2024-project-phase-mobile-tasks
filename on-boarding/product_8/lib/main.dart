import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/Auth/presentation/screens/login.dart';
import 'features/Product/presentation/bloc/product_bloc.dart';
import 'features/Product/presentation/screens/add_product.dart';
import 'features/Product/presentation/screens/detail.dart';
import 'features/Product/presentation/screens/home.dart';
import 'features/Product/presentation/screens/landing.dart';
import 'features/Product/presentation/screens/search.dart';
import 'features/Product/presentation/screens/update_product.dart';
import 'features/Product/presentation/widgets/scroller.dart';
import 'injection_container.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.setupLocator();
  runApp(
    
    BlocProvider(
      create: (context) => sl.locator<ProductBloc>(),
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const Home(),
          '/login': (context) => const Login(),
          '/details': (context) => const DetailPage(),
          '/add_product': (context) => const AddProduct(),
          '/search': (context) => const Search(),
          '/update': (context) => const UpdateProduct(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),

    
  );
}
