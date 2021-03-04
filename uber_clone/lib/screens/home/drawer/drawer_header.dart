import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/authentication_service.dart';


class HomeDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<AuthenticationService>(context, listen:false).userData;
    return Container(
      color: Colors.black,
      child: DrawerHeader(
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
                        backgroundImage: NetworkImage(userData.profilePicture),
                        backgroundColor: Colors.transparent,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                          child: RichText(
                            text: TextSpan(
                              text: userData.firstName,
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan( text: ' ' + userData.lastName)
                              ]
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Divider(color: Colors.grey, height: 1,),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async => await Navigator.pushNamed(context, '/chats'),
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
      ),
    );
  }
}
