import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/chats_provider.dart';
class Chat extends StatefulWidget {

  static const route = '/chat';

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {


  Stream stream;
  DocumentSnapshot snapshot;


  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('messages').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('John'),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {})
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).viewInsets.bottom + 96,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: Provider.of<ChatsProvider>(context).getChat('userId'),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Text('There are no messages'),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(

                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) => Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                //color: Colors.blue,
                  border: Border(
                      top: BorderSide(
                          width: 0.5,
                          color: Colors.grey
                      )
                  )
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            child: TextField(
                              onTap: () => {},
                              //controller: _textFieldController,
                              decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 19),
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 3)
                                  ),
                                  enabledBorder: InputBorder.none
                              ),
                              cursorColor: Colors.yellow,
                              cursorHeight: 26,
                              cursorWidth: 2,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          child: IconButton(
                              splashColor: Colors.red,
                              splashRadius: 25,
                              padding: EdgeInsets.all(8),
                              color: Colors.yellow,
                              onPressed: () {},
                              icon: Icon(Icons.send)
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(Icons.animation),
                        ),
                        IconButton(icon: Icon(Icons.ac_unit), onPressed: () {})
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
