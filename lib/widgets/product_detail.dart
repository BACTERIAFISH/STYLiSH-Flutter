import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UNIQLO 特級極輕羽絨外套',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '2023032101',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: const Text(
              'NT\$ 323',
              style: TextStyle(
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
                    itemCount: 2,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: GestureDetector(
                          child: Container(
                            color: Colors.green,
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
                    itemCount: 3,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text('S'),
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
                Text(
                  '數量',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansTC',
                  ),
                ),
                SizedBox(
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
                backgroundColor: Color(0xFF3F3A3A),
                elevation: 2,
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(),
              ),
              onPressed: () {},
              child: const Text(
                '請選擇尺寸',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const Text(
            '實品顏色依單品照為主',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '棉 100%',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '厚薄：薄',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '彈性：無',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '素材產地 / 日本',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
          const Text(
            '加工產地 / 中國',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansTC',
            ),
          ),
        ],
      ),
    );
  }
}
