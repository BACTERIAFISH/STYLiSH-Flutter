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

  final _cardNumberNode = FocusNode();
  final _cardDueMonthNode = FocusNode();
  final _cardDueYearNode = FocusNode();
  final _cardCcvNode = FocusNode();

  final _cardNumberKey = GlobalKey<FormFieldState>();
  final _cardDueMonthKey = GlobalKey<FormFieldState>();
  final _cardDueYearKey = GlobalKey<FormFieldState>();
  final _cardCcvKey = GlobalKey<FormFieldState>();

  bool _isButtonEnabled = false;
  String _result = '';

  void _validateCardInformation() {
    bool isButtonEnabled = ((_cardNumberKey.currentState?.isValid ?? false) &&
        (_cardDueMonthKey.currentState?.isValid ?? false) &&
        (_cardDueYearKey.currentState?.isValid ?? false) &&
        (_cardCcvKey.currentState?.isValid ?? false));

    setState(() {
      _isButtonEnabled = isButtonEnabled;
    });
  }

  Future<void> _getPrime() async {
    Map<String, dynamic> card = {
      'number': _cardNumberKey.currentState?.value ?? '',
      'dueMonth': _cardDueMonthKey.currentState?.value ?? '',
      'dueYear': _cardDueYearKey.currentState?.value ?? '',
      'ccv': _cardCcvKey.currentState?.value ?? '',
    };

    String result;
    try {
      result = await platform.invokeMethod('getPrime', card);
    } on PlatformException catch (e) {
      result = e.message ?? '';
    }

    setState(() {
      _result = result;
    });
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: _cardNumberKey,
              focusNode: _cardNumberNode,
              decoration: const InputDecoration(
                icon: Icon(Icons.payment),
                hintText: '1234123412341234',
                labelText: 'Card Number',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateCardInformation();
              },
              onTapOutside: (_) {
                _cardNumberNode.unfocus();
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter card number';
                }

                if (value.length != 16) {
                  return 'Card number length is 16';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              key: _cardDueMonthKey,
              focusNode: _cardDueMonthNode,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month),
                hintText: '01',
                labelText: 'Due Month',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateCardInformation();
              },
              onTapOutside: (_) {
                _cardDueMonthNode.unfocus();
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter due month';
                }

                if (value.length != 2) {
                  return 'Card due month length is 2';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              key: _cardDueYearKey,
              focusNode: _cardDueYearNode,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month_outlined),
                hintText: '23',
                labelText: 'Due Year',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateCardInformation();
              },
              onTapOutside: (_) {
                _cardDueYearNode.unfocus();
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter due year';
                }

                if (value.length != 2) {
                  return 'Card due month length is 2';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              key: _cardCcvKey,
              focusNode: _cardCcvNode,
              decoration: const InputDecoration(
                icon: Icon(Icons.numbers),
                hintText: '111',
                labelText: 'CCV Number',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateCardInformation();
              },
              onTapOutside: (_) {
                _cardCcvNode.unfocus();
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter ccv number';
                }

                if (value.length != 3) {
                  return 'Card due month length is 3';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3A3A),
                  elevation: 2,
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: _isButtonEnabled
                    ? _getPrime
                    : null,
                child: const Text(
                  'Get Prime',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(_result),
            ),
          ],
        ),
      ),
    );
  }
}
