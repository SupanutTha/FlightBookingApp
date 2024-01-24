import 'package:flutter/material.dart';

class ToggleButtonsApp extends StatelessWidget {
  const ToggleButtonsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: ToggleButtonsTrip(),
      ),
    );
  }
}

enum TripOption { oneway, round }

const List<(TripOption, String)> tripOptions = <(TripOption, String)>[
  (TripOption.oneway, 'One way'),
  (TripOption.round, 'Round'),
];

class ToggleButtonsTrip extends StatefulWidget {
  const ToggleButtonsTrip({super.key});

  @override
  State<ToggleButtonsTrip> createState() => _ToggleButtonsTripState();
}

class _ToggleButtonsTripState extends State<ToggleButtonsTrip> {
  // final List<bool> _toggleButtonsSelection =
  //     TripOption.values.map((TripOption e) => e == TripOption.oneway).toList();
  // Set<TripOption> _segmentedButtonSelection = <TripOption>{TripOption.oneway};
  int _selectedOptionIndex = 0; // Track the selected option index
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          ToggleButtons(
            isSelected: List.generate(tripOptions.length, (index) => index == _selectedOptionIndex),
            onPressed: (int index) {
              setState(() {
                _selectedOptionIndex = index;
              });
            },
            constraints: const BoxConstraints(
              minHeight: 32.0,
              minWidth: 56.0,
            ),
            children: tripOptions
                .map(((TripOption, String) trip) => Text(trip.$2))
                .toList(),
          ),
        ],
      ),
    );
  }
}
