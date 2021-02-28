import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class GetStarted extends StatelessWidget {

  static const String route = '/getStarted';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: const Color(0xff286ef0),
          statusBarIconBrightness: Brightness.light
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: const Color(0xff286ef0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text('Uber', style: TextStyle(color: Colors.white, fontSize: 42, letterSpacing: 0.8))
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/images/driver_rider_mask.png')
                    ),
                  ),
                  //Spacer(),
                  Expanded(
                    flex: 8,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Move with Safety', style: TextStyle(color: Colors.white, fontSize: 80))
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async => await Navigator.pushNamed(context, '/pickLoginType'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Center(
                                child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 22))
                            )
                        ),
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
