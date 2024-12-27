import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    super.key,
    required ValueNotifier<bool> isButton1ActiveNotifier,
    required ValueNotifier<bool> isButton2ActiveNotifier,
  })  : _isButton1ActiveNotifier = isButton1ActiveNotifier,
        _isButton2ActiveNotifier = isButton2ActiveNotifier;

  final ValueNotifier<bool> _isButton1ActiveNotifier;
  final ValueNotifier<bool> _isButton2ActiveNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        SizedBox(
          width: 108,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isButton1ActiveNotifier,
            builder: (context, isButton1Active, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButton1Active
                      ? Colors.blue.shade400
                      : Colors.blue.shade600,
                ),
                onPressed: () {
                  _isButton1ActiveNotifier.value = true;
                  _isButton2ActiveNotifier.value = false;
                },
                child: Text('Today'),
              );
            },
          ),
        ),
        SizedBox(
          width: 134,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isButton2ActiveNotifier,
            builder: (context, isButton2Active, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButton2Active
                      ? Colors.blue.shade400
                      : Colors.blue.shade600,
                ),
                onPressed: () {
                  _isButton2ActiveNotifier.value = true;
                  _isButton1ActiveNotifier.value = false;
                },
                child: Text('Next Days'),
              );
            },
          ),
        ),
      ],
    );
  }
}
