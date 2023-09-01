// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SearchFlightPopUp extends StatefulWidget{
  @override
  State<SearchFlightPopUp> createState() => _SearchFlightPopUpState();

}

class _SearchFlightPopUpState extends State<SearchFlightPopUp> {
  @override
  Widget build(BuildContext context) {
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
                // flexibleSpace: FlexibleSpaceBar(// Disable stretching
                //   titlePadding: EdgeInsets.zero,
                //   collapseMode: CollapseMode.none,
                //   stretchModes: [],
                //   title: Row(
                //     children: [
                //       Text("  Where?",style: TextStyle(color: Colors.black),),
                //     ],
                //   ),
                // ),
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
                child: const Center(
                  child: TextField(
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
        ],
      ),
    );
  }

}