import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/product_detail.dart';
import '../widgets/product_description.dart';
import '../models/product_model.dart';
import '../pages/pay_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required Product product,
  }) : _product = product;

  final Product _product;

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const PayPage();
                }),
              );
            },
            icon: const Icon(
              Icons.payment,
              color: Colors.grey,
            ),
          ),
        ],
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 1,
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
                        child: CachedNetworkImage(
                          imageUrl: widget._product.mainImage,
                          placeholder: (context, url) {
                            return Image.asset(
                              'assets/robot.png',
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ProductDetail(
                          product: widget._product,
                        ),
                      ),
                      ProductDescription(
                        product: widget._product,
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
                            child: CachedNetworkImage(
                              imageUrl: widget._product.mainImage,
                              placeholder: (context, url) {
                                return Image.asset(
                                  'assets/robot.png',
                                  fit: BoxFit.cover,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          ProductDetail(
                            product: widget._product,
                          ),
                        ],
                      ),
                      ProductDescription(
                        product: widget._product,
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
