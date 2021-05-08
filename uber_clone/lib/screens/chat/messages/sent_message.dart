import 'package:flutter/material.dart';
import 'package:uber_clone/models/driver.dart';
import 'package:uber_clone/models/message.dart';


@immutable
 class SentMessage extends StatelessWidget{

  const SentMessage({
    required  this.message,
    required  this.driver
  });

  final Message message;
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: EdgeInsets.only(right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xffc8e1fd),
            borderRadius: BorderRadius.circular(20)
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7
          ),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(message.message, style: TextStyle(color: Colors.black, fontSize: 16), maxLines: 3,),
              SizedBox(width: 10,),
              Text('15:13', style: TextStyle(fontSize: 12),)
            ],
          )
        ),

      ],
    );
  }
}