import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';

class Dropdownbutton extends StatefulWidget {
  final List<String> items;
  final double horizontal;
  final String hintText;
  final double? width;
  final void Function(String val) onpress;
  const Dropdownbutton(
      {Key? key,
      required this.items,
      required this.horizontal,
      required this.hintText,
      this.width = 74, 
      required this.onpress})
      : super(key: key);

  @override
  State<Dropdownbutton> createState() => _DropdownbuttonState();
}

class _DropdownbuttonState extends State<Dropdownbutton> {
  String? selectedValue;
  String? mid;
  bool drop = true;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: widget.width!,
        buttonPadding:
            EdgeInsets.symmetric(horizontal: widget.horizontal, vertical: 0),
        enableFeedback: true,
        onTap: () {
          setState(() {
            drop = !drop;
          });
        },
        onMenuClose: () {
          setState(() {
            drop = !drop;
          });
        },
        iconSize: 20,
        hint: drop
            ? Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  widget.hintText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Helper.unSelectSmallTabColor,
                  ),
                ),
              )
            : Text(
                widget.hintText,
                style:
                    TextStyle(fontSize: 12, color: Helper.selectSmallTabColor),
              ),
        icon: drop
            ? SvgPicture.asset(
              "assets/icons/arrowdown.svg",
              fit: BoxFit.cover,
              width: 7.2,
              height: 4.7,
              color: Helper.maintxtColor,
            )
            : SvgPicture.asset(
                "assets/icons/arrowup.svg",
                fit: BoxFit.cover,
                width: 7.2,
                height: 4.7,
                color: Helper.mainColor,
              ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value:  widget.items.indexOf(item).toString(),
                  child: selectedValue == widget.items.indexOf(item).toString()
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  color: Helper.mainColor,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                  child: Align( 
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.check,
                                        color:
                                            Helper.mainColor
                                      )))
                            ],
                          ),
                        )
                      : Text(
                          item,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 14,
                          ),
                        ),
                ))
            .toList(),
        isExpanded: true,
        value: mid,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
            widget.onpress(value);
          });
        },
        buttonHeight: 36,
        itemHeight: 48,
        itemPadding: EdgeInsets.fromLTRB(16, 15, 2, 12),
        dropdownWidth: MediaQuery.of(context).size.width,
        dropdownDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(1000, 1000),
                color: Colors.black.withOpacity(.7),
                spreadRadius: 1000)
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Helper.whiteColor,
        ),
      ),
    );
  }
}
