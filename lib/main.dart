import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import '../service/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STYLiSH',
      theme: ThemeData(
        fontFamily: 'NotoSansTC',
      ),
      home: HomePage(productRepository: ProductRepository()),
    );
  }
}
