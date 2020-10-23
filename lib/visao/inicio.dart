import 'dart:io';
import 'package:arredai/visao/apoio.dart';
import 'package:arredai/visao/contato.dart';
import 'package:arredai/visao/sobre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:vibrate/vibrate.dart';

import 'listtilecustomizado.dart';

class Inicio extends StatefulWidget {
  const Inicio({
    Key key,
  }) : super(key: key);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animationGradient;
  FlutterBluetoothSerial _bluetoothInstance = FlutterBluetoothSerial.instance;
  bool _bluetoothAtivo = false;
  List<BluetoothDevice> _listDevice = List<BluetoothDevice>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000), value: 0.1);
    _animationGradient =
        Tween(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: false);
    _bluetooth();
  }

  @override
  void dispose() {
    _bluetoothInstance.cancelDiscovery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arredaí',
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
        color: Colors.deepOrange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 50)),
              Text('DISPOSITIVOS PROXIMOS: ${_listDevice.length.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,  
                ),
              ),
              Text(''),
              Text(''),
              _ativaRadar(context),
              Text(''),
              Expanded(
                child: _listaDispositivos(context),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Image.asset('lib/visao/imagem/logouninorte.png'),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: RadialGradient(
                colors: <Color>[
                  Colors.orange[200],
                  Colors.deepOrange,
                ],
              ),
            ),
          ),
          ListTileCustomizado(Icons.phone_in_talk, 'Apoio de Tratamento do covid-19', () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contato())
          )}),
          ListTileCustomizado(Icons.location_city, 'Orgão de apoio contra o covid-19', () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Apoio())
          )}),
          ListTileCustomizado(Icons.error, 'Sobre', () => {Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Sobre())
          )}),
          ListTileCustomizado(Icons.close, 'Sair', () => {exit(0)}),
        ]),
      ),
    );
  } 

  Widget _listaDispositivos(BuildContext context) {
    if(_listDevice.isNotEmpty) {
      return ListView.builder(
        itemCount: _listDevice.length,
        itemBuilder: (context, index) {
          return Center(
            child: Text('${_listDevice[index].name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            ),
          );
        }
      );
    } else {
      return Text('');
    }
  }

  Widget _ativaRadar(BuildContext context) {
    if(_bluetoothAtivo) {
      return _radarAnimado(context);
    } else {
      return _radarNaoAnimado(context);
    }
  }

  Widget _radarAnimado(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height) / 2,
      child: Image.asset('lib/visao/imagem/logouninorteradar.png'),  
      decoration: BoxDecoration(
        gradient: RadialGradient(
          stops: [
            _animationGradient.value - 0.5,
            _animationGradient.value,
            _animationGradient.value + 0.1,
            _animationGradient.value,
          ],
          colors: [
            Colors.blue[800],
            Colors.blue[900],
            Colors.orange[900],
            Colors.deepOrange,
          ],
        ),
      ),
    );
  }

  Widget _radarNaoAnimado(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width) / 1,
      height: (MediaQuery.of(context).size.height) / 2,
      child: Image.asset('lib/visao/imagem/logouninorteradar.png'),
    );
  }

  _bluetooth() {
    _bluetoothInstance.state.then((state) {
      if(state == BluetoothState.STATE_OFF) {
        _bluetoothInstance.requestEnable().then((value) {
          if(value) {
            setState(() {
              _bluetoothAtivo = true;
            });
            _bluetooth();
          } else {
            setState(() {
              _bluetoothAtivo = false;
            });
            _bluetooth();
          }
        });
      } else if(state == BluetoothState.STATE_ON) {
        setState(() {
          _bluetoothAtivo = true;
        });
        _bluetoothInstance.isDiscoverable.then((value) {
          if(value) {
            var stream = _bluetoothInstance.startDiscovery().listen((result) {
              if(result.device != null) {
                if(result.rssi >= -58) {
                  setState(() {
                    if(!_listDevice.contains(result.device)) {
                      _listDevice.add(result.device);
                    }
                  });
                  final Iterable<Duration> pauses = [
                    const Duration(milliseconds: 1000),
                    const Duration(milliseconds: 1000),
                    const Duration(milliseconds: 1000),
                  ];
                  Vibrate.vibrateWithPauses(pauses);
                }
              } 
            });
            stream.onDone(() {
              setState(() {
                _listDevice.clear();
              });
              _bluetooth();
            });    
          } else {
            _bluetoothInstance.requestDiscoverable(1800).then((value) {
              _bluetooth();
            });
          }
        });
      } else if(state == BluetoothState.STATE_TURNING_OFF) {
        setState(() {
          _bluetoothAtivo = false;
          _listDevice.clear();
        });
        _bluetoothInstance.cancelDiscovery();
        _bluetooth();
      }
    });
  }
} 