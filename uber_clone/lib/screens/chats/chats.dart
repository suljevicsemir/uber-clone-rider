import 'package:flutter/material.dart';
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/providers/chats_provider.dart';
import 'package:uber_clone/screens/chats/chat_list_tile.dart';
import 'package:uber_clone/services/driver_search_delegate.dart';
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
            onPressed: () => showSearch(context: context, delegate: DriverSearchDelegate()),
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
                return Center(
                    child: CircularProgressIndicator()
              );
              if( snapshot.data.docs.isEmpty) {
                return Center(
                  child: Text('You have no messages'),
                );
              }
              return Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 0.0,),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => snapshot.data.docs[index].get('lastMessage') != '' ?  ChatListTile(chatInfo: ChatInfo.fromSnapshot(snapshot.data.docs[index])) : Container()
                ),
              );

            },
          )
        ),
      ),
    );
  }
}
