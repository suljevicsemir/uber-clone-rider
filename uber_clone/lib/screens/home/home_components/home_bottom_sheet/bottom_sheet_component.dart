

import 'package:flutter/material.dart';

class SheetComponent extends StatelessWidget {

  final String content;
  final bool isFirst;

  SheetComponent({required this.content, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.grey,
        child: Center(
          child: Text(content, style: TextStyle(fontSize: isFirst ? 30 : 24)),
        ),
      ),
    );
  }
}
