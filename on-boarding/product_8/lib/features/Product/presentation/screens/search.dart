import 'package:flutter/material.dart';

import '../product_data.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton.outlined(
            color: Colors.white,
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  width: 0,
                  color: Colors.white,
                )),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF3F51F3),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Search Product',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3E3E3E),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: Column(
          children: [
            const MySearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: products[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
