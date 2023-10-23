import 'package:flutter/material.dart';

class UnSelectedOption extends StatelessWidget {
  final String unSelectedtitle;

  const UnSelectedOption({super.key, required this.unSelectedtitle});

  @override
  Widget build(BuildContext context) {
    return Text(unSelectedtitle);
  }
}
