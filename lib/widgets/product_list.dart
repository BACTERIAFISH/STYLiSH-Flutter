import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../pages/detail_page.dart';
import '../models/product_model.dart';

class ProductList extends StatelessWidget {
  final List<Product> _products;
  final bool _isScrollable;

  const ProductList({
    super.key,
    required List<Product> products,
    required bool isScrollable,
  })  : _products = products,
        _isScrollable = isScrollable;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: !_isScrollable,
      physics: _isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        product: _products[index],
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _products[index].mainImage,
                        placeholder: (context, url) {
                          return Image.asset(
                            'assets/robot.png',
                            fit: BoxFit.fitWidth,
                          );
                        },
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_products[index].title),
                          Text('NT\$ ${_products[index].price}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
