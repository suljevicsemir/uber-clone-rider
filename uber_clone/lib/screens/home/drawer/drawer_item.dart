import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {

  final String itemTitle;


  DrawerItem({this.itemTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.grey[900],
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(left: 20),
          child: Text(
              itemTitle, style: TextStyle(fontSize: 20)
          ),
        ),
      ),
    );
  }
}
