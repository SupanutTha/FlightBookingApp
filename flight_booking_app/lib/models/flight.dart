class Flight {
  String type;
  String id;
  String source;
  bool instantTicketingRequired;
  bool nonHomogeneous;
  bool oneWay;
  DateTime lastTicketingDate;
  DateTime lastTicketingDateTime;
  int numberOfBookableSeats;
  List<Map<String, dynamic>> itineraries;
  Map<String, dynamic> price;
  Map<String, dynamic> pricingOptions;
  List<String> validatingAirlineCodes;
  List<Map<String, dynamic>> travelerPricings;

  Flight({
    required this.type,
    required this.id,
    required this.source,
    required this.instantTicketingRequired,
    required this.nonHomogeneous,
    required this.oneWay,
    required this.lastTicketingDate,
    required this.lastTicketingDateTime,
    required this.numberOfBookableSeats,
    required this.itineraries,
    required this.price,
    required this.pricingOptions,
    required this.validatingAirlineCodes,
    required this.travelerPricings,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      type: json['type'],
      id: json['id'],
      source: json['source'],
      instantTicketingRequired: json['instantTicketingRequired'],
      nonHomogeneous: json['nonHomogeneous'],
      oneWay: json['oneWay'],
      lastTicketingDate: DateTime.parse(json['lastTicketingDate']),
      lastTicketingDateTime: DateTime.parse(json['lastTicketingDateTime']),
      numberOfBookableSeats: json['numberOfBookableSeats'],
      itineraries: List<Map<String, dynamic>>.from(json['itineraries']),
      price: Map<String, dynamic>.from(json['price']),
      pricingOptions: Map<String, dynamic>.from(json['pricingOptions']),
      validatingAirlineCodes:
          List<String>.from(json['validatingAirlineCodes']),
      travelerPricings:
          List<Map<String, dynamic>>.from(json['travelerPricings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'source': source,
      'instantTicketingRequired': instantTicketingRequired,
      'nonHomogeneous': nonHomogeneous,
      'oneWay': oneWay,
      'lastTicketingDate': lastTicketingDate.toIso8601String(),
      'lastTicketingDateTime': lastTicketingDateTime.toIso8601String(),
      'numberOfBookableSeats': numberOfBookableSeats,
      'itineraries': itineraries,
      'price': price,
      'pricingOptions': pricingOptions,
      'validatingAirlineCodes': validatingAirlineCodes,
      'travelerPricings': travelerPricings,
    };
  }

 }

