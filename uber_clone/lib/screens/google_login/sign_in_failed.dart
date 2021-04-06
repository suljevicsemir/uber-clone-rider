

import 'package:flutter/material.dart';

class SignInFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Login took too long, please try again', style: TextStyle(fontSize: 122),),
              ),
              SizedBox(height: 20,),
              Image.asset('assets/images/timeout_exception.jpg', scale: 0.5,),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Try again', style: TextStyle(fontSize: 22, letterSpacing: 1.0, color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
