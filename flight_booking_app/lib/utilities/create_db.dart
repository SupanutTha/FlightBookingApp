import 'dart:convert';
import 'package:flight_booking_app/models/airline_db.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreateDb{

  createAirplaneAirlineDb() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print("initialized");
  final dbHelper = DatabaseHelper.instance; // Create an instance of DatabaseHelper
  print("check database init");
  // Initialize the database

  try {
    await DatabaseHelper.instance.airlinesDatabase;
    print("airline Database initialized successfully");
  } catch (e) {
    print("Error initializing database: $e");
  }

  try{
    await DatabaseHelper.instance.airportsDatabase;
   print("airports Database initialized successfully");
  } catch (e) {
    print("Error initializing database: $e");
  }

  try{
     await DatabaseHelper.instance.airlinesLogoDatabase;
   print("airline logo Database initialized successfully");
  } catch (e) {
    print("Error initializing database: $e");
  }

   try{
     await DatabaseHelper.instance.saveFlightsDatabase;
   print("airline logo Database initialized successfully");
  } catch (e) {
    print("Error initializing database: $e");
  }
  
  // add data in database
  final jsonString = await dbHelper.loadAsset('assets/json/airports_data.json');
  final jsonData = json.decode(jsonString);
   try{
    await dbHelper.insertAirportJsonToDatabase(jsonData);
    print("insert data successfully");
   }
   catch(e){
    print("Erorr to insert data: ${e}");
   }
   print("check after insert");

  final jsonString2 = await dbHelper.loadAsset('assets/json/airlines_data.json');
  final jsonData2 = json.decode(jsonString2);

  try {
    await dbHelper.insertAirlinesJsonToDatabase(jsonData2);
    print("Insert data successfully");
  } catch (e) {
    print("Error inserting data: $e");
  }

  final jsonString3 = await dbHelper.loadAsset('assets/json/airlines_logo_data.json');
  final jsonData3 = json.decode(jsonString3);
  try {
    await dbHelper.insertAirlineLogoJsonToDatabase(jsonData3);
    print("Insert data successfully");
  } catch (e) {
    print("Error inserting data: $e");
  }


  
  final airports = await dbHelper.retrieveAirports();
  airports.forEach((airport) {
    // print(airport.name);
  });

  final airlines = await dbHelper.retrieveAirlines();
  airlines.forEach((airline){
    // print(airline.name);
  }) ;

  try {
    final airlinesLogo = await dbHelper.retrieveAirlinesLogo();
    airlinesLogo.forEach((element) {
      print(element);
    });
  } catch (e) {
    print("Error retrieving airlinesLogo data: $e");
  }


  }

}