class Airport {
  late final String objectID; // Unique identifier for the airport
  late final String name;
  late final String city;
  late final String country;
  late final String iata;
  late final double lat;
  late final double lon;
  late final int linksCount;

  Airport({
    required this.objectID,
    required this.name,
    required this.city,
    required this.country,
    required this.iata,
    required this.lat,
    required this.lon,
    required this.linksCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'objectID': objectID,
      'name': name,
      'city': city,
      'country': country,
      'iata': iata,
      'lat': lat,
      'lon': lon,
      'linksCount': linksCount,
    };
  }

  factory Airport.fromMap(Map<String, dynamic> map) {
    return Airport(
      objectID: map['objectID'],
      name: map['name'],
      city: map['city'],
      country: map['country'],
      iata: map['iata_code'],
      lat: map['_geoloc']['lat'],
      lon: map['_geoloc']['lng'],
      linksCount: map['links_count'],
    );
  }
}
