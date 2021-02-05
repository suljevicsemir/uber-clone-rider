
import 'package:flutter/material.dart';

class LoginTypePicker extends StatefulWidget {
  @override
  _LoginTypePickerState createState() => _LoginTypePickerState();
}

class _LoginTypePickerState extends State<LoginTypePicker> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Text('Enter your mobile number'),
              Row(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.red,
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                  Text('+387'),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: TextField()),
                  )
                ],
              ),
              Text('Or connect with social'),
              Spacer(),
              Text('By continuing you may receive an SMS for verification. Message and data rates may apply.'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTypePicker()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: 8, bottom: 8))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text('Next', style: TextStyle(color: Colors.white, fontSize: 22),),
                    Spacer(),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
