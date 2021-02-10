import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
        left: 10.0,
        top: 10.0,
        child: ClipOval(
          child: Material(
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.black,
              child: SizedBox(
                height: 45,
                width: 45,
                child: Icon(Icons.menu, size: 25,),
              ),
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        )
    );
  }
}
