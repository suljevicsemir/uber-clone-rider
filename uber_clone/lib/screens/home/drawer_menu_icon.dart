import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
        left: 10.0,
        top: 40.0,
        child: ClipOval(
          child: Material(
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.black,
              child: SizedBox(
                height: 55,
                width: 55,
                child: Icon(Icons.menu, size: 30,),
              ),
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        )
    );
  }
}
