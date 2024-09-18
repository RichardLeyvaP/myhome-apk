import 'package:flutter/material.dart';
import 'package:myhome/ui/pages/rol-admin/product/additionalDataPage.dart';
import 'package:myhome/ui/pages/rol-admin/product/categoryPricePage.dart';
import 'package:myhome/ui/pages/rol-admin/product/dateTimePage.dart';
import 'package:myhome/ui/pages/rol-admin/product/startProductPage.dart';
import 'package:myhome/ui/pages/rol-admin/product/statusProductPage.dart';

class ProductCreation extends StatefulWidget {
  @override
  _ProductCreationState createState() => _ProductCreationState();
}

class _ProductCreationState extends State<ProductCreation> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        children: [
          //1 Página
          StartProductPage(pageController: _pageController),
          //2 Página
          CategoryPricePage(pageController: _pageController),
          //4 Página
          StatusPage(pageController: _pageController),
          //7 Página
          AdditionalDataPage(pageController: _pageController),
          //7 Página
          DateTimePage(pageController: _pageController),
        ],
      ),
    );
  }
}
