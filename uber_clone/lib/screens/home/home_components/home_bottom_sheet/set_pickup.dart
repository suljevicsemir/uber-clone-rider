

import 'package:flutter/material.dart';

class SetPickup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0)
            )
          )
        ),
        onPressed: () => Navigator.pushNamed(context, '/pickup'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Set pickup time', style: TextStyle(fontSize: 22),)
          ],
        ),
      ),
    );
  }
}
