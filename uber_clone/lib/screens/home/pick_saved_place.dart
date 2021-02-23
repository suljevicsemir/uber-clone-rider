import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/services/authentication_service.dart';

class PickSavedPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: ()  async{
          await Provider.of<AuthenticationService>(context, listen: false).signOutGoogle();
        },
        splashColor: Colors.grey,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  color: const Color(0xffededed),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.star, color: Colors.black,),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Choose a saved place', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
              Spacer(),
              Icon(Icons.keyboard_arrow_right_sharp, color: Colors.black, size: 35,)
            ],
          ),
        ),
      ),
    );
  }
}
