import 'package:castrin_notify/tiles/video_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveTab extends StatelessWidget {
  Widget _buildBodyBack() => Container(
        // Degradê
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 49, 49, 49),
          Color.fromARGB(255, 24, 24, 24)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack(),
        FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection('live').getDocuments(),
            builder: (context, snapshot) {
              // Se não carregar, mostrar a tela de live::
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              // Se carregar, ver se ta tendo live ou não:
              else {
                bool status = snapshot.data.documents[0].data['status'];
                String _url = snapshot.data.documents[0].data['url'];
                String _thumb = snapshot.data.documents[0].data['thumb'];
                return Container(
                    child: status == false
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              Text("Nem to em live!",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white)),
                              SizedBox(height: 32),
                              Text(
                                  "Mas já me segue lá e ativa as notificações"
                                      " aí pra ver quando eu ficar on!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 16),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty
                                        .resolveWith((states) =>
                                    Colors.white),
                                  ),
                                  child: Text("Seguir",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.black,
                                      )),
                                  onPressed: () {
                                    launch(_url);
                                  })
                            ],
                          ),
                        )
                        : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              // Texto to em live:
                              Text("To em live!",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 16),

                              // Card da live
                              VideoTile(_url, _thumb, '', null),
                              SizedBox(height: 16),

                              // Botão de follow
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty
                                            .resolveWith((states) =>
                                                Colors.white),
                                  ),
                                  child: Text("Seguir",
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black54
                                              .withAlpha(255))),
                                  onPressed: () {
                                    launch(_url);
                                  })
                            ],
                          ),
                        ));
              }
            })
      ],
    );
  }
}
