import 'package:flutter/material.dart';

class UnSelectedTheme extends StatelessWidget {
  final String unSelectedtitle;

  const UnSelectedTheme({super.key, required this.unSelectedtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(unSelectedtitle),
        ],
      ),
    );
  }
}
