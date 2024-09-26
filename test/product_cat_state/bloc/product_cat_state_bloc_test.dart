// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/bloc.dart';

void main() {
  group('ProductCatStateBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ProductCatStateBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final productCatStateBloc = ProductCatStateBloc();
      expect(productCatStateBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ProductCatStateBloc, ProductCatStateState>(
      'CustomProductCatStateEvent emits nothing',
      build: ProductCatStateBloc.new,
      act: (bloc) => bloc.add(const CustomProductCatStateEvent()),
      expect: () => <ProductCatStateState>[],
    );
  });
}
