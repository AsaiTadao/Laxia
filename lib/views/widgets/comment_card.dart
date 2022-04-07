import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Comment_Card extends StatefulWidget {
  final String name, ename, avatar, comment, date;
  const Comment_Card({
    Key? key,
    required this.name,
    required this.ename,
    required this.avatar,
    required this.comment,
    required this.date,
  }) : super(key: key);

  @override
  State<Comment_Card> createState() => _Comment_CardState();
}

class _Comment_CardState extends State<Comment_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 32,
                width: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.avatar,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                widget.name,
                style: TextStyle(color: Helper.titleColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.ename + '  ' + widget.comment,
              style: TextStyle(color: Helper.titleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(fontSize: 12, color: Helper.darkGrey),
                ),
                InkWell(
                  child: Text(
                    '返信',
                    style: TextStyle(fontSize: 13, color: Helper.mainColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
