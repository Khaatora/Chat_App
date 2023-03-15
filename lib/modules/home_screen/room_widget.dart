import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/modules/chat_screen/chat_view.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  ChatRoomModel room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          children: [
            Image.asset("assets/images/${room.categoryId?.toLowerCase()}.png"),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(room.title!),
          ],
        ),
      ),
    );
  }
}
