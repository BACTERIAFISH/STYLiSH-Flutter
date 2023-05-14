import 'package:flutter/material.dart';
import 'ar_default_page.dart';

class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  List<String> titles = [
    'Default',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ARKit'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: titles.length,
        itemBuilder: (conext, index) {
          String title = titles[index];

          return Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 44,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Color(0xFF3F3A3A),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      switch (title) {
                        case 'Default':
                          return const ARDefaultPage();
                        default:
                          return const ARDefaultPage();
                      }
                    }),
                  );
                },
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
