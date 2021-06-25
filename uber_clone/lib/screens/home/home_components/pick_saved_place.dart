import 'package:flutter/material.dart';


class PickSavedPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async{
          //UserData x = await SecureStorage.loadUser();
          //print(x);
        },
        splashColor: Colors.grey,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  color: const Color(0xffededed),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.star, color: Colors.black,),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Choose a saved place', style: TextStyle(fontSize: 24),)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.keyboard_arrow_right_sharp, color: Colors.black, size: 35,))
            ],
          ),
        ),
      ),
    );
  }
}
