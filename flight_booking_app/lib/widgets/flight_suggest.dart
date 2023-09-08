import 'package:flutter/material.dart';

// class FlightSuggestList extends StatelessWidget {
//   final List<Widget> flightSuggestions;

//   FlightSuggestList({required this.flightSuggestions});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: flightSuggestions.length,
//       itemBuilder: (context, index) {
//         return flightSuggestions[index];
//       },
//     );
//   }
// }

Widget flightSuggestions (){
  return Container(
    padding: EdgeInsets.only(top: 15),
    alignment: Alignment.topCenter,
    child: Container(
      width: 400,
      height: 250,
      decoration: BoxDecoration( 
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
         boxShadow : [
          BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
          offset: Offset(0,2),
          blurRadius: 4
        )],
        color : Color.fromRGBO(255, 255, 255, 1),
        border : Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
          style: BorderStyle.none
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(height: 50),
                Expanded(flex: 3, child: Row(
                  children: [
                    Text('logo'),
                    Text("test1" , style:TextStyle(fontSize: 17 , fontWeight:FontWeight.bold,)),
                  ],
                )),
                Expanded(flex :1 ,child: Text("01 hr 40 min"))
              ],
            ),
            Row(
              children: [
                SizedBox(height:70),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("test1" ,style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                       Text("test1" ,style: TextStyle(),textAlign: TextAlign.left,),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("line")),
                Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text("test1" ,style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                      Text("test1" ,style: TextStyle(),textAlign: TextAlign.left,),
                  ],
                ),
              ),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(height: 40),
                Expanded(flex: 3, child: Text("test1" , style:TextStyle(fontSize: 17 , fontWeight:FontWeight.bold,))),
                Expanded(flex :1 ,child: Row(
                  children: [
                    Text("Form"),
                    Text(' \$555' ,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                  ],
                ))
              ],
            ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor:
                    const Color(0xFFEC441E),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(Icons.search , color: Colors.white,),
                  SizedBox(height: 45,), 
                  Text('Search Flights',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),),
                ],
              ),
              onPressed: () {
                
              },
            ),
          ],
        ),
      ),
  )
  );
  // return Container(
      
  //     // width: 343,
  //     // height: 229,
      
  //     child: Stack(
        
  //       children: <Widget>[
  //         Positioned(
  //       top: 0,
  //       left: 0,
  //       child: Container( // white box
        
  //       width: 343,
  //       height: 212,
  //       decoration: BoxDecoration( 
  //         borderRadius : BorderRadius.only(
  //           topLeft: Radius.circular(15),
  //           topRight: Radius.circular(15),
  //           bottomLeft: Radius.circular(15),
  //           bottomRight: Radius.circular(15),
  //         ),
  //     boxShadow : [BoxShadow(
  //         color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
  //         offset: Offset(0,2),
  //         blurRadius: 4
  //     )],
  //     color : Color.fromRGBO(255, 255, 255, 1),
  //     border : Border.all(
  //         color: Color.fromRGBO(0, 0, 0, 1),
  //         width: 1,
  //       ),
  //      )
  //     )
  //     ),Positioned(
  //       top: 124,
  //       left: 19,
  //       child: Text('Business Class', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 12,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 124,
  //       left: 246,
  //       child: Text('From', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 12,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 106,
  //       left: 0,
  //       child: Divider(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       thickness: 1
  //     )
      
  //     ),Positioned(
  //       top: 229,
  //       left: 0,
  //       child: Divider(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       thickness: 1
  //     )
      
  //     ),Positioned(
  //       top: 20,
  //       left: 56,
  //       child: Text('IN 239', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 15,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 20,
  //       left: 246,
  //       child: Text('01 hr 40 min', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 12,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 61,
  //       left: 19,
  //       child: Text('5.50 AM', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 15,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 58,
  //       left: 259,
  //       child: Text('5.50 AM', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 15,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 20,
  //       left: 19,
  //       child: Container(
  //       width: 25,
  //       height: 24,
  //       decoration: BoxDecoration(
  //         color : Color.fromRGBO(217, 217, 217, 1),
  //     borderRadius : BorderRadius.all(Radius.elliptical(25, 24)),
  // )
  //     )
  //     ),Positioned(
  //       top: 69,
  //       left: 113,
  //       child: Text("test")
  //     //   SvgPicture.asset(
  //     //   'assets/images/arrow2.svg',
  //     //   semanticsLabel: 'arrow2'
  //     // )
      
  //     ),Positioned(
  //       top: 58,
  //       left: 162,
  //       child: Container(
  //       width: 19,
  //       height: 21,
  //       decoration: BoxDecoration(
  //         color : Color.fromRGBO(217, 217, 217, 1),
  //     borderRadius : BorderRadius.all(Radius.elliptical(19, 21)),
  // )
  //     )
  //     ),Positioned(
  //       top: 122,
  //       left: 289,
  //       child: Text('\$230', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(0, 0, 0, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 15,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),Positioned(
  //       top: 159,
  //       left: 19,
  //       child: Container(
  //       width: 300,
  //       height: 40,
  //       decoration: BoxDecoration(
  //         borderRadius : BorderRadius.only(
  //           topLeft: Radius.circular(10),
  //           topRight: Radius.circular(10),
  //           bottomLeft: Radius.circular(10),
  //           bottomRight: Radius.circular(10),
  //         ),
  //     color : Color.fromRGBO(255, 95, 26, 1),
  // )
  //     )
  //     ),Positioned(
  //       top: 172,
  //       left: 148,
  //       child: Text('Check', textAlign: TextAlign.left, style: TextStyle(
  //       color: Color.fromRGBO(255, 255, 255, 1),
  //       fontFamily: 'Inter',
  //       fontSize: 15,
  //       letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
  //       fontWeight: FontWeight.normal,
  //       height: 1
  //     ),)
  //     ),
  //       ]
  //     )
  //   );

}