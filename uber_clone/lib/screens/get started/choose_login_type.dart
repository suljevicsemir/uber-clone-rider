import 'dart:io';

import 'package:flutter/material.dart';
class LoginTypePicker extends StatefulWidget {

  static const String route = '/pickLoginType';


  @override
  _LoginTypePickerState createState() => _LoginTypePickerState();
}

class _LoginTypePickerState extends State<LoginTypePicker> {

  final numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    print(Platform.localeName);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: Text('Enter your mobile number', style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w700, letterSpacing: 2))
                    ),
                    Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('icons/flags/png/ba.png', package: 'country_icons', scale: 2,),
                          Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                          Text('+387'),
                          Flexible(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  margin: EdgeInsets.only(left: 20,right: 20, bottom: 8),
                                  child: TextField(
                                    controller: numberController,
                                    cursorColor: Colors.black,
                                    scrollPadding: EdgeInsets.zero,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                            hintText: '061 123 456',

                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.black)
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.black, width: 3),
                                            )
                                        ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap: () {
                          Navigator.pushNamed(context, '/chooseAccount');
                      },
                      child: Row(
                        children: [
                          Text('Or connect with social', style: TextStyle(color: Colors.indigoAccent[700], fontWeight: FontWeight.w600),),
                          Icon(Icons.arrow_right_alt, color: Colors.indigoAccent[700], size: 34,)
                        ],
                      ),
                    )


                  ],
                ),
              ),
              Spacer(),
              Text('By continuing you may receive an SMS for verification. Message and data rates may apply.'),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTypePicker()));
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent[700],
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        duration: const Duration(seconds: 3),
                        content: Text('Not implemented!'),
                      )
                  );
                },
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


}
