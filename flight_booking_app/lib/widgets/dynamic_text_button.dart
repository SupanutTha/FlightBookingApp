import 'package:flutter/material.dart';
import 'xen_popup/xen_card.dart';

class DynamicTextButton extends StatefulWidget{
  final String textController;
  final String buttonText;
  final IconData icon; 
  final Widget buttonAction;

  const DynamicTextButton({
    super.key,
    required this.textController,
    required this.buttonText,
    required this.icon,
    required this.buttonAction

    });

  @override
  _DynamicTextButtonState createState() => _DynamicTextButtonState();

}

class _DynamicTextButtonState extends State<DynamicTextButton> {
  @override
  Widget build(BuildContext context) {
   return  OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        backgroundColor:const Color.fromARGB(11, 0, 0, 0),
        //minimumSize: Size(160, 50)
        //fixedSize: Size(160,50)
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start,
             mainAxisSize: MainAxisSize.max,
        children: [
          Icon(widget.icon),
          SizedBox(width: 8 , height: 50,), 
          Builder(
              builder: (context) {
                final displayText =  widget.textController.isNotEmpty
                    ? widget.textController
                    : widget.buttonText;
                return Text(displayText);
              },
            )
          
        ],
      ),
      onPressed: () async { // popup data pick
        await showDialog(
        context: context,
        builder: (builder) => XenPopupCard(
        body:  widget.buttonAction,
          ),
        );
        setState(() {});
      },
    );
                                    
  }



}