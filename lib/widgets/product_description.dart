import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final double width;

  const ProductDescription({
    super.key,
    required this.width,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
          const Text(
            'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/dodoro_bus.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/dodoro_bus.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/dodoro_bus.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/dodoro_bus.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
