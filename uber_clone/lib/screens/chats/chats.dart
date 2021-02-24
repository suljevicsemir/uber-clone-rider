import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/providers/chats_provider.dart';
import 'package:uber_clone/screens/chats/chat_list_tile.dart';
class Chats extends StatefulWidget {

  static const route = '/chats';
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {



  ChatsProvider provider = ChatsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: provider.chats,
            builder: (context, snapshot) {
              if(snapshot.hasError)
                return Text('There was an error!');
              if(!snapshot.hasData)
                return CircularProgressIndicator();
              return Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 0.0,),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot chatInfo = snapshot.data.docs[index];
                    return ChatListTile();
                  },
                ),
              );

            },
          )
        ),
      ),
    );
  }
}
