import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDetailsCard extends StatelessWidget {
  const CustomDetailsCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leadingIcon,
  });
  final String title;
  final String subTitle;
  final SvgPicture leadingIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      width: 326,
      child: Card(
        color: Colors.blue.shade500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: leadingIcon,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
