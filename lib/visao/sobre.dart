import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sobre',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            Text('Membros',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 5, color: Colors.white,),
            Text('Ana Ruth Miranda Magalhães',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Clodoaldo José Bruno Batalha Júnior',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Daniel Ferreira dos Santos Filho',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Emily Louise Oliveira Soares',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Ericton Felicidade de Brito',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Felipe Aristides da Silva Ferreira',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Ghislaine Raposo Bacelar',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Gilmara Araújo Teles',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Hiparco Leitão Vieira',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Jéssica Oliveira Soares',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('João Carlos Silva de Oliveira',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Matheus Souza da Silva',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Michel Victor Lomas Câmara',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Rikelme da Silva Caldas',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Ronaldo Pinto Gomes',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Silvio Dionizio de Souza Diogo Mestrinho',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text('Wanderlan Carvalho de Albuquerque',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Divider(height: 10, color: Colors.grey,),
            Text('Projeto de extensão Arredaí',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('lib/visao/imagem/logouninorteser.jpg'),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.school),
                Text('Rua 10 de julho, 873 - Centro-Manaus-AM'),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.phone),
                Text('3212-5000'),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.language),
                GestureDetector(
                  child: Text('www.uninorte.com.br'),
                  onTap: () => _link('http://www.uninorte.com.br'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   _link(String url) async {
    if(await canLaunch(url)) {
       launch(url);
    } else {
      throw 'Página não está acessivel!';
    }
  }
}