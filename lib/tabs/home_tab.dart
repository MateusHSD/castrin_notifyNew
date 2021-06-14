import 'dart:ui';
import 'package:castrin_notify/tiles/video_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Tela inicial
class HomeTab extends StatelessWidget {

  Widget _buildBodyBack() => Container( // Degradê
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 49, 49, 49),
              Color.fromARGB(255, 24, 24, 24)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          // Colocando a cor de fundo:
          _buildBodyBack(),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              // Card principal
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    SizedBox(height: 16.0,),
                    Text("Vídeo mais recente:", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500)),
                    // O vídeo:
                    SizedBox(height: 8.0,),
                    FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance.collection("homeNew").getDocuments(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          String url = snapshot.data.documents[0].data['1']['url'];
                          String thumb = snapshot.data.documents[0].data['1']['thumb'];
                          String title = snapshot.data.documents[0].data['1']['title'];
                          Timestamp timestamp = snapshot
                              .data.documents[0].data['1']['data'];
                          return VideoTile(url, thumb, title, timestamp);
                        }
                      },
                    ),
                  ],
                ) ,
              ),

              SizedBox(height: 16.0),

              // Categorias selecionadas:
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    // Texto:
                    Text("Talvez você também curta:", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)),
                    SizedBox(height: 8.0),
                    // Lista com vídeos:
                    FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance.collection("homeNew").getDocuments(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          int length = snapshot.data.documents[0]
                              .data['aux']['maxVideos'];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                              itemCount: length - 1,
                              itemBuilder: (_, index){
                                // Posição:
                                String pos = (index + 2).toString();
                                // Url e thumb:
                                if(snapshot.data.documents[0].data[pos] == null)
                                  return Container();
                                String url = snapshot.data.documents[0]
                                    .data[pos]['url'];
                                String thumb = snapshot.data.documents[0]
                                    .data[pos]['thumb'];
                                String title = snapshot.data.documents[0]
                                    .data[pos]['title'];
                                Timestamp timestamp = snapshot.data.documents[0]
                                    .data[pos]['data'];
                                if(url != null && thumb != null)
                                  return Column(
                                    children: [
                                      VideoTile(url, thumb, title, timestamp),
                                      SizedBox(height: 8)
                                    ],
                                  );
                                return Container();
                              }
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )
        ]
    );
  }
}
