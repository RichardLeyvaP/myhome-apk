// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myhome/domain/blocs/product_cat_state/product_cat_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductCatStatePage', () {
    group('route', () {
      test('is routable', () {
        expect(ProductCatStatePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ProductCatStateView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ProductCatStatePage()));
      expect(find.byType(ProductCatStateView), findsOneWidget);
    });
  });
}
