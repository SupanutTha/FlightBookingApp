import 'dart:convert';
import 'dart:io';
import 'package:flight_booking_app/models/flight.dart';

import '/models/airline_db.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flight_booking_app/models/airline_logo_db.dart';
import '/models/airport_db.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _airportsDatabase;
  static Database? _airlineDatabase;
  static Database? _airlineLogoDatabase;
  static Database? _saveFlightsDatabase;

  DatabaseHelper._init();

  Future<Database> get airportsDatabase async {
    if (_airportsDatabase != null) return _airportsDatabase!;
    _airportsDatabase = await _initAirportsDB('airports.db');
    return _airportsDatabase!;
  }

  Future<Database> get airlinesDatabase async {
    if (_airlineDatabase != null) return _airlineDatabase!;
    _airlineDatabase = await _initAirlinesDB('airline.db');
    
    return _airlineDatabase!;
  }

  Future<Database> get airlinesLogoDatabase async {
    if (_airlineLogoDatabase != null) return _airlineLogoDatabase!;
    _airlineLogoDatabase = await _initAirlinesLogoDB('airlinesLogo.db');
    
    return _airlineLogoDatabase!;
  }
  
  Future<Database> get saveFlightsDatabase async{
    if(_saveFlightsDatabase != null) return _saveFlightsDatabase!;
    _saveFlightsDatabase = await _initSaveFlightsDB('saveFlights.db');

    return _saveFlightsDatabase!;
  }


  Future<Database> _initAirportsDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createAirportsDB);
  }

  Future<Database> _initAirlinesDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createAirlinesDB);
  }

  Future<Database> _initAirlinesLogoDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join (dbPath, dbName);
    print(path);
    return await openDatabase(path ,version: 1, onCreate: _createAirlinesLogoDB);
  }

  Future<Database> _initSaveFlightsDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join (dbPath, dbName);
    print(path);
    return await openDatabase(path ,version: 1, onCreate: _createSaveFlightDB);
  }

  Future<void> _createSaveFlightDB(Database db, int version) async {
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT'; 
  // Create the saveFlights table without any extra closing parenthesis
  await db.execute('''
    CREATE TABLE IF NOT EXISTS saveFlights (
      objectID $idType,
      saveFlights TEXT
    )
  ''');
}


  Future<void> _createAirportsDB(Database db, int version) async {
  final idType = 'TEXT PRIMARY KEY NOT NULL'; // Assuming objectID is a string
  final textType = 'TEXT NOT NULL';

  await db.execute('''
    CREATE TABLE IF NOT EXISTS airports (
      objectID $idType,
      name $textType,
      city $textType,
      country $textType,
      iata $textType,
      lat REAL,
      lon REAL,
      linksCount INTEGER,
      UNIQUE (objectID) ON CONFLICT REPLACE
    )
  ''');
}

  Future<void> _createAirlinesDB(Database db, int version) async {
  final idType = 'TEXT PRIMARY KEY NOT NULL'; // Assuming id is a string
  final textType = 'TEXT NOT NULL';
  print("check2");
  await db.execute('''
    CREATE TABLE IF NOT EXISTS airlines (
      id $idType,
      name $textType,
      alias TEXT,
      iata TEXT,
      icao TEXT,
      callsign TEXT,
      country TEXT,
      active TEXT,
      UNIQUE (id) ON CONFLICT REPLACE
    )
  ''');
}

  Future<void> _createAirlinesLogoDB (Database db , int version) async {
    final idType = 'TEXT PRIMARY KEY NOT NULL'; // Assuming objectID is a string
    final textType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE IF NOT EXISTS airlinesLogo (
      id $idType,
      lcc TEXT,
      name $textType,
      logo TEXT,
      UNIQUE (id) ON CONFLICT REPLACE
    )
  ''');
  print("create airlinelogo db success");
  }

  Future<void> insertAirlineLogoJsonToDatabase(List<dynamic> jsonList) async {
  final db = await instance.airlinesLogoDatabase;
  for (final json in jsonList) {
    final airlineLogo = AirlineLogo(
      id: json['id'],
      lcc : json['lcc'], // Replace with the correct field name in your JSON data
      name: json['name'], // Replace with the correct field name in your JSON data
      logo: json['logo'], // Replace with the correct field name in your JSON data
    );

    await db.insert('airlinesLogo', airlineLogo.toMap());
    print('Inserted airline logo: complete');
  }
}

  Future<void> dropAirportsTable() async {
    final db = await instance.airportsDatabase;
    await db.execute('DROP TABLE IF EXISTS airports');
  }
  Future<void> dropAirlineLogoTable() async {
    final db = await instance.airportsDatabase;
    await db.execute('DROP TABLE IF EXISTS airlinesLogo');
    await db.execute('DROP TABLE IF EXISTS airlineLogo');
    print("Drop complete");
  }

  Future<int> insertAirport(Airport airport) async {
    final db = await instance.airportsDatabase;
    return await db.insert('airports', airport.toMap());
  }

Future<void> insertSaveFlightData(List<Flight> selectedFlights) async {
  final db = await instance.saveFlightsDatabase;

  // Serialize the selected flights to JSON
  final flightListJson = selectedFlights.map((flight) => flight.toJson()).toList();
  final flightListString = json.encode(flightListJson);

  await db.insert(
    'saveFlights',
    {
      'saveFlights': flightListString,
    },
  );
  print('Flight data after insertion:');
  // Retrieve the saved flight data from the database and print it
  final savedFlights = await instance.retrieveSavedFlights();
  savedFlights.forEach((flight) {
    print(flight.toJson());
  });
}


 Future<List<Flight>> retrieveSavedFlights() async {
  final db = await saveFlightsDatabase;

  final List<Map<String, dynamic>> maps = await db.query('saveFlights');

  return List.generate(maps.length, (i) {
    final flightListJson = json.decode(maps[i]['saveFlights']);
    final flightList = List<Map<String, dynamic>>.from(flightListJson);
    return Flight.fromJson(flightList[i]);
  });
}


  Future<List<AirlineLogo>> retrieveAirlinesLogo() async {
    final db = await instance.airlinesLogoDatabase;
    final List<Map<String ,dynamic>> map = await db.query('airlinesLogo');

    return List.generate(map.length, (i){
      return AirlineLogo(
        id:  map[i]['id'], 
        lcc: map[i]['lcc'], 
        name: map[i]['name'], 
        logo: map[i]['logo']);

    });

  }

  Future<List<Airport>> retrieveAirports() async {
  final db = await instance.airportsDatabase;
  final List<Map<String, dynamic>> maps = await db.query('airports');
  
  return List.generate(maps.length, (i) {
    return Airport(
      objectID: maps[i]['objectID'],
      name: maps[i]['name'],
      city: maps[i]['city'],
      country: maps[i]['country'],
      iata: maps[i]['iata'],
      lat: maps[i]['lat'],
      lon: maps[i]['lon'],
      linksCount: maps[i]['linksCount'],
    );
  });
}

Future<List<Airline>> retrieveAirlines() async {
  final db = await instance.airlinesDatabase;
  final List<Map<String, dynamic>> maps = await db.query('airlines');

  return List.generate(maps.length, (i) {
    return Airline(
      id: maps[i]['id'],
      name: maps[i]['name'],
      alias: maps[i]['alias'],
      iata: maps[i]['iata'],
      icao: maps[i]['icao'],
      callsign: maps[i]['callsign'],
      country: maps[i]['country'],
      active: maps[i]['active'],
    );
  });
}

  Future<void> close() async {
    final db = await instance.airportsDatabase;
    db.close();
  }
  
  Future<void> insertAirportJsonToDatabase(List<dynamic> jsonList) async {
    final db = await instance.airportsDatabase;
    for (final json in jsonList) {
      final airport = Airport(
        objectID: json['objectID'],
        name: json['name'],
        city: json['city'],
        country: json['country'],
        iata: json['iata_code'],
        lat: json['_geoloc']['lat'],
        lon: json['_geoloc']['lng'],
        linksCount: json['links_count'],
      );
      await db.insert('airports', airport.toMap());
      print('insert complete}');
    }
    
  }

  Future<List<dynamic>> fetchJsonData() async {
  final String jsonString = await rootBundle.loadString('airports_data.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData;
}
  Future<String> loadAsset(String assetPath) async {
  final data = await rootBundle.loadString(assetPath);
  return data;
}

  
  Future<void> insertAirlinesJsonToDatabase(List<dynamic> jsonList) async {
  final db = await instance.airlinesDatabase;
  for (final json in jsonList) {
      final airline = Airline(
        id: json['id'], 
        name: json['name'], 
        alias: json['alias'], 
        iata: json['iata'], 
        icao: json['icao'], 
        callsign: json['callsign'], 
        country: json['country'], 
        active: json['active']
        );

    await db.insert('airlines',airline.toMap());
    print('Inserted airline: complete');
  }
}

Future<String> getAirlineNameByCode(String iata) async {
  final maps = await _airlineDatabase?.query(
    'airlines',
    columns: ['name'],
    where: 'iata = ?',
    whereArgs: [iata],
  );

  if (maps != null && maps.isNotEmpty) {
    final name = maps.first['name'];
    if (name != null) {
      return name.toString();
    }
  }
  return 'Unknown Airline';
}


Future<String> findCityAndCountry(String iata) async {
    final airports = await retrieveAirports();
    final matchingAirport = airports.firstWhere(
      (airport) => airport.iata.toUpperCase() == iata.toUpperCase(),
    );

    if (matchingAirport != null) {
      final cityAndCountry = '${matchingAirport.city}, ${matchingAirport.country}';
      return cityAndCountry;
    } else {
      // Handle the case where no matching airport was found.
      return 'Unknown';
    }
  }

   Future<String> findLogo(String iata) async {
    final logo = await retrieveAirlinesLogo();
    final airline = await retrieveAirlines();
    final matchingAirline = airline.firstWhere(
      (airline) => airline.iata.toUpperCase() == iata.toUpperCase(),
      // orElse: () => Airline(), // Provide a default value if not found
    );

    if (matchingAirline.name != null) {
      final airlineName = matchingAirline.name;
      final matchLogo = logo.firstWhere(
        (logo) => logo.name.toUpperCase() == airlineName.toUpperCase(),
         orElse: () => AirlineLogo(name: '', id: '', lcc: '', logo: 'https://www.iconsdb.com/icons/preview/red/error-7-xxl.png'), // Provide a default value if not found
      );

      if (matchLogo.logo != null) {
        final logoPic = matchLogo.logo;
        return logoPic;
      } else {
        return 'Unknown';
      }
    } else {
      // Handle the case where no matching airline was found.
      return 'Unknown';
    }
  }

  Future<String> findAirportNameByIATA(String iata) async {
  final airports = await retrieveAirports();
  final matchingAirport = airports.firstWhere(
    (airport) => airport.iata.toUpperCase() == iata.toUpperCase(),
    orElse: () => Airport(objectID: '', name: 'Unknown', city: '', country: '', iata: '', lat: 0, lon: 0, linksCount: 0), // Provide a default value if not found
  );

  if (matchingAirport != null) {
    return matchingAirport.name;
  } else {
    // Handle the case where no matching airport was found.
    return 'Unknown';
  }
}


}

