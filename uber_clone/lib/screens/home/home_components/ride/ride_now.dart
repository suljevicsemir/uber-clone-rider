
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/home_provider.dart';
import 'package:uber_clone/screens/home/drawer_menu_icon.dart';
class RideNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Positioned(
     //width: MediaQuery.of(context).size.width,
     //height: 0.2 * MediaQuery.of(context).size.height,
     top: 20,
     left: 0,
     child: Container(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           DrawerMenu(),
           Container(
             margin: EdgeInsets.only(left: 10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Ready when you are", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.8, fontFamily: 'OnePlusSans'),),
                 Container(
                   margin: EdgeInsets.only(top: 10),
                   child: LimitedBox(
                       maxWidth: MediaQuery.of(context).size.width * 0.7,
                       child: Text('Here to help you move safely in the new every day', style: TextStyle(color: Colors.white, fontSize: 16), maxLines: 2,)
                   ),
                 ),
                 GestureDetector(
                   onTap: () => Provider.of<HomeProvider>(context, listen: false).updateOverlay(),
                   child: Container(
                       margin: EdgeInsets.only(top: 10),
                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.circular(20)
                       ),
                       child: Center(child: Text('Ride now', style: TextStyle(color: Colors.white),))
                   ),
                 ),
               ],
             ),
           )
         ],
       ),
     ),
   );
  }
}
