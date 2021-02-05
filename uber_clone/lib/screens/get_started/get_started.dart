import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/screens/get_started/choose_login_type.dart';
import 'package:uber_clone/services/secure_storage.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  CallNumbersProvider provider = CallNumbersProvider();


  @override
  void initState()  {
    super.initState();
    //getCountries();
  }

  Future<void> getCountries() async {
     await provider.getCountries();
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
                  Spacer(),
                  Text('Uber', style: TextStyle(color: Colors.white, fontSize: 30),),
                  Spacer(),
                  Image.asset('assets/images/driver_rider_mask.png', height: 400,),
                  Spacer(),
                  Text('Move with Safety', style: TextStyle(color: Colors.white, fontSize: 30),),
                  Spacer(),
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
