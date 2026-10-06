// ignore_for_file: avoid_print

import 'package:deliveryapp/model/conversation_model.dart';
import 'package:deliveryapp/view/widgets/owen_message_card_widget.dart';
import 'package:deliveryapp/view/widgets/replay_message_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../controller/chat_controller.dart';
import '../../model/message_model.dart';
import '../../model/messages_model.dart';
import '../../utils/const_string.dart';
import '../widgets/chat_app_bar_widget.dart';

class ChatConversationScreen extends StatefulWidget {
  final String sourceId;
  final String targetId;
  final String userName;
  const ChatConversationScreen(
      {super.key,
      required this.sourceId,
      required this.targetId,
      required this.userName});
  @override
  ChatConversationScreenState createState() => ChatConversationScreenState();
}

class ChatConversationScreenState extends State<ChatConversationScreen> {
  ChatController chatController = Get.put(ChatController());
  List<MessagesModel> messages = [];
  TextEditingController textChate = TextEditingController();
  ScrollController scrollController = ScrollController();
  IO.Socket socket = IO.io(ServerUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;

  @override
  void initState() {
    super.initState();
    // connect();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    textChate.dispose();
    super.dispose();
  }

  void connect() {
    try {
      socket.connect();
      socket.emit('signin', widget.sourceId);
      socket.onConnect((data) {
        print('connected');
        socket.on('message', (msg) {
          print(msg);
          setMessage("destination", msg["message"]);
        });
      });
      print(socket.connected);
    } catch (e) {
      print(e);
    }
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessagesModel messagesModel = MessagesModel(
      type: type,
      msg: message,
      time: DateTime.now().toString().substring(10, 16),
    );
    print(message);

    setState(() {
      messages.add(messagesModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ConversationModel> conversation = chatController.conversation;
   // print(conversation.first.messages);
    var messagess = conversation.first.messages;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Image.asset(
        'assets/images/backimagechat.jpg',
        height: screenHeight,
        width: screenWidth,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: ChatAppBar(
            title: widget.userName,
          ),
          body: Container(
            height: screenHeight,
            width: screenWidth,
            child: Stack(children: [
              SizedBox(
                height: screenHeight - 170,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messagess?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (messagess?[index].senderId == widget.sourceId) {
                      return OwnMessageCard(
                        msg: messagess?[index].message ?? "",
                        time: messagess?[index].createdAt ?? "",
                      );
                    } else {
                      return ReplayMessageCard(
                        msg: messagess?[index].message ?? "",
                        time: messagess?[index].createdAt ?? "",
                      );
                    }
                  },
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  showCursor: true,
                                  controller: textChate,
                                  focusNode: focusNode,
                                  textInputAction: TextInputAction.next,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        show
                                            ? Icons.keyboard
                                            : Icons.emoji_emotions_outlined,
                                      ),
                                      onPressed: () {
                                        if (!show) {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                        }
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              right: 2,
                              left: 2,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xFF128C7E),
                              child: IconButton(
                                icon: Icon(
                                  sendButton ? Icons.send : null,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (sendButton) {
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    sendMessage(textChate.text, widget.sourceId,
                                        widget.targetId);
                                    print(conversation.first.id);
                                    MessageModel messagesModel = MessageModel(
                                        message: textChate.text,
                                        senderId: widget.sourceId,
                                        createdAt: DateTime.now()
                                            .toString()
                                            .substring(10, 16),
                                        conversation : conversation.first.id);
                                    await chatController
                                        .sendMEssages(messagesModel);
                                    await chatController.getConversation(
                                        widget.sourceId, widget.targetId);
                                    textChate.clear();
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ]),
                        //  if (show) Expanded(child: emojiSelect()) else Container(),
                      ])),
            ]),
          ))
    ]);
  }

  /* Widget emojiSelect() {
    return EmojiPicker(
      textEditingController: textChate,
      onEmojiSelected: (category, emoji) {
        textChate.text = textChate.text + emoji.emoji;
      },
      scrollController: scrollController,
      config: Config(
        checkPlatformCompatibility: true,
        buttonMode: ButtonMode.MATERIAL,
        // showRecentsTab: true,
        recentsLimit: 28,
        tabIndicatorAnimDuration: kTabScrollDuration,
      ),
    );
  }*/
}
/*
)*/

