import 'package:castrin_notify/screens/notifications_screen.dart';
import 'package:castrin_notify/tabs/home_tab.dart';
import 'package:castrin_notify/tabs/live_tab.dart';
import 'package:castrin_notify/tabs/socials_tab.dart';
import 'package:castrin_notify/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

// Classe Stateful pra poder notificar:
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

// Estado da classe:
class HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController();

  // Barra com a cara do castrin
  _buildAvatarAppBar(){
    return CircleAvatar(
      backgroundColor: Colors.transparent,
        radius: 20,
        backgroundImage: AssetImage("assets/icon/icon.png")
    );
  }

  _buildActionAppBar(){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Icon(Icons.notifications),
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NotificationsScreen())
        );
      },
    );
  }

  @override

  // Tela inicial:
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(title: _buildAvatarAppBar(), centerTitle: true, backgroundColor: Colors.black,
          actions: [_buildActionAppBar()],),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(title: _buildAvatarAppBar(), centerTitle: true, backgroundColor: Colors.black,
            actions: [_buildActionAppBar()],),
          drawer: CustomDrawer(_pageController),
          body: LiveTab(),
        ),
        Scaffold(
          appBar: AppBar(title: _buildAvatarAppBar(), centerTitle: true, backgroundColor: Colors.black,
            actions: [_buildActionAppBar()],),
          drawer: CustomDrawer(_pageController),
          body: SocialsTab(),
        ),

      ],
    );
  }
}

