import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../utilities/accessToken.dart';
import '../models/flight.dart';
import '../models/flight_search_data.dart';

class ApiService {
  static Future<String> getAccessToken() async {
    try { // exception to check api status
      final tokenUrl = 'https://test.api.amadeus.com/v1/security/oauth2/token';
      final clientId = 'PBjFEhvGHXAzDb6blW0BRCcORKTiZKMj';
      final clientSecret = '4Pf1CUcDoTBgL5DB';
      print("check token"); 
      final response = await http.post( // call api for amadeus to gain acess token
        Uri.parse('$tokenUrl'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      );
      //exception
      if (response.statusCode == 200) {
        AccessToken accessToken = AccessToken.fromJson(json.decode(response.body));
        //searchFlights(accessToken);
        print("token grain");
        return accessToken.accessToken;
      } else {
        throw Exception('Failed to retrieve access token');
      }
    } catch (e) {
      // return error
      print('Error: $e');
      throw Exception('Failed to retrieve access token');
    }
  }

  static Future<(List<Flight>, List<Flight>)> searchFlights( FlightSearchData searchData) async {
    final accessToken = await getAccessToken();
  try {
    var flightClass = '';
    if ( searchData.isEconomicClass){
      flightClass = 'ECONOMY';
    }
    else if( searchData.isBusinessClass){
      flightClass = 'BUSINESS';
    }
    else if( searchData.isPremiumEconomicClass){
      flightClass = 'PREMIUM_ECONOMY';
    }
    else if( searchData.isPremiumEconomicClass){
      flightClass = 'FIRST';
    }

    final baseUrl = 'https://test.api.amadeus.com/v2/shopping/flight-offers';
    final dateFormatter = DateFormat('yyyy-MM-dd'); // set format date
    print(searchData.getEffectiveDate()!); // check that what date data is available 
    final formattedDate = dateFormatter.format(searchData.getEffectiveDate()!); // change format date
    final maxFlights = 50; // Set the maximum number of flight results to display .now recommend 2 is maximun if set maximum more than it can search it gonna bug it list

    print("check search");
    print(searchData.departure);
    print(searchData.arrival);
    print(flightClass);
    print(accessToken);
    // 1. Search for outbound flights
    final outboundResponse = await http.get(
      Uri.parse(
        '$baseUrl?originLocationCode=${searchData.departure}&destinationLocationCode=${searchData.arrival}&departureDate=$formattedDate&adults=${searchData.adultCount}&children=${searchData.kidCount}&infants=${searchData.babyCount}&travelClass=$flightClass',
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    // 2. Search for return flights
    final returnDate = dateFormatter.format(searchData.getEffectiveDateReturn()!);
    final returnResponse = await http.get(
      Uri.parse(
        '$baseUrl?originLocationCode=${searchData.arrival}&destinationLocationCode=${searchData.departure}&departureDate=$returnDate&adults=${searchData.adultCount}&children=${searchData.kidCount}&infants=${searchData.babyCount}&travelClass=$flightClass',
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(outboundResponse.statusCode);
    print(returnResponse.statusCode);
    if (outboundResponse.statusCode == 200 && returnResponse.statusCode == 200) {
    
      Map<String, dynamic> outboundData = json.decode(outboundResponse.body);
      List<dynamic> outboundFlightData = outboundData['data'];
      Map<String , dynamic> returnData = json.decode(returnResponse.body);
      List<dynamic> returnFlightData = returnData['data'];

      int numOutboundResults = outboundFlightData.length;
      int numReturnResults = returnFlightData.length;


      print("out flight: ${numOutboundResults}");

      // check that it dont add flight in list more than maximum
      // it not working propaly if the flight that can search less than maximum = bug ;-;
      if (numOutboundResults > maxFlights) {
        outboundFlightData = outboundFlightData.sublist(0, maxFlights); // Take only the first 'max' flight results
      }
      if (numReturnResults > maxFlights) {
        returnFlightData = returnFlightData.sublist(0, maxFlights); // Take only the first 'max' flight results
      }

      print("check maximum flight limit if");
      print(outboundFlightData);
      List<Flight> outboundResults = outboundFlightData.map((flight) => Flight.fromJson(flight)).toList(); //change json to list
      List<Flight> returnResults = returnFlightData.map((flight) => Flight.fromJson(flight)).toList(); // change jason to list
      print("check");
      // print("out flight: ${outboundResults}");
      // print("in flight: ${returnResults}");

      // Combine outbound and return results into a single list
      List<Flight> resultsOut = [];
      resultsOut.addAll(outboundResults);
      // print("result list: ${results}");
      

      // if the bug that one way trip show flight back trip by if one way trip not adding flight back trip in list
      List<Flight> resultsIn = [];
      if (searchData.selectedDate == null){
        resultsIn.addAll(returnResults);
      }
      return (resultsOut,resultsIn);

      
        // print("set state");
        // _searchResults = resultsOut;
        // _searchResultsReturn = resultsIn;
        // _isLoading = false; // Set loading to false after processing the API response
        // print("set state2");
      
    } else {
      // setState(() {
      //   _isLoading = false; // Set loading to false if the API call failed
      // });
      throw Exception('Failed to load flights');
    }
  } catch (e) {
    // setState(() {
    //   _isLoading = false; // Set loading to false if an error occurred
    // });
    // check any errors
    print('Error: $e');
    throw Exception('Failed to load flights');
  }
}
  
  
}
