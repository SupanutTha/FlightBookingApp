class Airline {
  final String id;
  final String name;
  final String alias;
  final String iata;
  final String icao;
  final String callsign;
  final String country;
  final String active;

  Airline({
    required this.id,
    required this.name,
    required this.alias,
    required this.iata,
    required this.icao,
    required this.callsign,
    required this.country,
    required this.active,
  });

  factory Airline.fromMap(Map<String, dynamic> map) {
    return Airline(
      id: map['id'],
      name: map['name'],
      alias: map['alias'],
      iata: map['iata'],
      icao: map['icao'],
      callsign: map['callsign'],
      country: map['country'],
      active: map['active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'iata': iata,
      'icao': icao,
      'callsign': callsign,
      'country': country,
      'active': active,
    };
  }
}
