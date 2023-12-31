import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../helper/my_date_util.dart';
import '../main.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final Message message;
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return APIs.authuser.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  // sender or another user messages
  Widget _blueMessage() {
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      print('message read update from ');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffC5D1E7FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              border: Border.all(color: Color(0xffB9D8E7FF)),
            ),
            padding: EdgeInsets.all( widget.message.type == Type.image ? mq.width * .03 : mq.width * .04),
            margin: EdgeInsets.symmetric(
                vertical: mq.height * .02, horizontal: mq.width * .04),
            child: widget.message.type == Type.text
                ?  // show text
                   Text(
                    widget.message.msg,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :    // show message
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // adjust the radius for rounded corners
              child: FadeInImage.assetNetwork(
                image: widget.message.msg, // replace with your image URL
                // width: 200,
                // height: 250,
                // fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image,
                    weight: 250,); // display an error icon when the image fails to load
                },
                placeholder: 'images/logo.png',
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: TextStyle(
              fontSize: 13,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }

  // our  user messages
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: mq.width * 0.04,
            ),
            if (widget.message.read.isNotEmpty)
              Icon(
                Icons.done_all_outlined,
                color: Colors.blue,
                size: 20,
              ),
            SizedBox(
              width: 1,
            ),
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: TextStyle(
                fontSize: 13,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              border: Border.all(color: Color(0xffB9D8E7FF)),
            ),
            padding: EdgeInsets.all( widget.message.type == Type.image ? mq.width * .03 : mq.width * .04),
            margin: EdgeInsets.symmetric(
                vertical: mq.height * .02, horizontal: mq.width * .04),
            child: widget.message.type == Type.text
                ?  // show text
            Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            )
                :    // show message
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // adjust the radius for rounded corners
              child: FadeInImage.assetNetwork(
                image: widget.message.msg, // replace with your image URL
                // width: 200,
                // height: 250,
                // fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image,
                    weight: 250,); // display an error icon when the image fails to load
                },
                placeholder: 'images/logo.png',
              ),
            ),

          ),
        ),
      ],
    );
  }
}
