import 'package:flutter/material.dart';

class TransactionToggle extends StatefulWidget {
  TransactionToggle({
    required this.children ,
    List<bool>? initialSelection,
    required this.onToggleChanged,
    }) {
     _isSelected = initialSelection ?? List.generate(children.length, (index) => false);
  }
  final List<Widget> children;
  late final List<bool> _isSelected;
  final ValueChanged<int> onToggleChanged;
  @override
  _TransactionToggleState createState() => _TransactionToggleState();
}

class _TransactionToggleState extends State<TransactionToggle> {
  @override
  Widget build(BuildContext context) {
    var children = widget.children;
    var _isSelected = widget._isSelected;
    return Center(
      child: ToggleButtons(
        children: children,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < _isSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                if (!_isSelected[index]){ 
                  _isSelected[buttonIndex] = true;
                  widget.onToggleChanged(index);
                  }
              } else {
                _isSelected[buttonIndex] = false;
              }
            }
          });
        },
        isSelected: _isSelected,
        borderRadius: BorderRadius.circular(30),
        selectedColor: Colors.white,
        fillColor:  const Color(0xFFEC441E),
        borderColor:  const Color(0xFFEC441E),
        selectedBorderColor:  const Color(0xFFEC441E),
        borderWidth: 2,
        splashColor: Color.fromARGB(255, 211, 79, 18),
        constraints: BoxConstraints.expand(
            width:
                MediaQuery.of(context).size.width / (1.7 * _isSelected.length),
            height: 35),
      ),
    );
  }
}