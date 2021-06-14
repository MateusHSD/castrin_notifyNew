import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final dynamic icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(    // Efeito visual no ícone
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();    // Fechar a aba
          controller.jumpToPage(page);    // Pular para a página
        },

        child: Container( // Especificar a altura dos ícones
          height: 60.0,   // Altura da coluna
          child: Row(     // Ícones e textos:
            children: <Widget>[
              icon is AssetImage ? Image(image: icon, height: 26.0,
                  color: controller.page.round() == page ?
              Theme.of(context).primaryColor : Colors.white70) :
              Icon(icon, size: 26.0,
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.white70),

              SizedBox(width: 20.0),    // Distância entre ícone e texto
              Text(text, style: TextStyle(fontSize: 26.0,
                  fontFamily: 'Metropolis',
                  color: controller.page.round() == page ?
              Theme.of(context).primaryColor : Colors.white))
            ],
          )
        )
      )
    );
  }
}
