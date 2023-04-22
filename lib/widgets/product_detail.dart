import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required Product product,
  }) : _product = product;

  final Product _product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  static const platformTest = MethodChannel('stylish/test');

  int amount = 1;
  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';
  String _testString = '';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getTestString() async {
    String testString;
    try {
      testString = await platformTest.invokeMethod('getTestString');
      final String testString2 = await platformTest.invokeMethod('getTestString2');
      testString += ' $testString2';
    } on PlatformException catch (e) {
      testString = e.message ?? '';
    }

    setState(() {
      _testString = testString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget._product.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            '${widget._product.id}',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              'NT\$ ${widget._product.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSansTC',
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                const Text(
                  '顏色',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansTC',
                  ),
                ),
                const VerticalDivider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget._product.colors.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: GestureDetector(
                          child: Container(
                            color: Color(int.parse(
                                'FF${widget._product.colors[index].code}',
                                radix: 16)),
                            width: 20,
                            height: 20,
                          ),
                          onTap: () {
                            print('color: $index');
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                const Text(
                  '尺寸',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansTC',
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget._product.sizes.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(widget._product.sizes[index]),
                          selected: false,
                          onSelected: (value) {
                            print('size $index');
                          },
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                const Text(
                  '數量',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansTC',
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (amount > 1) {
                                amount -= 1;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove_circle),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: TextEditingController(text: '$amount'),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 20),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          autocorrect: false,
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              amount += 1;
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ElevatedButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF3F3A3A),
                elevation: 2,
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                print('send platform channel');
                _getTestString();
              },
              child: Text(
                _testString,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Text(
            widget._product.note,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            widget._product.texture,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            widget._product.wash,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            widget._product.description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            '素材產地 / ${widget._product.place}',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Text(
            '加工產地 / ${widget._product.place}',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
        ],
      ),
    );
  }
}
