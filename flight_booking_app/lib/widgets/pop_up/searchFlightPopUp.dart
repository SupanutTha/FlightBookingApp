// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flight_booking_app/widgets/suggestion_list.dart';
import 'package:flutter/material.dart';

class SearchFlightPopUp extends StatefulWidget{

  final TextEditingController controller;
  SearchFlightPopUp ({Key? key ,required this.controller});
  @override
  _SearchFlightPopUpState createState() => _SearchFlightPopUpState();

}

class _SearchFlightPopUpState extends State<SearchFlightPopUp> {
  List suggestions = []; 
  // Method to update the suggestions based on the user input
  void updateSuggestions(String pattern) async {
    final updatedSuggestions = await SuggestionList(controller: widget.controller)
        .suggestionsCallback(pattern);
    setState(() {
      suggestions = updatedSuggestions;
    });
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
                title: Text("Where?",style: TextStyle(color: Colors.black),),
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
                bottom: AppBar(
                    elevation: 0.0, 
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Container(
                width: double.infinity,
                height: 40,
                //color: Colors.white,
                padding: EdgeInsets.all(1.0), // Add padding for the border
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey), // Add border
                  borderRadius: BorderRadius.circular(8.0), // Add border radius
                ),
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                       updateSuggestions(value);
                    },
                    onTap: () {
                      updateSuggestions(widget.controller.text);
                    },
                    controller:  widget.controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Country, City or airport',
                        prefixIcon: Icon(Icons.search , color: Colors.black,),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none, // Remove the focused border
                        ),
                  ),
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
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    
                    widget.controller.text = suggestions[index].substring(suggestions[index].length - 3);
                    debugPrint('You just selected ${suggestions[index]}');
                    print(widget.controller);

                      Navigator.pop(context, widget.controller.text);
                  },
                );
              },
            ),
          ),
         ],
      ),
    );
  }

}