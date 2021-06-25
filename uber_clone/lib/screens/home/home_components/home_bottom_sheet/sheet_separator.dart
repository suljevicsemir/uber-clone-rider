

import 'package:flutter/material.dart';

class SheetSeparator extends StatelessWidget {

  final bool hasMargin;

  SheetSeparator({required this.hasMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasMargin ? EdgeInsets.symmetric(horizontal: 25) : null,
      height: 0.5,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
