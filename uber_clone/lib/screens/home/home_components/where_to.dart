import 'package:flutter/material.dart';
import 'package:uber_clone/screens/home/home_components/home_bottom_sheet//bottom_sheet.dart';
import 'package:uber_clone/screens/where_to_search/where_to_search.dart';

class WhereTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          color: const Color(0xffededed)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async => await Navigator.pushNamed(context, WhereToSearch.route),
            child: Text('Where to?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),)
          ),
          Spacer(),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context ,
              isScrollControlled: true,
              builder: (context) => HomeBottomSheet()
            ),
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}
