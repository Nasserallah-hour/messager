
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:messager/Components/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:messager/Model/message.dart';
import 'package:messager/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class messagescreen extends StatefulWidget {
  var room;

   messagescreen({ Key? key ,required this.room}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _messagescreenState createState() => _messagescreenState(room);
}

class _messagescreenState extends State<messagescreen> {
   final String room;
    late IO.Socket socket;
   TextEditingController msgcontroll = TextEditingController();
   ChatController _chatController=ChatController();

  _messagescreenState( this.room);
  @override
  void initState() {
 socket = io('http://localhost:3000/', 
    OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection // optional
      .build()
  );

socket.connect();
SetSocketReadData();
sendJoinRequest(room);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return  Scaffold( 
 
      body:
      Column(
        children: [
          Expanded(flex:9, child: Obx
          (()=>ListView.builder(
            itemCount: _chatController.chatMessages.length,
            itemBuilder:  (context,index) {
              var currentItem=_chatController.chatMessages[index];
            return  MessageItem(sentByMe: currentItem.sentByme == socket.id,message: currentItem.message, time:currentItem.time,);
          }))),
          Expanded(
            child:
             Container(padding: const EdgeInsets.all(10),
               child:TextField(controller: msgcontroll,
               decoration: InputDecoration(
                 enabledBorder: const UnderlineInputBorder(
                   borderSide: BorderSide(color: KTintcolor,width: 2),
                   
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: const BorderSide(color: KTintcolor,width: 2),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 suffixIcon: IconButton(onPressed:(){ 
                   send_Message(msgcontroll.text);
                   msgcontroll.clear();

                 },  icon: const Icon(Icons.send))
               ),)))

        ],
      )
    );
  }
      void send_Message(String text) {
      DateTime now = DateTime.now();
String formattedDate = DateFormat('hh:mm').format(now);
    var messagedata={
      "Message":text,
      "room":room,
      "SentByMe":socket.id,
      "time": formattedDate,// 8:18pm
    };
        if (socket.connected) {
          socket.emit("message",messagedata);
          //  _chatController.chatMessages.add(Message.fromJson(messagedata));
        }
        
        
  }

  void sendJoinRequest(room){
     socket.emit("requestJoin",room);
  }

  // ignore: non_constant_identifier_names
  void SetSocketReadData() {
    socket.on("message-receive",(data){
      _chatController.chatMessages.add(Message.fromJson(data));
    });
  }
}


  class MessageItem extends StatelessWidget {
  const MessageItem({ Key? key,required this.sentByMe, required this.message, required this.time }) : super(key: key);
  final bool sentByMe;
  final String message;
   final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
       
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
 
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: sentByMe? KTintcolor:KSecondarycolor,),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           Text(message,style: TextStyle(fontSize: 18,color: sentByMe? Colors.white:Colors.grey),),
           SizedBox(width: 10,),
           Text(time,style: TextStyle(fontSize: 10,color: (sentByMe? Colors.white:Colors.grey).withOpacity(0.7)),),
        ],)
      ),
    );
  }
}