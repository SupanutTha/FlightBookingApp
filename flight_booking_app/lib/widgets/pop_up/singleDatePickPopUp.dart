// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleDatePickPopUp extends StatefulWidget{
  TextEditingController controller;
  List<DateTime?> selectedDate;
  SingleDatePickPopUp ({
    Key? key ,
    required this.controller,
    required this.selectedDate
    });
  @override
  _SingleDatePickPopUpState createState() => _SingleDatePickPopUpState();

}

class  _SingleDatePickPopUpState extends State<SingleDatePickPopUp> {
  late List<DateTime?> selectedDateList;

  @override
  void initState() {
    super.initState();
    selectedDateList = List.from(widget.selectedDate);
  }
  
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100, // Adjust the height as needed
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                title: Text("Calendar",style: TextStyle(color: Colors.black),),
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
                bottom: AppBar(
                    elevation: 0.0, 
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(1.0), // Add padding for the border
                child: Column(
                  children: [
                    Text("Select date       ", style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),),
                    Text(
                      DateFormat('E, d MMM yy').format(selectedDateList[0]!),
                      style: TextStyle(
                        color: Color(0xFFEC441E),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
              ),
              // Add other Sliver widgets here
            ],
          ),
          Positioned(
            top: 115,
            left: 0,
            right: 0,
            bottom: 0,
              child: 
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 0),
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(),
                          value: selectedDateList,
                          onValueChanged: (dates) {
                            setState(() {
                              selectedDateList = List.from(dates);
                            });
                          }
                        ),
                      ),
                      OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      backgroundColor:
                                          const Color(0xFFEC441E),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10,height: 50,), 
                                        Text('Selected Date',
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),),
                                      ],
                                    ),
                                    // onPressed: () {
                                    //   widget.controller = widget.selectedDate as TextEditingController;
                                    //   debugPrint('You just selected ${widget.controller}');
                                    //   print(widget.controller);
                                    //   print(context);
                                    //   Navigator.pop(context, widget.controller);
                                    // },
                                    onPressed: (){
                                      if (selectedDateList.isNotEmpty && selectedDateList[0] != null) {
                                        widget.controller.text =
                                            DateFormat('yyyy-MM-dd').format(selectedDateList[0]!);
                                        Navigator.pop(context, widget.controller.text);
                    }
                                    },
                                  ),
                    ],
                  ),            
          
          ),
         ],
      ),
    );
  }

}