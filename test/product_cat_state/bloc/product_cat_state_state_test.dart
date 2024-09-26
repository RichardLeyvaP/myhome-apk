// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/bloc.dart';

void main() {
  group('ProductCatStateState', () {
    test('supports value equality', () {
      expect(
        ProductCatStateState(),
        equals(
          const ProductCatStateState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ProductCatStateState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const productCatStateState = ProductCatStateState(
            customProperty: 'My property',
          );
          expect(
            productCatStateState.copyWith(),
            equals(productCatStateState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const productCatStateState = ProductCatStateState(
            customProperty: 'My property',
          );
          final otherProductCatStateState = ProductCatStateState(
            customProperty: 'My property 2',
          );
          expect(productCatStateState, isNot(equals(otherProductCatStateState)));

          expect(
            productCatStateState.copyWith(
              customProperty: otherProductCatStateState.customProperty,
            ),
            equals(otherProductCatStateState),
          );
        },
      );
    });
  });
}
