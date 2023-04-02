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
      body: Center(child: Text('TEST')),
    );
  }
}
