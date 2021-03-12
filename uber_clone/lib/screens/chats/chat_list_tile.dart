import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/providers/cached_data_provider.dart';

class ChatListTile extends StatefulWidget {


  final ChatInfo chatInfo;

  ChatListTile({@required this.chatInfo});

  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  File picture = Provider.of<CachedDataProvider>(context).driverPictures[widget.chatInfo.firebaseUserId];
  if(picture == null) {
    Provider.of<CachedDataProvider>(context, listen: false).storeDriverPicture(widget.chatInfo.firebaseUserId);
  }
  return picture == null ? Container() :
  ElevatedButton(
    onPressed: ( ) async => await Navigator.pushNamed(context, '/chat', arguments: widget.chatInfo),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(Provider.of<CachedDataProvider>(context, listen: false).driverPictures[widget.chatInfo.firebaseUserId])
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: widget.chatInfo.firstName,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan( text: ' ' + widget.chatInfo.lastName)
                        ]
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(widget.chatInfo.lastMessage, style: Theme.of(context).textTheme.headline1, overflow: TextOverflow.ellipsis,)
                ],
              ),
            ),
          ),
          Text(timeago.format(widget.chatInfo.lastMessageTimestamp.toDate(), locale: 'en_short'), style: Theme.of(context).textTheme.headline1,)
        ],
      ),
    ),
  );
  }


}
