

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MockDriver {
  final String firstName, lastName;

  MockDriver({@required this.firstName,@required this.lastName});
  MockDriver.fromSnapshot(DocumentSnapshot snapshot):
      firstName = snapshot.get('firstName'),
      lastName = snapshot.get('lastName');
}


class DriverSearchDelegate extends SearchDelegate {


  List<MockDriver> _drivers = [];


  DriverSearchDelegate() {
   _load();
  }

  _load() async {

      _drivers = [];
      QuerySnapshot drivers = await FirebaseFirestore.instance.collection('drivers').get();
      var list = drivers.docs;
      for(int i = 0; i < list.length; i++) {
        _drivers.add(MockDriver.fromSnapshot(list.elementAt(i)));
      }
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () { query = "";},
        icon: Icon(Icons.close),
      )
    ];
  }



  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('What dis do?');
  }


  @override
  Widget buildSuggestions(BuildContext context ) {
    // TODO: implement buildSuggestions
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Colors.red,
      child: ListView.builder(
        itemCount: _drivers.length,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: [
                Text(_drivers.elementAt(index).firstName),
                Text(_drivers.elementAt(index).lastName)
              ],
            ),
          );
        },
      ),
    );
  }

}