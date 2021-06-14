import 'package:castrin_notify/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container( // Degradê
      color: Colors.black
    ); // Degradê

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 30.0, top: 30.0),                    // Distância das margens
            children: <Widget>[
              // Divider(), // Divisória cabeçalho/ícones

              DrawerTile(AssetImage("assets/images/youtube.png"), "Vídeos", pageController, 0),
              DrawerTile(AssetImage("assets/images/twitch.png"), "Live", pageController, 1),
              DrawerTile(Icons.whatshot, "Redes sociais", pageController, 2),
            ],
          )
        ],
      ),
    );
  }
}
