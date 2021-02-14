import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/services/authentication_service.dart';


class FoodItem {

  String x,y;

  FoodItem(String x, String y) {
    this.x = x;
    this.y = y;
  }
}


class HomeDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthenticationService>(context, listen: false).currentUser;
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),

        child: Container(
          margin: EdgeInsets.only( top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.photoURL),
                      backgroundColor: Colors.transparent,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(user.displayName, style: TextStyle(color: Colors.white),))
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Divider(color: Colors.grey, height: 1,),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text('Messages', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.0),),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Container(
                                color: Colors.blue,
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(Icons.keyboard_arrow_right, color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
