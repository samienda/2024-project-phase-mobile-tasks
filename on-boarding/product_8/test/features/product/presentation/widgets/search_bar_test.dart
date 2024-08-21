import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/presentation/widgets/search_bar.dart';

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
        home: Scaffold(
          body: body,
        ),
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
    'should render the search bar properly',
    (tester) async {
      await tester.pumpWidget(_makeTestableWidget(const MySearchBar()));

      final textField = find.byKey(const Key('search_text_field'));
      print(textField);

      expect(textField, findsOneWidget);
    },
  );

  testWidgets(
    'should render the bottom bar properly',
    (tester) async {
      await tester.pumpWidget(_makeTestableWidget(const MySearchBar()));

      final filterButton =
          await find.byKey(const Key('filter_button_in_search'));
      await tester.ensureVisible(filterButton);
      print(filterButton);

      await tester.tap(filterButton);

      await const Duration(microseconds: 1000000);

      final textFormField = find.byType(Form);

      print(textFormField);
      // expect(textFormField, findsOneWidget);
    },
  );
}
