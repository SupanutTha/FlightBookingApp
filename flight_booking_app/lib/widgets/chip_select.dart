// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [ActionChoice].

class ActionChoiceExample extends StatefulWidget {
  final String selectedOption;
  final Function(String, List<Flight>) onSortOptionSelected;
  final List<Flight> searchResults;

  const ActionChoiceExample({
    super.key, 
    required this.selectedOption, 
    required this.onSortOptionSelected, 
    required this.searchResults});
  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  int? _value = 0;
  List sortingOptions = ['Cheapest', 'Fastest',  'Direct'];
  String _currentSortingOption = 'Cheapest';

  static List<Flight> _sortResults(String option , List<Flight> searchResults) {  
  List<Flight> sortedResults = List.from(searchResults); // Create a copy of searchResults
  if (option == 'Fastest') {
    sortedResults.sort((a, b) => a.itineraries[0]['duration'].compareTo(b.itineraries[0]['duration']));
  } else if (option == 'Cheapest') {
    sortedResults.sort((a, b) => a.price['total'].compareTo(b.price['total']));
  } else if (option == 'Direct') {
    sortedResults.sort((a, b) => a.itineraries[0]['segments'].length.compareTo(b.itineraries[0]['segments'].length));
  }
  return sortedResults;
}
@override
  void initState() {
    super.initState();
    _currentSortingOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                3,
                (int index) {
                  return ChoiceChip(
                    selectedColor: Color(0xFFEC441E),
                    backgroundColor: _value == index ? Colors.black : Colors.white, // Set the background color based on selection.
                    side :BorderSide(
                      width: 0.3,
                      color: Colors.black26
                    ),
                    label: Text(
                      sortingOptions[index],
                      style: TextStyle(
                      color: _value == index ? Colors.white : Colors.black, // Set the label color based on selection.
                    ),),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      final String selectedOption = sortingOptions[index];
                      if (selectedOption != _currentSortingOption) {
                        _currentSortingOption = selectedOption;
                        List<Flight> sortedResults =
                            _sortResults(selectedOption, widget.searchResults);
                        widget.onSortOptionSelected(selectedOption, sortedResults);
                      }
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ],
        ),
      );
  }
}
