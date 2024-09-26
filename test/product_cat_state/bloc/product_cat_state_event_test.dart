// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/bloc.dart';

void main() {
  group('ProductCatStateEvent', () {
    group('CustomProductCatStateEvent', () {
      test('supports value equality', () {
        expect(
          CustomProductCatStateEvent(),
          equals(const CustomProductCatStateEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(const CustomProductCatStateEvent(), isNotNull);
      });
    });
  });
}
