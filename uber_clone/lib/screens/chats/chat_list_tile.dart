import 'package:flutter/material.dart';

class ChatListTile extends StatefulWidget {
  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ( ) async => await Navigator.pushNamed(context, '/chat'),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        onPrimary: Colors.grey[800],

      ),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/person_avatar.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shenaid', style: Theme.of(context).textTheme.headline2,),
                  SizedBox(height: 10,),
                  Text('Necu zalomit', style: Theme.of(context).textTheme.headline1,)
                ],
              ),
            ),
            Spacer(),
            Text('0:16', style: Theme.of(context).textTheme.headline1,)
          ],
        ),
      ),
    );
  }
}
