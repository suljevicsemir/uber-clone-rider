

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MockDriver {
  final String firstName, lastName, id, phoneNumber;

  MockDriver({@required this.firstName,@required this.lastName, @required this.id, @required this.phoneNumber});
  MockDriver.fromSnapshot(DocumentSnapshot snapshot):
      firstName = snapshot.get('firstName'),
      lastName = snapshot.get('lastName'),
      id = snapshot.id,
      phoneNumber = snapshot.get('phoneNumber');

  MockDriver.fromObject(MockDriver mockDriver):
      firstName = mockDriver.firstName,
      lastName = mockDriver.lastName,
      id = mockDriver.id,
      phoneNumber = mockDriver.phoneNumber;
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

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _drivers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async => await Navigator.pushNamed(context, '/driverProfile', arguments: MockDriver.fromObject(_drivers.elementAt(index))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10, bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_drivers.elementAt(index).firstName),
                    Text(' ' + _drivers.elementAt(index).lastName)
                  ],
                )
              ),
            ),
          );
        },
      ),
    );
  }

}