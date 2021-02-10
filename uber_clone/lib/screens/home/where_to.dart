import 'package:flutter/material.dart';

class WhereTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          color: const Color(0xffededed)
      ),
      child: Row(
        children: [
          Text('Where to?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
          Spacer(),
          Container(
            width: 2,
            height: 8,
            color: Colors.red,
          ),
          Container(
            constraints: BoxConstraints(
                minWidth: 0.3 * MediaQuery.of(context).size.width,
                minHeight: 0.058 * MediaQuery.of(context).size.height
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Container(
                      color: Colors.black,
                      child: Icon(Icons.schedule, color: Colors.white,)),
                ),
                Text('Now'),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          )
        ],
      ),
    );
  }
}
