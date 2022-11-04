import 'dart:async';

import 'package:doctoragileapp/upcomingappntmnt.dart';
import 'package:doctoragileapp/webrtc_videoCall/signaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class TestVideo extends StatefulWidget {
  @override
  RTCVideoRenderer localvideo;
  RTCVideoRenderer remotevideo;
  String videotoken;
  TestVideo({this.localvideo, this.remotevideo, this.videotoken});
  State<TestVideo> createState() => _TestVideoState();
}

class _TestVideoState extends State<TestVideo> {
  @override
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String roomId;
  TextEditingController textEditingController = TextEditingController(text: '');
  bool recording = false;
  int _time = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(new Duration(seconds: 1), (time) {});
  }

  int vt = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: IconButton(
              onPressed: () {
                signaling.hangUp(_localRenderer);
                //  Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Upcomingappointment()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.call_end_outlined,
                color: Colors.white,
              )),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // widget.remotevideo.delegate.videoHeight == 0
                  //     ? Expanded(
                  //         flex: 7,
                  //         child: RTCVideoView(widget.localvideo, mirror: true))
                  //     : Expanded(
                  //         child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.stretch,
                  //         children: [
                  //           Expanded(
                  //               flex: 5,
                  //               child:
                  //                   RTCVideoView(widget.localvideo, mirror: true)),
                  //           Expanded(
                  //               flex: 5, child: RTCVideoView(widget.remotevideo)),
                  //         ],
                  //       ))

                  vt != 1
                      ? Stack(
                          children: [
                            AspectRatio(
                                aspectRatio: 1 / 1.8,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: RTCVideoView(widget.localvideo,
                                            mirror: true)),
                                  ],
                                )),
                            Positioned(
                                bottom: 10,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      vt = 1;
                                    });
                                    print(vt);
                                  },
                                  child: Container(
                                      width: 150,
                                      height: 200,
                                      // color: Colors.red,
                                      child: AspectRatio(
                                          aspectRatio: 2,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: RTCVideoView(
                                                      widget.remotevideo)),
                                            ],
                                          ))),
                                )),
                          ],
                        )
                      : Stack(
                          children: [
                            AspectRatio(
                                aspectRatio: 1 / 1.8,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: RTCVideoView(widget.remotevideo,
                                            mirror: true)),
                                  ],
                                )),
                            Positioned(
                                bottom: 10,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      vt = 0;
                                    });
                                    print(vt);
                                  },
                                  child: Container(
                                      width: 150,
                                      height: 200,
                                      // color: Colors.red,
                                      child: AspectRatio(
                                          aspectRatio: 2,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: RTCVideoView(
                                                      widget.localvideo)),
                                            ],
                                          ))),
                                )),
                          ],
                        )
                ],
              ),
            ),
          ],
        ));
  }
}
