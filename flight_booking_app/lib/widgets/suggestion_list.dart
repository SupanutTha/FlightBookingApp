// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '/utilities/database_helper.dart';

class SuggestionList {
  final TextEditingController controller;
  SuggestionList({
    required this.controller,
  });
  final dbHelper = DatabaseHelper.instance;

  Future<List<String>> suggestionsCallback (String pattern)  async {
  final airports = await dbHelper.retrieveAirports();
  final filteredAirports = airports.where((airport) {
    return airport.iata.contains(pattern.toUpperCase()) ||
      airport.city.toUpperCase().contains(pattern.toUpperCase()) ||
      airport.country.toUpperCase().contains(pattern.toUpperCase());
    }).toList();
    return filteredAirports.map((airport) {
      return '${airport.city}, ${airport.country} - ${airport.iata}';
    }).toList();
  }

  }

class SuggestResutl {
       late TextEditingController suggestResutl;
      void saveResutl(TextEditingController  _controller){
          suggestResutl = _controller;
      }
      
      TextEditingController get getResutl{
        return suggestResutl;
      }


  }

  //   return FutureBuilder<List<String>>(
  //     future: suggestionsCallback(widget.controller.text),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // While waiting for data, you can display a loading indicator.
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         // Handle errors here.
  //         return Text('Error: ${snapshot.error}');
  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //         // Handle the case when no suggestions are available.
  //         return Text('No suggestions found');
  //       } else {
  //         // Display the suggestions in a ListView.
  //         return Column(
  //           children: [
  //             SizedBox(height: 8), // Spacer between TextField and suggestion box.
  //             Container(
  //               height: 150, // Adjust the height as needed.
  //               child: ListView.builder(
  //                 itemCount: snapshot.data!.length,
  //                 itemBuilder: (context, index) {
  //                   return ListTile(
  //                     title: Text(snapshot.data![index]),
  //                     onTap: () {
  //                       // Perform an action when a suggestion is tapped.
  //                       widget.controller.text = snapshot.data![index].substring(snapshot.data![index].length - 3);
  //                       debugPrint('You just selected ${snapshot.data![index]}');
  //                       // You can also close the suggestion box here if needed.
  //                     },
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }



