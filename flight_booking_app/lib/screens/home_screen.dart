// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flight_booking_app/design/style.dart';
import 'package:flight_booking_app/widgets/SearchFlightPopUp.dart';
import 'package:flight_booking_app/widgets/bottom_bar.dart';
import 'package:flight_booking_app/widgets/class_select_toogle_buttom.dart';
import 'package:flight_booking_app/widgets/toggle_buttom.dart';
import 'package:flight_booking_app/widgets/xen_popup_card.dart';
import 'package:flutter/material.dart';

import '../models/flight_search_data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isRoundTrip = false; 
  TextEditingController _departureController = TextEditingController();
  TextEditingController _arrivalController = TextEditingController();
  TextEditingController _adultCountController = TextEditingController(text: '1');
  TextEditingController _kidCountController = TextEditingController(text: '0');
  TextEditingController _babyCountController = TextEditingController(text: '0');

  void _navigateToResultPage() { // send data to class flight_search_data
  // ?? = defualt value
  String departure = _departureController.text ?? '';
  String arrival = _arrivalController.text ?? '';
  String adultCount = _adultCountController.text ?? '1';
  String kidCount = _kidCountController.text ?? '0';
  String babyCount = _babyCountController.text ?? '0';

  FlightSearchData searchData = FlightSearchData( // collect data  in flightSearchData
    departure: departure,
    arrival: arrival,
    adultCount: adultCount,
    kidCount: kidCount,
    babyCount: babyCount,
    // isEconomicClass: _isSelectedClass[0],
    // isPremiumEconomicClass: _isSelectedClass[1],
    // isBusinessClass: _isSelectedClass[2],
    // isFirstClass: _isSelectedClass[3],
    // if true = ?
    // false = :
    // selectedDate: _isSelected[0]
    //     ? _singleDatePickerValueWithDefaultValue[0] // pick one day
    //     : null,
    // selectedRange: _isSelected[1]
    //     ? _rangeDatePickerWithActionButtonsWithValue // pick range of days
    //     : [null, null],//first , last
  );

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => ResultPage(searchData: searchData), // send data to result page
  //   ),
  // );
}
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void onToggleChanged(int index) { // Remove the underscore
    setState(() {
      isRoundTrip = index == 1;
    });
  }

  Text _buildDepartureText() {
  final departureText = _departureController.text.isNotEmpty
    ? _departureController.text
    : 'Departure';
  return Text(departureText);
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
          Container( //all screan
              decoration: BoxDecoration( // oreange header
                // middle box
                //color : Color.fromRGBO(255, 193, 169, 0.843137264251709),
                color: const Color(0xFFEC441E),
              ),
              child: Stack(children: <Widget>[
                Positioned( // big whrite box
                    top: 150,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container( // white box
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
                              // initialSelection: [true, false],
                              initialSelection: [!isRoundTrip, isRoundTrip],
                              onToggleChanged:  onToggleChanged,
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
                                        Builder(
                                          builder: (context) {
                                            final departureText = _departureController.text.isNotEmpty
                                                ? _departureController.text
                                                : 'Departure';
                                            return Text(departureText);
                                          },
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (builder) => XenPopupCard(
                                          body: SearchFlightPopUp(controller: _departureController),
                                        ),
                                      );
                                      setState(() {});
                                    },
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
                                         Builder(
                                          builder: (context) {
                                            final arrivalText = _arrivalController.text.isNotEmpty
                                                ? _arrivalController.text
                                                : 'Arrival';
                                            return Text(arrivalText);
                                          },
                                        ),
                                        
                        
                                      ],
                                    ),
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (builder) => XenPopupCard(
                                          body: SearchFlightPopUp(controller: _arrivalController),
                                        ),
                                      );
                                      setState(() {});
                                    },
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
                                    Visibility(
                                      visible: isRoundTrip,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:10,left: 120),
                                        child: Text(
                                          "Return",
                                          style: AppStyles.customTextStyle,
                                        ),
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
                                    Visibility(
                                      visible: isRoundTrip,
                                      child: Padding(
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
                                            Icon(Icons.people),
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
                                            Icon(Icons.chair),
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
                      'Go away! some where',
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