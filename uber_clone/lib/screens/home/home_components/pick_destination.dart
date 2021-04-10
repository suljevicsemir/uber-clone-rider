import 'package:flutter/material.dart';
import 'package:uber_clone/screens/home/home_components/pick_saved_place.dart';
import 'package:uber_clone/screens/home/home_components/where_to.dart';

class PickDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.2 * MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Container(
         // margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 5,
                width: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffededed)
                ),
              ),
              WhereTo(),
              Expanded(
                  child: PickSavedPlace()
              )

            ],
          ),
        ),
      ),
    );
  }
}
