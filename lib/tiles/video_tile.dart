import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTile extends StatelessWidget {

  final String url;
  final String thumb;
  final String title;
  final Timestamp timestamp;

  VideoTile(this.url, this.thumb, this.title, this.timestamp);

  @override
  Widget build(BuildContext context) {
    bool semThumb = (thumb == null || thumb == '');

    if(semThumb)
      return Container();

    return Column(
      children: [
        // Card do vídeo:
        GestureDetector(
          onTap: (){
            launch(url);
          },
          // Card do vídeo:
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Card(
                    margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                      child: Image(image: NetworkImage(thumb))
                  ),
                  SizedBox(
                    width: 60,
                    child: Opacity(opacity: 0.6,
                        child: Image(image: AssetImage("assets/icon/play.png"))
                    ),
                  )
                ],
              ),

              // Barra com o titulo:
              if(title != '' && title != null)
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 3),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.4,
                        child: Container(
                          height: 40,
                          color: Colors.black,
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                              '$title',
                              style: TextStyle(color: Colors.white)
                          ),
                        ),
                      ),
                    ],
                  )
                )
            ],
          ),
        ),

        if(timestamp != null)
          Text(
            '${timestamp.toDate().day}/${timestamp.toDate().month}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white60,
              fontFamily: 'Roboto'
            ),
          )
      ],
    );
  }
}
