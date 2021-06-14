import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsScreen extends StatelessWidget {

  // Degradê:
  Widget _buildBodyBack() =>
      Container(
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
    return Scaffold(
      appBar: AppBar(
          title: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage("assets/icon/icon.png")
      ), centerTitle: true, backgroundColor: Colors.black),

      body: Stack(
        children: [
          _buildBodyBack(),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              // Título da aba:
              SizedBox(height: 16.0),
              Text("Você pode ter perdido:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  )),
              SizedBox(height: 8.0),



              // Cards de notificação:
              FutureBuilder<QuerySnapshot>(
                  future: Firestore.instance.collection("notification").orderBy('day').getDocuments(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else{
                      List<DocumentSnapshot> docs = snapshot.data.documents;
                      int length = docs.length;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: length >= 5
                              ? 5
                              : length,
                          itemBuilder: (_, index){
                            // Posição:
                            int pos = length - index - 1;
                            return Column(
                              children: [
                                _buildNotificationCard(
                                    docs[pos].data['url'],
                                    docs[pos].data['thumb'],
                                    docs[pos].data['type'],
                                    docs[pos].data['day']
                                ),
                                SizedBox(height: 8,)
                              ],
                            );
                          }
                      );
                    }
                  }
              )
            ],
          )
        ],
      ),
    );
  }


  // Card de notificação:
  Widget _buildNotificationCard(String url, String thumb, dynamic type, dynamic day){
    DateTime date = day.toDate();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Imagem da thumb:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: thumb != null
                      ? NetworkImage(thumb)
                      : AssetImage("assets/icon/icon.png"),
                ),
                SizedBox(height: 4),
                // Hora:
                Text('${date.day}/${date.month} - ${date.hour}:${date.minute}',
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withAlpha(125)
                    )),
              ],
            ),

            // Texto:
            Text(type == 'live'
                ? "Estou em live\nna Twitch!"
                : type == 'video'
                ? "Vídeo novo\nno canal!"
                : "Tem novidade!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19)
            ),

            SizedBox(
              width: 45,
              child: ElevatedButton(
                child: Text("Ir"),
                onPressed: () {
                  launch(url);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty
                      .resolveWith((states) => Colors.black54),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}