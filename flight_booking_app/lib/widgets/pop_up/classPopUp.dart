import 'package:flutter/material.dart';

class ClassPopUp extends StatefulWidget {
  final TextEditingController controller;

  const ClassPopUp({super.key, required this.controller});

  @override
  _ClassPopUpState createState() => _ClassPopUpState();
}

class _ClassPopUpState extends State<ClassPopUp> {
  String selectedClass = 'Economic';

  void selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Cabin Class",
                  style: TextStyle(color: Colors.black),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                bottom: AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        Text(
                          "Select class",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 115,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                buildClassTile("Economic"),
                buildDivider(), // Divider between classes
                buildClassTile("Premium Economic"),
                buildDivider(), // Divider between classes
                buildClassTile("Business"),
                buildDivider(), // Divider between classes
                buildClassTile("First"),
                buildDivider(),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: const Color(0xFFEC441E),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Text(
                        'Selected class',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    widget.controller.text = selectedClass;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClassTile(String className) {
    return InkWell(
      onTap: () {
        selectClass(className);
      },
      child: ListTile(
        title: Text(className),
        leading: Radio(
          value: className,
          groupValue: selectedClass,
          onChanged: (value) {
            selectClass(value!);
          },
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: Colors.grey, // You can customize the color of the line
      thickness: 0.3, // You can customize the thickness of the line
      height: 0.0, // You can customize the height of the line
    );
  }
}
