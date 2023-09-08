// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleDatePickPopUp extends StatefulWidget{
  DateTime? controller;
  //List<DateTime?> selectedDate =[DateTime.now()];
  final Function callback;
  SingleDatePickPopUp ({
    Key? key ,
    required this.controller,
    //required this.selectedDate, 
    required this.callback
    });
  @override
  _SingleDatePickPopUpState createState() => _SingleDatePickPopUpState();

}

class  _SingleDatePickPopUpState extends State<SingleDatePickPopUp> {
   late List<DateTime?> selectedDateList =[];
  @override
  void initState() {
    super.initState();
    print(widget.controller);
    selectedDateList.add(widget.controller);
    
    selectedDateList[0] = widget.controller ?? DateTime.now();
    print('selected date ${selectedDateList}');
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
                    Builder(
                      builder: (context){
                        final calendarText = selectedDateList[0] == null
                        ? DateTime.now()
                        : selectedDateList[0];
                        return Text(
                      DateFormat('E, d MMM yy').format(calendarText!),
                      style: TextStyle(
                        color: Color(0xFFEC441E),
                        fontSize: 14,
                      ),
                    );
                      }),
                    
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
                          config: CalendarDatePicker2Config(
                            currentDate: selectedDateList[0],
                            selectableDayPredicate: (day) => !day
                              .difference(DateTime.now().subtract(const Duration(days: 1)))
                              .isNegative,
                          ),
                          value: selectedDateList,
                          onValueChanged: (dates) {
                            setState(() {
                              selectedDateList = List.from(dates);
                              print(selectedDateList);
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
                                    onPressed: (){
                                      if (selectedDateList.isNotEmpty && selectedDateList[0] != null) {
                                        print('checkif');
                                        widget.controller =  selectedDateList[0]!;
                                        print('controller :${widget.controller}');
                                        widget.callback(widget.controller);
                                        Navigator.pop(context,  widget.controller);
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