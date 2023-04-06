import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> categories = ['女裝', '男裝', '配件'];
  List<bool> visibilities = [true, true, true];

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
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 320,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/dodoro_bus.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 767) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (visibilities[index]) {
                                      visibilities[index] = false;
                                    } else {
                                      visibilities[index] = true;
                                    }
                                  });
                                },
                                child: Text(
                                  categories[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Visibility(
                                visible: visibilities[index],
                                child: const ProductList(
                                  isScrollable: false,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  categories[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Expanded(
                                  child: ProductList(
                                    isScrollable: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  categories[1],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Expanded(
                                  child: ProductList(
                                    isScrollable: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  categories[2],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Expanded(
                                  child: ProductList(
                                    isScrollable: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final bool isScrollable;

  const ProductList({
    super.key,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailPage()),
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
                      child: Image.asset(
                        'assets/robot.png',
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
                        children: const [
                          Text('Uniqlo 特級極輕羽絨外套'),
                          Text('NT\$ 320'),
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
          return Padding(
            padding: const EdgeInsets.only(top: 32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 767) {
                  return Column(
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
                      Container(
                        width: 360,
                        padding:
                            const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                                    child: const Text('細部說明'),
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
                              style: TextStyle(fontSize: 12),
                            ),
                            Container(
                              height: 180,
                              margin: const EdgeInsets.only(top: 16),
                              child: Image.asset(
                                'assets/dodoro_bus.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 180,
                              margin: const EdgeInsets.only(top: 16),
                              child: Image.asset(
                                'assets/dodoro_bus.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 180,
                              margin: const EdgeInsets.only(top: 16),
                              child: Image.asset(
                                'assets/dodoro_bus.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 180,
                              margin: const EdgeInsets.only(top: 16),
                              child: Image.asset(
                                'assets/dodoro_bus.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Row(
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
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('UNIQLO 特級極輕羽絨外套'),
          const Text('2023032101'),
          const Text('NT\$ 323'),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                const Text('顏色'),
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
                const Text('尺寸'),
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
                Text('數量'),
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
                            print('minus');
                          },
                          icon: const Icon(Icons.remove_circle),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: TextEditingController(text: '1'),
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
                            print('plus');
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
          const Text('實品顏色依單品照為主'),
          const Text('棉 100%'),
          const Text('厚薄：薄'),
          const Text('彈性：無'),
          const Text('素材產地 / 日本'),
          const Text('加工產地 / 中國'),
        ],
      ),
    );
  }
}
