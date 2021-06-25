
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/providers/user_data_provider.dart';
import 'package:uber_clone/screens/chat/chat.dart';
class ContactButtons extends StatelessWidget {

  final Driver driver;

  ContactButtons({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        MaterialButton(
          minWidth: 150,
          height: 50,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          onPressed: () async => app.callNumber(context, phoneNumber: driver.phoneNumber),
          child: Text('Phone call', style: TextStyle(color: Colors.white, fontSize: 16),),
          splashColor: Colors.white,
        ),
        Spacer(),
        MaterialButton(
          minWidth: 150,
          height: 50,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          onPressed: () async {
            Map<String, dynamic> map = {};
            map['driver'] = driver;
            map['user'] = Provider.of<UserDataProvider>(context, listen: false).userData;
            await Navigator.pushNamed(context, Chat.route, arguments: map);
          },
          child: Text('Send message', style: TextStyle(color: Colors.white, fontSize: 16),),
          splashColor: Colors.white,
        ),
        Spacer()
      ],
    );
  }
}
