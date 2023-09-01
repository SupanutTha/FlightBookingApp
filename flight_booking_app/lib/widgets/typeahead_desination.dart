import '/utilities/database_helper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:flutter/material.dart';

class AutocompleteTextfield extends StatefulWidget {
 // final String initialText;
  final TextEditingController controller;
  const AutocompleteTextfield({Key? key ,required this.controller});
  @override
  _AutocompleteTextfieldState createState() => _AutocompleteTextfieldState();
}

class _AutocompleteTextfieldState extends State<AutocompleteTextfield> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.controller,
              decoration: InputDecoration(
                //labelText: widget.initialText,
                border: UnderlineInputBorder(),
               suffix: GestureDetector(
                onTap: () {
                  widget.controller.clear();
                },
                child: Icon(Icons.clear , color: Colors.blue, size: 20,),
              ),
              ),
            ),
            suggestionsCallback: (String pattern)  async {
              final airports = await dbHelper.retrieveAirports();
              final filteredAirports = airports.where((airport) {
                return airport.iata.contains(pattern.toUpperCase()) ||
                  airport.city.toUpperCase().contains(pattern.toUpperCase()) ||
                  airport.country.toUpperCase().contains(pattern.toUpperCase());
              }).toList();
              return filteredAirports.map((airport) {
                return '${airport.city}, ${airport.country} - ${airport.iata}';
              }).toList();
            },
            itemBuilder: (BuildContext context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              widget.controller.text = suggestion.substring(suggestion.length-3);
              debugPrint('You just selected $suggestion');
            },
          ),
          
        ],
      ),
    );
  }
}
