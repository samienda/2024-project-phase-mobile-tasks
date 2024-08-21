import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/presentation/widgets/product_card.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late MockProductBloc mockProductBloc;

  setUp(
    () {
      mockProductBloc = MockProductBloc();
      HttpOverrides.global = null;
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (context) => mockProductBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testProduct = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1724144139/images/ulnr7qrqzjy06w7qvyll.jpg',
  );

  testWidgets(
    'product card should display given data properly',
    (tester) async {
      await tester.pumpWidget(
          _makeTestableWidget(const ProductCard(product: testProduct)));

      final nameFinder = find.text(testProduct.name);
      final priceFinder = find.text('\$${testProduct.price}');
      final imageFinder = find.byType(
        CachedNetworkImage,
      );

      expect(nameFinder, findsOneWidget);
      expect(priceFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
    },
  );
}
