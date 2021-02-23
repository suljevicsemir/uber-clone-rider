import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/services/secure_storage.dart';

class GetStarted extends StatefulWidget {

  static const String route = '/getStarted';

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  SecureStorage provider = SecureStorage();


  @override
  void initState()  {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: const Color(0xff286ef0)
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: const Color(0xff286ef0),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                      child: Text('Uber', style: TextStyle(color: Colors.white, fontSize: 30))
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                      child: Image.asset('assets/images/driver_rider_mask.png', fit: BoxFit.cover,)
                  ),
                  //Spacer(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    child: Text('Move with Safety', style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/pickLoginType'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 22),),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Icon(Icons.arrow_right_alt_outlined, size: 36,)
                        )
                      ],
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }


}
