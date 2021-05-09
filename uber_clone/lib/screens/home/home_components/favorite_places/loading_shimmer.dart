

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatefulWidget {
  @override
  _LoadingShimmerState createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 40,),
                const SizedBox(width: 30,),
                Container(
                  height: 30,
                  width: 90,
                  color: Colors.grey,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right, size: 40,)
              ],
            ),
            Divider(
              indent: 70,
              height: 40,
              color: Colors.grey,
              thickness: 2,
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 40,),
                const SizedBox(width: 30,),
                Container(
                  height: 30,
                  width: 90,
                  color: Colors.grey,
                ),
                Spacer(),
                const Icon(Icons.keyboard_arrow_right, size: 40,)
              ],
            )
          ],
        ),
      ),

      baseColor: Colors.black12,
      highlightColor: Colors.white,
    );
  }
}
