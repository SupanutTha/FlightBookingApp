import 'package:flutter/foundation.dart';

import 'flight.dart'; // Assuming you have a Flight class defined

class SaveFlights {
  static List<List<Flight>> _saveFlights = [];

  static List<List<Flight>> get saveFlights => _saveFlights;

  static void addSaveFlight(List<Flight> flights) {
    _saveFlights.add(flights);
  }

  static void removeSaveFlight(List<Flight> flights) {
    _saveFlights.remove(flights);
  }
   static bool isTripSaved(List<Flight> trip) {
    for (var savedTrip in saveFlights) {
      if (listEquals(savedTrip, trip)) {
        return true;
      }
    }
    return false;
  }
}