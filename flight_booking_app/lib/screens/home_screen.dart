// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flight_booking_app/design/style.dart';
import 'package:flight_booking_app/screens/trip_screen.dart';
import 'package:flight_booking_app/widgets/toggle_button.dart';
import 'package:flight_booking_app/widgets/pop_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/dynamic_text_button.dart';
import 'package:intl/intl.dart';
import '../models/flight_search_data.dart';
import 'package:flight_booking_app/screens/search_result_screen.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sumTraveller = '1';
  int _selectedIndex = 0;
  bool isRoundTrip = false; 
  TextEditingController _departureController = TextEditingController();
  TextEditingController _arrivalController = TextEditingController();
  TextEditingController _adultCountController = TextEditingController(text: '1');
  TextEditingController _kidCountController = TextEditingController(text: '0');
  TextEditingController _babyCountController = TextEditingController(text: '0');
  DateTime? _departureDateController ;
  DateTime? _returnDateController ;
  TextEditingController _classController = TextEditingController(text: 'Economy');
 
  // List<DateTime?> _singleDatePickerValueWithDefaultValue = [DateTime.now(),];
  // List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [ // calendar for round trip
  //   DateTime.now(),
  //   DateTime.now().add(const Duration(days: 0)),
  // ];
  void _navigateToResultPage() { // send data to class flight_search_data
  // ?? = defualt value
  String departure = _departureController.text ;
  String arrival = _arrivalController.text;
  String adultCount = _adultCountController.text;
  String kidCount = _kidCountController.text;
  String babyCount = _babyCountController.text;
  String cabinClass = _classController.text;
  DateTime? departureDate = _departureDateController;
  // if (_departureDateController  == null) {
  //   departureDate = DateTime.parse(_departureDateController);
  // }

  DateTime? returnDate = _returnDateController;
  // if (_returnDateController.text.isNotEmpty) {
  //   returnDate = DateTime.parse(_returnDateController.text);
  // }

  FlightSearchData searchData = FlightSearchData( // collect data  in flightSearchData
    departure: departure.substring(departure.length- 3),
    arrival: arrival.substring(arrival.length - 3),
    adultCount: adultCount,
    kidCount: kidCount,
    babyCount: babyCount,
    departureDate: departureDate,
    returnDate: returnDate,
    cabinClass: cabinClass.toUpperCase(),
  );
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(searchData: searchData), // send data to result page
      ),
    );
}
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Navigate to the home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TripScreen(), // Replace 'HomeScreen' with the actual name of your home page.
          ),
        );
      }
    });
  }
  void _onToggleChanged(int index) {
  setState(() {
    isRoundTrip = index == 1;
    if (!isRoundTrip) {
      _returnDateController = null; // Clear returnDate when One way is selected
    }
  });
}

  void updateTotalTravellers(String title, int value) {
    print('1 $title : $value');
    // Parse the values from the controllers and calculate the total
    var adultCount = int.tryParse(_adultCountController.text) ?? 0;
    var kidCount = int.tryParse(_kidCountController.text) ?? 0;
    var babyCount = int.tryParse(_babyCountController.text) ?? 0;
    if (title == 'Adults' ){
      adultCount +=1;
    }
    else if (title == 'Children'){
      kidCount +=1;
    }
    else {
      babyCount +=1;
    }
    print('2 $title : $value');
    var total = adultCount + kidCount + babyCount;
    print('total = $total');
    // Update the sumTraveller variable with the total
    _adultCountController.text = adultCount.toString();
    _kidCountController.text = kidCount.toString();
   _babyCountController.text = babyCount.toString();
    setState(() {
      sumTraveller = total.toString();
    });
  }
  void updatePage(){
    setState(() {
      
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
          Container( //all screan
              decoration: BoxDecoration( // oreange header
                // middle box
                //color : Color.fromRGBO(255, 193, 169, 0.843137264251709),
                color: const Color(0xFFEC441E),
              ),
              child: Stack(children: <Widget>[
                Positioned( // big whrite box
                    top: 150,
                    child: Container( // white box
                      width: 430,
                      height: 612,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container( // single / round trip
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
                              onToggleChanged:  _onToggleChanged,
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
                                      child: DynamicTextButton(
                                        textController: _departureController.text, 
                                        buttonText: 'Departure', 
                                        icon: Icons.flight_takeoff, 
                                        buttonAction: SearchFlightPopUp(
                                          controller: _departureController, 
                                          callback:updatePage )
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
                                            String temp = _departureController.text;
                                            _departureController.text = _arrivalController.text;
                                            _arrivalController.text = temp;
                                            updatePage();
                                            // do something
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding( // search Arrival
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 0, right: 35),
                                  child: DynamicTextButton(
                                    textController: _arrivalController.text, 
                                    buttonText: 'Arrival', 
                                    icon: Icons.flight_land, 
                                    buttonAction: SearchFlightPopUp(
                                      controller: _arrivalController, 
                                      callback: updatePage)),
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
                                      visible: isRoundTrip  && _departureDateController != null ,
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
                                Row( // button select departure Date and Return date
                                  children: [
                                    Row( // button select departure Date and Return date
                                      children: [
                                      Visibility(
                                        visible: !isRoundTrip, // Show "Departure date" button when not round trip
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 35, top: 10, right: 25),
                                          child: DynamicTextButton(
                                            textController: _departureDateController != null
                                              ? DateFormat('E, d MMM yy').format(_departureDateController!)
                                              : 'Departure date',
                                            buttonText: 'Departure date',
                                            icon: Icons.calendar_month,
                                            buttonAction: SingleDatePickPopUp(
                                              controller: _departureDateController,
                                              //selectedDate: _singleDatePickerValueWithDefaultValue,
                                              callback: (DateTime? selectedDate){
                                                setState(() {
                                                  _departureDateController = selectedDate;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isRoundTrip, // Show a different button for round trips
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 35, top: 10, right: 25),
                                          child: DynamicTextButton(
                                            textController: _departureDateController != null
                                              ? DateFormat('E, d MMM yy').format(_departureDateController!)
                                              : 'Departure date',
                                            buttonText: 'Departure date',
                                            icon: Icons.calendar_month,
                                            buttonAction: RangeDatePickPopUp(
                                              isDepartureButton: true,
                                              departureDateController: _departureDateController,
                                              returnDateController: _returnDateController,
                                              //selectedDate: _rangeDatePickerWithActionButtonsWithValue,
                                              callback: (DateTime? selectedDateDeparture , DateTime? selectedDateReturn){
                                                setState(() {
                                                  _departureDateController = selectedDateDeparture;
                                                  _returnDateController = selectedDateReturn;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility( // return date
                                        visible: isRoundTrip && _departureDateController != null ,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 3, top: 10),
                                          child: DynamicTextButton(
                                            textController: _returnDateController != null
                                              ? DateFormat('E, d MMM yy').format(_returnDateController!)
                                              : 'Return date',
                                            buttonText: 'Return date',
                                            icon: Icons.calendar_month,
                                            buttonAction: RangeDatePickPopUp(
                                              isDepartureButton: false,
                                              departureDateController: _departureDateController,
                                              returnDateController: _returnDateController,
                                              //selectedDate: _rangeDatePickerWithActionButtonsWithValue,
                                              callback: (DateTime? selectedDateDeparture , DateTime? selectedDateReturn){
                                                setState(() {
                                                  _departureDateController = selectedDateDeparture;
                                                  _returnDateController = selectedDateReturn;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

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
                                Row( // button traveler and class
                                  children: [
                                    Padding( // Travelers 
                                      padding: const EdgeInsets.only(
                                          left: 35, top: 10, right: 25),
                                          child: DynamicTextButton(
                                            textController: '$sumTraveller Travelers', 
                                            buttonText: '1 Travelers', 
                                            icon: Icons.people,
                                            buttonAction: TravellersPopUp(
                                              adultController: _adultCountController, 
                                              kidController: _kidCountController, 
                                              babyController: _babyCountController, 
                                              onChanged: updateTotalTravellers)),
                                    ),
                                    Padding( // Cabin Class button
                                      padding: const EdgeInsets.only(
                                          left: 25, top: 10),
                                          child: DynamicTextButton(
                                            textController: _classController.text,
                                            buttonText: _classController.text, 
                                            icon: Icons.chair, 
                                            buttonAction: ClassPopUp(
                                              controller: _classController,
                                              callback: updatePage
                                              )),
                                    ),
                                  ],
                                ),
                                Padding( // search button
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
                                    onPressed: () {
                                      print(_departureController.text);
                                      print(_arrivalController.text);
                                      print(_departureDateController);
                                      print(_returnDateController);
                                      print("what?");
                                      if ( 
                                        _departureController.text.isNotEmpty 
                                        && _arrivalController.text.isNotEmpty 
                                        && _departureDateController != null)
                                      {
                                        //print("let go");
                                         _navigateToResultPage();
                                      }                                     
                                    },
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
                    child: Column(
                      children: [
                        Text(
                          'Go a Where!     ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Amiri Quran Colored',
                              fontSize: 40,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.125),
                        ),
                        Text(
                          'some where',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Amiri Quran Colored',
                              fontSize: 40,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.125),
                        ),
                      ],
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
            icon: Icon(Icons.airplane_ticket),
            label: 'Trips',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFEC441E),
        onTap: _onItemTapped,
      ),
    );
  }
}//ec