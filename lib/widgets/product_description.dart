import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product_model.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    super.key,
    required Product product,
    required double width,
  })  : _product = product,
        _width = width;

  final Product _product;
  final double _width;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFF4B39EF),
                        Color(0xFF39D2C0),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    '細部說明',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'NotoSansTC',
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            widget._product.story,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'NotoSansTC',
            ),
          ),
          ...widget._product.images.map((image) {
            return Container(
              margin: const EdgeInsets.only(top: 16),
              child: AspectRatio(
                aspectRatio: 2,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/dodoro_bus.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
