import 'package:chat_own/models/message.dart';
import 'package:chat_own/providers/my_provider.dart';
import 'package:chat_own/shared/components/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageBox extends StatelessWidget {
  final MessageModel message;
  late int ts;

  MessageBox({required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.userModel!.id == message.senderId
        ? SenderMessage(message: message)
        : ReceiverMessage(message: message);
  }
}

class SenderMessage extends StatelessWidget {
  final MessageModel message;

  SenderMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(convertMilliSecondSinceEpochToDateTime().substring(12),
            style: const TextStyle(color: Colors.black54)),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 2,
                vertical: SizeConfig.blockSizeVertical),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 2,
                vertical: SizeConfig.blockSizeVertical),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(
              message.content,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  String convertMilliSecondSinceEpochToDateTime() {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
  }
}

class ReceiverMessage extends StatelessWidget {
  final MessageModel message;

  ReceiverMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 2,
          vertical: SizeConfig.blockSizeVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 4,
                bottom: SizeConfig.blockSizeVertical),
            child: Text(
              message.senderName,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 5,
                      vertical: SizeConfig.blockSizeVertical),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.black38),
                  )),
              Transform.translate(
                offset: Offset(0, SizeConfig.blockSizeVertical),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 4),
                  child: Text(
                      convertMilliSecondSinceEpochToDateTime().substring(12),
                      style: const TextStyle(color: Colors.black54)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String convertMilliSecondSinceEpochToDateTime() {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
  }
}
