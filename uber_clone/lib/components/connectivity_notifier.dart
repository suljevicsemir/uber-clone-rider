
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uber_clone/components/app_utils.dart' as app;

class ConnectivityNotifier extends StatefulWidget {
  @override
  _ConnectivityNotifierState createState() => _ConnectivityNotifierState();
}

class _ConnectivityNotifierState extends State<ConnectivityNotifier> {
  ConnectivityResult? currentConnectivity;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async{
      var x = await (Connectivity().checkConnectivity());
      setState(() {
        currentConnectivity = x;
      });

      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if( result == ConnectivityResult.mobile || result == ConnectivityResult.wifi && currentConnectivity == ConnectivityResult.none )  {
          setState(() {
            currentConnectivity = result;
          });
          ScaffoldMessenger.of(context).showSnackBar(app.connectivityOnlineSnackBar());
        }
        if( result == ConnectivityResult.none && currentConnectivity != ConnectivityResult.none) {
          setState(() {
            currentConnectivity = result;
          });
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return currentConnectivity == ConnectivityResult.none ? Container(
      //margin: EdgeInsets.only(top: 100),
        child: app.connectivityOfflineBanner()
    ) : Container();
  }


}
