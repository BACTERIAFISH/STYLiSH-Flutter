import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayPage extends StatefulWidget {
  const PayPage({
    super.key,
  });

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  static const platform = MethodChannel('stylish/tappay');

  Future<void> _getPrime() async {
    String testString;
    try {
      testString = await platform.invokeMethod('getPrime');
    } on PlatformException catch (e) {
      testString = e.message ?? '';
    }

    print(testString);
    // setState(() {
    //   _testString = testString;
    // });
  }

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
      body: ElevatedButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF3F3A3A),
          elevation: 2,
          minimumSize: const Size(double.infinity, 60),
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: () {
          print('send platform channel');
          _getPrime();
        },
        child: Text(
          'Get Prime',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
