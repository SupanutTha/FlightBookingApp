// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flutter/material.dart';

class ActionChoiceExample extends StatefulWidget {
  final String selectedOption;
  final Function(String, List<Flight>) onSortOptionSelected;
  final List<Flight> searchResults;
  final List<Flight> originalSearchResults;

  const ActionChoiceExample({
    Key? key,
    required this.selectedOption,
    required this.onSortOptionSelected,
    required this.searchResults, 
    required this.originalSearchResults,
  }) : super(key: key);

  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  String _currentSortingOption = 'Cheapest';

    @override
  void initState() {
    super.initState();
    _currentSortingOption = widget.selectedOption;
  }

  void _handleSortOptionSelected(String selectedOption) {
    setState(() {
      _currentSortingOption = selectedOption;
    });
  
    List<Flight> sortedResults;
    if (_currentSortingOption == 'Fastest') {
      sortedResults = _sortResultsByFastest(widget.originalSearchResults);
    } else if (_currentSortingOption == 'Cheapest') {
      sortedResults = _sortResultsByCheapest(widget.originalSearchResults);
    } else if (_currentSortingOption == 'Direct') {
      sortedResults = _filterDirectFlights(widget.originalSearchResults);
    }
    else{
      sortedResults = widget.originalSearchResults;
    }

    widget.onSortOptionSelected(_currentSortingOption, sortedResults);
  }

  List<Flight> _sortResultsByFastest(List<Flight> searchResults) {
    searchResults.sort((a, b) => a.itineraries[0]['duration'].compareTo(b.itineraries[0]['duration']));
    return searchResults;
  }

  List<Flight> _sortResultsByCheapest(List<Flight> searchResults) {
    searchResults.sort((a, b) =>
        a.price['grandTotal'].compareTo(b.price['grandTotal']));
    return searchResults;
  }

  List<Flight> _filterDirectFlights(List<Flight> searchResults) {
     searchResults = searchResults.where((flight) =>
        flight.itineraries[0]['segments'].length == 1).toList();
    return searchResults;
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
                final String option = sortingOptions[index];
                final bool isSelected = _currentSortingOption == option;

                return ChoiceChip(
                  selectedColor: Color(0xFFEC441E),
                  backgroundColor:
                      isSelected ? Color(0xFFEC441E) : Colors.white,
                  side: BorderSide(
                    width: 0.3,
                    color: Colors.black26,
                  ),
                  label: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_)  {
                    final String selectedOption = sortingOptions[index];
                    if (selectedOption != _currentSortingOption) {
                      _handleSortOptionSelected(selectedOption);
                    }
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

const List<String> sortingOptions = ['Cheapest', 'Fastest', 'Direct'];
