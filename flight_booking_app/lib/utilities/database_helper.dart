import 'dart:convert';
import '/models/airline_db.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '/models/airport_db.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _airportsDatabase;
  static Database? _airlineDatabase;

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
  
  get http => null;

  Future<Database> _initAirportsDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createAirportsDB);
  }

  Future<Database> _initAirlinesDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 1, onCreate: _createAirlinesDB);
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


  Future<void> dropAirportsTable() async {
    final db = await instance.airportsDatabase;
    await db.execute('DROP TABLE IF EXISTS airports');
  }

  Future<int> insertAirport(Airport airport) async {
    final db = await instance.airportsDatabase;
    return await db.insert('airports', airport.toMap());
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

  Future<Airline?> getAirlineByCode(String iata) async {
    final maps = await _airlineDatabase?.query(
      'airlines',
      columns: ['name', 'iata'],
      where: 'itata = ?',
      whereArgs: [iata],
    );
    if (maps!.isNotEmpty) {
      return Airline.fromMap(maps.first);
    }
    return null;
  }

  Future<String> getAirlineName(String carrierCode) async {
  Airline? airline = await getAirlineByCode(carrierCode);
  return airline?.name ?? "Unknown Airline";
}


}

