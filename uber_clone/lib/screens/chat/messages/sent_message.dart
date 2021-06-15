import 'package:flutter/material.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/models/message.dart';
@immutable
 class SentMessage extends StatelessWidget{

  const SentMessage({
    required  this.message
  });

  final Message message;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          margin: EdgeInsets.only(right: 10, bottom: 3),
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
              SizedBox(width: 5,),
              Text(app.formatMessageTime(message.timestamp), style: TextStyle(fontSize: 11),)
            ],
          )
        ),
      ],
    );
  }
}
