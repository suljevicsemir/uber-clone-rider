import 'package:flutter/material.dart';

class PastTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff555c6e)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.grey,
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: width * 0.11,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/person_avatar.png',),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.03),
                  height: 90,
                  width: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text('3.8', style: TextStyle(color: Colors.white, fontSize: 18),),
                            SizedBox(width: 10,),
                            Icon(Icons.star, color: Colors.yellow,),
                            Icon(Icons.star, color: Colors.yellow,),
                            Icon(Icons.star, color: Colors.yellow,),
                            Icon(Icons.star, color: Colors.yellow,),
                            Icon(Icons.star_border_outlined)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.chevron_right, color: Colors.white, size: 34,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
