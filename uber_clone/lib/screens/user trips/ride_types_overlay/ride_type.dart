import 'package:flutter/material.dart';

class RideType extends StatelessWidget {

  final String rideType;
  RideType({@required this.rideType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      splashColor: Colors.grey,
      child: Container(
        //width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),

        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(rideType),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(Icons.check))
            ],
          ),
        ),
      ),
    );
  }
}



