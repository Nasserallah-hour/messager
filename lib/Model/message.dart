import 'package:flutter/foundation.dart';

class Message {
  String message;
  String sentByme;
  String time;
  String room;

  Message({required this.message, required this.sentByme,required this.time,required this.room});

  // ignore: empty_constructor_bodies
  factory Message.fromJson(Map<String,dynamic> json){
    return Message(message: json["Message"], sentByme: json["SentByMe"],time: json["time"],room: json["room"]);
  }
}