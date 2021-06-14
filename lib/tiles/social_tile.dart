import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialTile extends StatelessWidget {

  final String title;
  final AssetImage icon;
  final String url;

  SocialTile(this.title, this.url, this.icon);

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: 60),
            Container(
              width: 60,
              child: Image(
                  fit: BoxFit.fitWidth,
                  image: icon
              ),
            ),
            Text(title, style: TextStyle(
                fontSize: 22
              ),
            ),
            ElevatedButton(
              child: Text("Seguir"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty
                    .resolveWith((states) => Colors.black54),
              ),
              onPressed: () {
                launch(url);
              },
            )
          ],
        ),
      ),
    );
  }
}
