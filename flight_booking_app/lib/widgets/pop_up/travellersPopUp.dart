import 'package:flutter/material.dart';

class TravellersPopUp extends StatefulWidget {
  final TextEditingController adultController;
  final TextEditingController kidController;
  final TextEditingController babyController;
  final Function onChanged;
  const TravellersPopUp({
    super.key, 
    required this.adultController, 
    required this.kidController, 
    required this.babyController,
    required this.onChanged,
    });
  @override
  _TravellersPopUpState createState() => _TravellersPopUpState();
}

class _TravellersPopUpState extends State<TravellersPopUp> {
  int adults = 0;
  int kids = 0;
  int infants = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the values from the TextEditingControllers
    adults = int.tryParse(widget.adultController.text) ?? 0;
    kids = int.tryParse(widget.kidController.text) ?? 0;
    infants = int.tryParse(widget.babyController.text) ?? 0;
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
                  "Travellers",
                  style: TextStyle(color: Colors.black),
                ),
                iconTheme: IconThemeData(color: Colors.black),
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
                          "Select Travellers Number",
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
                buildRow("Adults", adults, (value) {
                  setState(() {
                    adults = value;
                  });
                }),
                buildRow("Children", kids, (value) {
                  setState(() {
                    kids = value;
                  });
                }),
                buildRow("Infants", infants, (value) {
                  setState(() {
                    infants = value;
                  });
                }),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                Text(" "),
                OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              backgroundColor:
                  const Color(0xFFEC441E),
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                SizedBox(width: 10,height: 50,), 
                Text('Selected Date',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),),
              ],
            ),
            // onPressed: () {
            //   widget.controller = widget.selectedDate as TextEditingController;
            //   debugPrint('You just selected ${widget.controller}');
            //   print(widget.controller);
            //   print(context);
            //   Navigator.pop(context, widget.controller);
            // },
            onPressed: (){
              widget.adultController.text = adults.toString();
              widget.kidController.text = kids.toString();
              widget.babyController.text = infants.toString();
              widget.onChanged;
              debugPrint('All traveller  = adult :${widget.adultController} Kid :${widget.kidController} infants :${widget.babyController}');
              Navigator.pop(context );
            },
          ),
              ],
            ),
          ),
           

        ],
      ),
    );
  }

  Widget buildRow(String title, int value, ValueChanged<int> onChanged) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (value > 0) {
                    onChanged(value - 1);
                     widget.onChanged();
                  }
                  setState(() {
                  });
                },
              ),
              Text(value.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  onChanged(value + 1);
                   widget.onChanged();
                   setState(() {
                   });
                },
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
