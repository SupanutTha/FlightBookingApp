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
      // print("check token"); 
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
        // print("token grain");
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

  static Future<List<List<Flight>>> searchFlights( FlightSearchData searchData) async {
    final accessToken = await getAccessToken();
  try {

    final baseUrl = 'https://test.api.amadeus.com/v2/shopping/flight-offers';
    final dateFormatter = DateFormat('yyyy-MM-dd'); // set format date
    //print(searchData.getEffectiveDate()!); // check that what date data is available 
    final departureDate = dateFormatter.format(searchData.departureDate!); // change format date
    final maxFlights = 50; // Set the maximum number of flight results to display .now recommend 2 is maximun if set maximum more than it can search it gonna bug it list

    print("check search");
    print(searchData.departure);
    print(searchData.arrival);
    print(searchData.cabinClass);
    print(departureDate);
    print(searchData.adultCount);
    print(searchData.kidCount);
    print(searchData.babyCount);
    print(accessToken);
    // 1. Search for outbound flights
    final outboundResponse = await http.get(
      Uri.parse(
        '$baseUrl?originLocationCode=${searchData.departure}&destinationLocationCode=${searchData.arrival}&departureDate=$departureDate&adults=${searchData.adultCount}&children=${searchData.kidCount}&infants=${searchData.babyCount}&travelClass=${searchData.cabinClass}',
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(outboundResponse.statusCode);
    print('return date :${searchData.returnDate}');
    // 2. Search for return flights
    if (searchData.returnDate == null){
      searchData.returnDate = searchData.departureDate;
    }
    final returnDate = dateFormatter.format(searchData.returnDate!);
     print(returnDate);
    final returnResponse = await http.get(
      Uri.parse(
        '$baseUrl?originLocationCode=${searchData.arrival}&destinationLocationCode=${searchData.departure}&departureDate=$returnDate&adults=${searchData.adultCount}&children=${searchData.kidCount}&infants=${searchData.babyCount}&travelClass=${searchData.cabinClass}',
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(returnResponse.statusCode);
    if (outboundResponse.statusCode == 200 && returnResponse.statusCode == 200) {
    
      Map<String, dynamic> outboundData = json.decode(outboundResponse.body);
      List<dynamic> outboundFlightData = outboundData['data'];
      Map<String , dynamic> returnData = json.decode(returnResponse.body);
      List<dynamic> returnFlightData = returnData['data'];

      int numOutboundResults = outboundFlightData.length;
      int numReturnResults = returnFlightData.length;


      print("out flight: ${numOutboundResults}");
      print("return flight: ${numReturnResults}");

      // check that it dont add flight in list more than maximum
      // it not working propaly if the flight that can search less than maximum = bug ;-;
      if (numOutboundResults > maxFlights) {
        outboundFlightData = outboundFlightData.sublist(0, maxFlights); // Take only the first 'max' flight results
      }
      if (numReturnResults > maxFlights) {
        returnFlightData = returnFlightData.sublist(0, maxFlights); // Take only the first 'max' flight results
      }

      // print(outboundFlightData);
      // print(returnFlightData);
      List<Flight> outboundResults = outboundFlightData.map((flight) => Flight.fromJson(flight)).toList(); //change json to list
      List<Flight> returnResults = returnFlightData.map((flight) => Flight.fromJson(flight)).toList(); // change jason to list
      print("out flight: ${outboundResults}");
      print("in flight: ${returnResults}");

      // Combine outbound and return results into a single list
      List<Flight> resultsOut = [];
      resultsOut.addAll(outboundResults);
      // print("result list: ${results}");
      

      // if the bug that one way trip show flight back trip by if one way trip not adding flight back trip in list
      List<Flight> resultsIn = [];
      print(departureDate);
      print(returnData);
      if (departureDate != returnDate){
        resultsIn.addAll(returnResults);
      }
      
      return [resultsOut,resultsIn];

      
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
