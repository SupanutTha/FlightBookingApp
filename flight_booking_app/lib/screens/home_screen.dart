// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flight_booking_app/design/style.dart';
import 'package:flight_booking_app/widgets/bottom_bar.dart';
import 'package:flight_booking_app/widgets/class_select_toogle_buttom.dart';
import 'package:flight_booking_app/widgets/toggle_buttom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
          title: const Text("Search Flight"),
          backgroundColor: const Color(0xFFEC441E),
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: []),
      //body
      body: // Figma Flutter Generator HomeWidget - FRAME
          Container(
              decoration: BoxDecoration(
                // middle box
                //color : Color.fromRGBO(255, 193, 169, 0.843137264251709),
                color: const Color(0xFFEC441E),
              ),
              child: Stack(children: <Widget>[
                Positioned( // orange header
                    top: 150,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container( // buttom toggle
                      width: 430,
                      height: 612,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TransactionToggle(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.login,
                                    // ),
                                    Text('One way'),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.logout,
                                    // ),
                                    Text('Round'),
                                  ],
                                ),
                              ],
                              initialSelection: [true, false],
                            ),
                          ),
                          Column( // in side big  white box
                              children: [
                                Row( //text From
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Text(
                                        "From",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding( //search Departure
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 10, right: 35),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      backgroundColor:
                                          const Color.fromARGB(11, 0, 0, 0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.flight_takeoff),
                                        SizedBox(width: 10,height: 50,), 
                                        Text('Departure'),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Row( // text to
                                    children: [
                                      Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Text(
                                        "To",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(left: 280),
                                        child: MaterialButton(
                                          color: Colors.white,
                                          shape: CircleBorder(),
                                          height: 8,
                                          child: Icon(
                                            Icons.swap_vert,
                                            color:const Color(0xFFEC441E),
                                          ),
                                          onPressed: () {
                                            // do something
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding( // seach Arrival
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 0, right: 35),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      backgroundColor:
                                          const Color.fromARGB(11, 0, 0, 0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.flight_land),
                                        SizedBox(width: 10 , height: 50,), 
                                        Text('Arrival'),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Row( // text Departure and Return date
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:10,left: 35),
                                      child: Text(
                                        "Departure",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:10,left: 120),
                                      child: Text(
                                        "Return",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Row( // buttom select departure Date and Retrun date
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35, top: 10, right: 25),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.black,
                                          backgroundColor:
                                              const Color.fromARGB(11, 0, 0, 0),
                                              fixedSize: Size(160,50)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.calendar_month),
                                            SizedBox(width: 0 , height: 50,), 
                                            Text('Departure date'),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.black,
                                          fixedSize: Size(160,50),
                                          backgroundColor:
                                              const Color.fromARGB(11, 0, 0, 0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.calendar_month),
                                            SizedBox(width: 10,height: 50,), 
                                            Text('Return date'),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row( // text Traveler and Class 
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:10,left: 35),
                                      child: Text(
                                        "Traveler",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:10,left: 135),
                                      child: Text(
                                        "Class",
                                        style: AppStyles.customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Row( // buttom traveler and class
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35, top: 10, right: 25),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.black,
                                          backgroundColor:
                                              const Color.fromARGB(11, 0, 0, 0),
                                              fixedSize: Size(160,50)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.flight_takeoff),
                                            SizedBox(width: 25 , height: 50,), 
                                            Text('Traveler'),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.black,
                                          backgroundColor:
                                              const Color.fromARGB(11, 0, 0, 0),
                                              fixedSize: Size(160,50)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.flight_takeoff),
                                            SizedBox(width: 25,height: 50,), 
                                            Text('Class'),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                Padding( // search buttom
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 35, right: 35),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      backgroundColor:
                                          const Color(0xFFEC441E),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.search , color: Colors.white,),
                                        SizedBox(width: 10,height: 50,), 
                                        Text('Search Flights',
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                              )
                        ],
                      ),
                    )),
                Positioned( // slogan text
                    // slogan text
                    top: 40,
                    left: 37,
                    child: Text(
                      'Go away!  some where',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Amiri Quran Colored',
                          fontSize: 40,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.125),
                    )
                  ),
                  ]
                  )
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFEC441E),
        onTap: _onItemTapped,
      ),
    );
  }
}//ec