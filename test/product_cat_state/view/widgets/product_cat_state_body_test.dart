// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myhome/domain/blocs/product_cat_state/product_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductCatStateBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ProductCatStateBloc(),
          child: MaterialApp(home: ProductCatStateBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
