import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class InputTextWidget extends StatefulWidget {
  TextEditingController controller;
  String labelName = '';
  String placeHolder = '';
  String maxLegnth = '';
  final int? maxlines;

  InputTextWidget(
      {
      required this.controller,
      required this.labelName,
      required this.placeHolder,
      required this.maxLegnth,
      this.maxlines = 1});
  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  late String _enteredText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
              ),
              if (widget.maxLegnth != '')
                Text(
                  "${_enteredText.length}/${widget.maxLegnth}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    
                    color: Helper.maintxtColor,
                  ),
                )
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              _enteredText = value;
            });
          },
          validator: (v) {
            if (v!.isEmpty) return '入力してください';
            // final regex = RegExp('^[1-9]+[0-9]*');
            // if (!regex.hasMatch(v)) return 'Enter a valid point value';
            return null;
          },
          maxLength: int.parse(widget.maxLegnth),
          maxLines: widget.maxlines,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: Helper.whiteColor.withOpacity(0.2),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            hintText: widget.placeHolder,
            counterText: "",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                
                color: Helper.txtColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  // color: Colors.black,
                    color: Helper.authHintColor,
                    width: 1.0)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  // color: Colors.black,
                    color: Helper.authHintColor,
                    width: 1.0)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                  // color: Colors.black,
                    color: Helper.authHintColor,
                    width: 1.0)),
          ),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              
              color: Color.fromARGB(255, 18, 18, 18)
          ),
        ),
      ],
    );
  }
}
