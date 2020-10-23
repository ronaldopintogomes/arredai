import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Apoio extends StatefulWidget {
  @override
  _ApoioState createState() => _ApoioState();
}

class _ApoioState extends State<Apoio> {

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
          'Orgão de apoio contra o covid-19',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Missâo Covid',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),subtitle: Text(
                  'https://missaocovid.com.br',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              onTap: () => _link('https://missaocovid.com.br'),
            ),
            ListTile(
              title: Text(
                'SUSAM/FVS Relatório Covid-19',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),subtitle: Text(
                  'http://saude.am.gov.br/painel/corona/',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              onTap: () => _link('http://saude.am.gov.br/painel/corona/'),
            ),
            ListTile(
              title: Text(
                'SEMSA - Chat Online',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),subtitle: Text(
                  'http://apps.semsa.manaus.am.gov.br/chat/index.php/chat?locale=pt-br&group=1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              onTap: () => _link('http://apps.semsa.manaus.am.gov.br/chat/index.php/chat?locale=pt-br&group=1'),
            ), ListTile(
              title: Text(
                'Aplicativo "Coronavirus SUS"',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),subtitle: Text(
                  'https://play.google.com/store/apps/details?id=br.gov.datasus.guardioes&hl=pt_BR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              onTap: () => _link('https://play.google.com/store/apps/details?id=br.gov.datasus.guardioes&hl=pt_BR'),
            ), ListTile(
              title: Text(
                'Chat Online - Ministério da Saúde',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),subtitle: Text(
                  'http://saude.gov.br/coronavirus',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              onTap: () => _link('http://saude.gov.br/coronavirus'),
            ),
          ],
        ),
      ),
    );
  }
}