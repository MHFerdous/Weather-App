import 'package:flutter/material.dart';

class CustomDescriptionDisplay extends StatefulWidget {
  const CustomDescriptionDisplay({
    super.key, required this.description,
  });
  final String description;

  @override
  State<CustomDescriptionDisplay> createState() => _CustomDescriptionDisplayState();
}

class _CustomDescriptionDisplayState extends State<CustomDescriptionDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.description,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
