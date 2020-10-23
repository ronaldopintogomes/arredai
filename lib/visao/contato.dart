import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contato extends StatefulWidget {

  @override
  _ContatoState createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {

  _link(String url) async {
    if(await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Página não está acessivel!';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contato de apoio tratamento covid-19',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Disque Saúde',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    "136" ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                ),
                ),
                ListTile(
                  title: Text(
                    'Ministério da Saúde Responde!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),subtitle: Text(
                  "+55 61 9938-0031",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                  onTap: () => _link('https://wa.me/556199380031'),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
