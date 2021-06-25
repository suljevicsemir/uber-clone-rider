
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/screens/get_started/choose_account.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[50],
          statusBarIconBrightness: Brightness.dark
        ),
        child: SafeArea(
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
                          child: Text('Enter your mobile number', style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w700, letterSpacing: 2, fontSize: 100))
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            //Image.asset('icons/flags/png/ba.png', package: 'country_icons', scale: 2,),
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
                      //SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () async => Navigator.pushNamed(context, '/chooseAccount'),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, ChooseAccount.route);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 30, 10, 30)
                              ),
                              child: Text('Or connect with social', style: TextStyle(color: Colors.indigoAccent[700], fontWeight: FontWeight.w600))
                            ),

                            Icon(Icons.arrow_right_alt, color: Colors.indigoAccent[700], size: 34,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text('By continuing you may receive an SMS for verification. Message and data rates may apply.', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {

                    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTypePicker()));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent[700],
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          duration: const Duration(seconds: 3),
                          content: Text('Not implemented!'),
                        )
                    );
                  },
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 22),)
                        )
                      ),
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
