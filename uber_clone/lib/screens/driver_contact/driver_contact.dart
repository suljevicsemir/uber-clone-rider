import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:uber_clone/screens/driver_contact//driver_contact_types/call_driver.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact_types/schedule_ride_with_driver.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact_types/sms_driver.dart';

class DriverContact extends StatefulWidget {

  static const route = '/driverProfile';


  @override
  _DriverContactState createState() => _DriverContactState();
}

class _DriverContactState extends State<DriverContact> with TickerProviderStateMixin{

  double top = 0;

  AnimationController clickedController;
  bool showContactTypes = true;
  double begin = 0.5, end = 1;



  @override
  void initState() {
    super.initState();
    clickedController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    );

    //changeStatusBarColor();
  }

  Future<void> changeStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.pink, animate: true);
  }


  void rotateIcon() {
    clickedController.reset();
    if(!showContactTypes) {
      setState(() {
        begin = 0;
        end = 0.5;
        showContactTypes = !showContactTypes;
      });
    }
    else {
      setState(() {
        begin = 0.5;
        end = 1;
        showContactTypes = !showContactTypes;
      });
    }
    clickedController.forward();
  }


  @override
  void dispose() {
    clickedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white
                    ),
                    brightness: Brightness.dark,
                    elevation: 0.0,
                    expandedHeight: MediaQuery.of(context).size.height * 0.45,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.star_border),
                        onPressed: () {}
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return  FlexibleSpaceBar(
                          centerTitle: false,
                          title: Text('John', style: TextStyle(color: Colors.white, fontSize: 22),),
                          background: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/new_york.jpg'),
                                    fit: BoxFit.cover,
                                )
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    MaterialButton(
                      minWidth: 150,
                      height: 50,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {},
                      child: Text('Phone call', style: TextStyle(color: Colors.white, fontSize: 16),),
                      splashColor: Colors.white,
                    ),
                    Spacer(),
                    MaterialButton(
                      minWidth: 150,
                      height: 50,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {},
                      child: Text('Send message', style: TextStyle(color: Colors.white, fontSize: 16),),
                      splashColor: Colors.white,
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(height: 20,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: rotateIcon,
                    splashColor: Colors.grey,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text('062 923 491', style: TextStyle(fontSize: 18),),
                          Spacer(),
                          RotationTransition(
                              turns: Tween<double>(begin: begin, end: end).animate(clickedController),
                              child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black,))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(height: 30, color: Colors.grey, thickness: 0.5,)),
                AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 200),
                  child: showContactTypes ?
                  Container(
                    child: Column(
                      children: [
                        SMSDriver(),
                        CallDriver(),
                        ScheduleRide(),
                      ],
                    ),
                  ) : Container(),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
