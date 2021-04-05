import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DrawerItem extends StatelessWidget {

  final String itemTitle, route;

  DrawerItem({required this.itemTitle, required this.route});






  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.red
      ),
      child: Container(
        width: double.infinity,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, route),
          splashColor: Colors.grey[900],
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(left: 20),
            child: Text(
                itemTitle, style: TextStyle(fontSize: 20)
            ),
          ),
        ),
      ),
    );
  }
}
