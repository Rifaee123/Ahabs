// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:ahbas/controller/getx/audio_controller.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';


class VoiceChat extends StatefulWidget {
  
  const VoiceChat({
    Key? key,
    
  }) : super(key: key);

  @override
  _VoiceChatState createState() => _VoiceChatState();
}

class _VoiceChatState extends State<VoiceChat> {
  TextEditingController messageController = TextEditingController();


  bool temp = false;
  bool audio = false;
  int _limit = 20;
  int _limitIncrement = 20;


  
  final ScrollController _scrollController = ScrollController();
  String groupChatId = "";
  bool isShowSticker = false;
  final FocusNode focusNode = FocusNode();
  String currentUserId = "";

  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  String audioURL = "";
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      audioController.isRecording.value = false;
      audioController.isSending.value = true;
     
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }



  late String recordFilePath;

 

  void onSendMessage(String content, int type, {String? duration = ""}) {
    if (content.trim().isNotEmpty) {
      messageController.clear();
 
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.addListener(onFocusChange);
    _scrollController.addListener(_scrollListener);
    
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange ) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: <Widget>[
          Column(
            children: [
              buildListMessage(),
              Obx(
                () => audioController.isSending.value
                    ? Text(
                        "Uploading Audio...",
                        style: TextStyle(color: Colors.black),
                      )
                    : isLoading
                        ? Text(
                            "Uploading Image...",
                            style: TextStyle(color: Colors.black),
                          )
                        : buildInput(),
              )
            ],
          ),
          buildLoading()
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: audioController.isSending.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.shrink(),
    );
  }

  _incomingMSG(String a) {
    return Align(
      alignment: (Alignment.topLeft),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            ),
        padding: const EdgeInsets.fromLTRB(18, 9, 18, 9),
        child: Text(
          a,
          style: TextStyle(fontSize: 12, color: Color(0xff8A8A8A)),
        ),
      ),
    );
  }

  File? imageFile;
  bool isLoading = false;
  String imageUrl = "";
  Future getImage() async {
    
   
    
  }

 
  Widget buildInput() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
           
            borderRadius: BorderRadius.all(Radius.circular(10))),
        //height: 50,
        child: TextField(
          onSubmitted: (value) {
            onSendMessage(messageController.text, Duration.hoursPerDay);
          },
          controller: messageController,
          focusNode: focusNode,
          decoration: InputDecoration(
              prefixIcon: Container(
                width: 80,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Icon(Icons.photo, ),
                      onTap: () {
                        getImage();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Icon(Icons.mic, ),
                      onLongPress: () async {
                        var audioPlayer = AudioPlayer();
                        await audioPlayer.play(AssetSource("Notification.mp3"));
                        audioPlayer.onPlayerComplete.listen((a) {
                          audioController.start.value = DateTime.now();
                          startRecord();
                          audioController.isRecording.value = true;
                        });
                      },
                      onLongPressEnd: (details) {
                        stopRecord();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  child: Icon(Icons.send, ),
                  onTap: () =>
                      onSendMessage(messageController.text, Duration.hoursPerDay),
                ),
              ),
              hintText: audioController.isRecording.value
                  ? "Recording audio..."
                  : "Your message...",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              hintStyle: TextStyle(color: Color(0xff8A8A8A), fontSize: 15),
              border: InputBorder.none),
        ),
      ),
    );
  }

  _outgoingMSG(String a) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
       
        ),
        padding: const EdgeInsets.fromLTRB(18, 9, 18, 9),
        child: Text(
          a,
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder(
              stream: null,
              builder: (BuildContext context,
                  AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                
                  // if (listMessage.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                      itemBuilder: (context, index) =>
                          buildItem(index),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: _scrollController,
                    );
                //   } else {
                //     return Center(
                //         child: Text(
                //       "No message here yet...",
                //       style: TextStyle(color: Colors.black),
                //     ));
                //   }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                 }
               },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _audio({
    required String message,
    required bool isCurrentUser,
    required int index,
    required String time,
    required String duration,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              audioController.onPressedPlayButton(index, message);
              // changeProg(duration: duration);
            },
            onSecondaryTap: () {
              audioPlayer.stop();
              //   audioController.completedPercentage.value = 0.0;
            },
            child: Obx(
              () => (audioController.isRecordPlaying &&
                      audioController.currentId == index)
                  ? Icon(
                      Icons.cancel,
               
                    )
                  : Icon(
                      Icons.play_arrow,
       
                    ),
            ),
          ),
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                    LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                     
                      value: (audioController.isRecordPlaying &&
                              audioController.currentId == index)
                          ? audioController.completedPercentage.value
                          : audioController.totalDuration.value.toDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            duration,
            style: TextStyle(
                fontSize: 12,),
          ),
        ],
      ),
    );
  }
 final isTrue=true;
  Widget buildItem(int index) {
   

      if (isTrue) {
        // Right (my message)
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
              
                _audio(
                    message: 'messageChat.content',
                    isCurrentUser:true,
                    index: index,
                    time: 'messageChat.timestamp.toString()',
                    duration: 'messageChat.duration.toString()')
            ],
          ),
        );
      } else {
        // Left (peer message)
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Container(),
                        )
                      : Container(width: 35),
               
             
                   _audio(
                    message: 'messageChat.content',
                    isCurrentUser:true,
                    index: index,
                    time: 'messageChat.timestamp.toString()',
                    duration: 'messageChat.duration.toString()')
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                      child: Text(
                       '',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        );
      }
    
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 ) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}