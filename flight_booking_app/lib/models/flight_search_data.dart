class FlightSearchData {
   String departure;
   String arrival;
   String adultCount;
   String kidCount;
   String babyCount;
   DateTime? departureDate;
   DateTime? returnDate;
   String cabinClass;
  // final bool isEconomicClass;
  // final bool isPremiumEconomicClass;
  // final bool isBusinessClass;
  // final bool isFirstClass;

  FlightSearchData({
    required this.departure,
    required this.arrival,
    required this.adultCount,
    required this.kidCount,
    required this.babyCount,
    required this.departureDate,
    required this.returnDate,
    required this.cabinClass,
    // required this.selectedDate,
    // required this.isEconomicClass,
    // required this.isPremiumEconomicClass,
    // required this.isBusinessClass,
    // required this.isFirstClass,
  });
  
  // check what date value have data
  // if one way trip = selectedDate has data
  // if reound flight = selectedRange.first has data
  // it not good but it work
//   DateTime? getEffectiveDate() { // ? = datetime format
//     return selectedDate ?? selectedRange.first;
//   }

//   DateTime? getEffectiveDateReturn() {
//     return selectedDate ?? selectedRange.last;
//   }
 }