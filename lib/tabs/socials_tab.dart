import 'package:castrin_notify/tiles/social_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// Tela de redes sociais:
class SocialsTab extends StatelessWidget {

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
  );  // Degradê


  @override
  Widget build(BuildContext context) {
    String youtubeUrl = "https://www.youtube.com/c/oCastrin";
    String twitchUrl = "https://www.twitch.tv/ocastrin";
    String instaUrl = "https://www.instagram.com/ocastrin/";
    String discordUrl = "https://discord.gg/2Y9bGHGZ";
    String twitterUrl = "https://twitter.com/ocastrin_";
    String tiktokUrl = "https://www.tiktok.com/@ocastrin?lang=pt-BR";

    return Stack(
      children: [
        _buildBodyBack(),
        FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance.collection('socials').document('socials').get(),
            builder: (_, snapshot){
              List<Map<String, dynamic>> links = [
                {'name': 'youtubeUrl', 'url': youtubeUrl,
                  'title': 'Youtube'},
                {'name': 'twitchUrl', 'url': twitchUrl,
                  'title': 'Twitch'},
                {'name': 'instaUrl', 'url': instaUrl,
                  'title': 'Instagram'},
                {'name': 'twitterUrl', 'url': twitterUrl,
                  'title': 'Twitter'},
                {'name': 'discordUrl', 'url': discordUrl,
                 'title': 'Discord'},
                {'name': 'tiktokUrl', 'url': tiktokUrl,
                  'title': 'TikTok'},
              ];

              if(snapshot.hasData){
                for(Map link in links){
                  link['url'] = snapshot.data.data[link['name']];
                }
              }
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  for(Map link in links)
                    SocialTile(
                      link['title'],
                      link['url'],
                      AssetImage('assets/images/${link['title']
                          .toString().toLowerCase()}.png')
                    ),
                ],
              );
            }
        )
      ],
    );
  }
}
