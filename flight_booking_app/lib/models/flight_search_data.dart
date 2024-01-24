class FlightSearchData {
   String departure;
   String arrival;
   String adultCount;
   String kidCount;
   String babyCount;
   DateTime? departureDate;
   DateTime? returnDate;
   String cabinClass;

  FlightSearchData({
    required this.departure,
    required this.arrival,
    required this.adultCount,
    required this.kidCount,
    required this.babyCount,
    required this.departureDate,
    required this.returnDate,
    required this.cabinClass,
  });
  
 }