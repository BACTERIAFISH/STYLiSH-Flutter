import 'package:flutter/material.dart';

import '../widgets/product_detail.dart';
import '../widgets/product_description.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/stylish_logo.png',
          width: 128,
        ),
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 767) {
                return Container(
                  width: 360,
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 360,
                        height: 500,
                        child: Image.asset(
                          'assets/robot.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ProductDetail(),
                      ),
                      ProductDescription(
                        width: 344,
                      )
                    ],
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 360,
                            height: 500,
                            child: Image.asset(
                              'assets/robot.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ProductDetail(),
                        ],
                      ),
                      ProductDescription(
                        width: 736,
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
