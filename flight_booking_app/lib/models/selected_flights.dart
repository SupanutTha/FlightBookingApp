import 'flight.dart';

class SelectedFlights {
  static List<Flight> _selectedFlights = [];

  static List<Flight> get selectedFlights => _selectedFlights;

  static void addSelectedFlight(Flight flight) {
    _selectedFlights.add(flight);
  }

  static void removeSelectedFlight(Flight flight) {
    _selectedFlights.remove(flight);
  }
}
