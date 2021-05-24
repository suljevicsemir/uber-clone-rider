import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/chat_info.dart';
import 'package:uber_clone/providers/chats_provider.dart';
import 'package:uber_clone/providers/profile_pictures_provider.dart';
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
    print('chats build called');
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
            builder: (context, AsyncSnapshot snapshot)  {
              if(snapshot.hasError)
                return Text('There was an error!');
              if(!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator()
              );
              if( snapshot.data.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/such_empty.jpg'),
                      SizedBox(height: 50,),
                      Text('Wow, such empty.', style: TextStyle(fontSize: 22, color: Colors.grey[700]),)
                    ],
                  ),
                );
              }

              List<String> driverIds = [];

              for(int i = 0; i < snapshot.data.docs.length; i++) {
                String id = snapshot.data.docs[i].get('firebaseUserId');
                if(Provider.of<ProfilePicturesProvider>(context, listen: false).driverProfilePictures![id] == null) {
                  driverIds.add(id);
                }
              }
              if(driverIds.length > 0) {
                SchedulerBinding.instance!.addPostFrameCallback((_) async {
                  await Provider.of<ProfilePicturesProvider>(
                      context, listen: false).getList(driverIds);
                });
              }
              return Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 0.0,),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return snapshot.data.docs[index].get('lastMessage') == '' ? Container() :
                    ChatListTile(chatInfo: ChatInfo.fromSnapshot(snapshot.data.docs[index]));
                  }
                ),
              );
            },
          )
        ),
      ),
    );
  }
}
