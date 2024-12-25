import 'package:flutter/material.dart';

class CustomDescriptionDisplay extends StatelessWidget {
  const CustomDescriptionDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Partly Cloud - H:17 L:4',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
