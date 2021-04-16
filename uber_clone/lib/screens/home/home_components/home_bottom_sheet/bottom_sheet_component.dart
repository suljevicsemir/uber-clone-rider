

import 'package:flutter/material.dart';

class SheetComponent extends StatefulWidget {

  final String content;
  final bool isFirst;

  SheetComponent({required this.content, required this.isFirst});

  @override
  _SheetComponentState createState() => _SheetComponentState();
}

class _SheetComponentState extends State<SheetComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            firstDate: DateTime(2015, 8, 8),
            lastDate: DateTime(2101, 10, 10),
            initialDate: DateTime.now()
          );


        },
        splashColor: Colors.grey,
        child: Center(
          child: Text(widget.content, style: TextStyle(fontSize: widget.isFirst ? 30 : 24)),
        ),
      ),
    );
  }
}
