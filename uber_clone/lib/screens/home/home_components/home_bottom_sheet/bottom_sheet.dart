import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/providers/location_provider.dart';
import 'package:uber_clone/screens/home/home_components/home_bottom_sheet/sheet_separator.dart';
import 'package:uber_clone/screens/pickup/pickup.dart';
class HomeBottomSheet extends StatefulWidget {

  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  DateTime dateTime = DateTime.now();
  late String formattedDate, formattedTime;



  @override
  void initState() {
    super.initState();
    formattedDate = app.getDate(dateTime);
    formattedTime = app.getTime(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            child: InkWell(
              splashColor: Colors.grey,
              child: Center(
                child: Text('Schedule a ride', style: TextStyle(fontSize: 30),),
              ),
            ),

          ),
          SheetSeparator(hasMargin: false),
          Container(
            height: 70,
            child: InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: dateTime,
                  initialDate: dateTime,
                  lastDate: dateTime.add(const Duration(days: 100))
                );

                if( pickedDate == null)
                  return;


                setState(() {
                  formattedDate = app.getDate(pickedDate);

                  dateTime = DateTime(
                    dateTime.year,
                    pickedDate.month,
                    pickedDate.day,
                    dateTime.hour,
                    dateTime.minute
                  );
                });



              },
              splashColor: Colors.grey,
              child: Center(
                child: Text(formattedDate, style: TextStyle(fontSize: 24),),
              ),
            ),
          ),
          SheetSeparator(hasMargin: true ),
          Container(
            height: 70,
            child: InkWell(
              onTap: () async{
                TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    helpText: 'Pick a start time',
                );


                if( selectedTime == null ) {
                  print('Selected time is null, exiting the function.');
                  return;
                }

                DateTime checkPicked = DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  selectedTime.hour,
                  selectedTime.minute
                );

                if( checkPicked.compareTo(dateTime) < 0) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Incorrect time, please try and pick again', style: TextStyle(fontSize: 100),),
                            ),
                          )
                        ],
                      ),
                    )
                  );
                }

                dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, selectedTime.hour, selectedTime.minute);
                formattedTime = app.getTime(dateTime);

                setState(() {

                });

              },
              splashColor: Colors.grey,
              child: Center(
                child: Text(formattedTime, style: TextStyle(fontSize: 24),),
              ),
            ),
          ),
          SheetSeparator(hasMargin: false ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(0)
                      )
                  )
              ),
              onPressed: () async {
                Provider.of<LocationProvider>(context, listen: false).pauseDriverStream();
                Navigator.pushNamed(context, Pickup.route, arguments: dateTime);

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Set pickup time', style: TextStyle(fontSize: 22),)
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
