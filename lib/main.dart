import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance";

void main() async {
  print(await pegarDados());
  runApp(
    MaterialApp(
      //home: Container(),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? ibovespaNome;
  String? ibovespaLocal;
  String? ibovespaPontos;
  String? ibovespaVariacao;

  String? nasdaqNome;
  String? nasdaqLocal;
  String? nasdaqPontos;
  String? nasdaqVariacao;

  String? nikkeiNome;
  String? nikkeiLocal;
  String? nikkeiPontos;
  String? nikkeiVariacao;

  String? cacNome;
  String? cacLocal;
  String? cacPontos;
  String? cacVariacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bolsa de Valores no Mundo"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: pegarDados(),
        builder: (context, var snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar os Dados",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                ibovespaNome = snapshot.data!["results"]["stocks"]["IBOVESPA"]
                        ["name"]
                    .toString();
                ibovespaLocal = snapshot.data!["results"]["stocks"]["IBOVESPA"]
                        ["location"]
                    .toString();
                ibovespaPontos = snapshot.data!["results"]["stocks"]["IBOVESPA"]
                        ["points"]
                    .toString();
                ibovespaVariacao = snapshot.data!["results"]["stocks"]
                        ["IBOVESPA"]["variation"]
                    .toString();
                //nasdaq
                nasdaqNome = snapshot.data!["results"]["stocks"]["NASDAQ"]
                        ["name"]
                    .toString();
                nasdaqLocal = snapshot.data!["results"]["stocks"]["NASDAQ"]
                        ["location"]
                    .toString();
                nasdaqPontos = snapshot.data!["results"]["stocks"]["NASDAQ"]
                        ["points"]
                    .toString();
                nasdaqVariacao = snapshot.data!["results"]["stocks"]["NASDAQ"]
                        ["variation"]
                    .toString();
                //nikkei
                nikkeiNome = snapshot.data!["results"]["stocks"]["NIKKEI"]
                        ["name"]
                    .toString();
                nikkeiLocal = snapshot.data!["results"]["stocks"]["NIKKEI"]
                        ["location"]
                    .toString();
                nikkeiPontos = snapshot.data!["results"]["stocks"]["NIKKEI"]
                        ["points"]
                    .toString();
                nikkeiVariacao = snapshot.data!["results"]["stocks"]["NIKKEI"]
                        ["variation"]
                    .toString();

                //CAC
                cacNome = snapshot.data!["results"]["stocks"]["CAC"]["name"]
                    .toString();
                cacLocal = snapshot.data!["results"]["stocks"]["CAC"]
                        ["location"]
                    .toString();
                cacPontos = snapshot.data!["results"]["stocks"]["CAC"]["points"]
                    .toString();
                cacVariacao = snapshot.data!["results"]["stocks"]["CAC"]
                        ["variation"]
                    .toString();

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "images/bolsa.jpg",
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      Divider(
                        color: Colors.deepPurpleAccent,
                      ),
                      construirTexto(ibovespaNome!, ibovespaVariacao!),
                      construirTexto(ibovespaLocal!, ibovespaVariacao!),
                      construirTexto(ibovespaPontos!, ibovespaVariacao!),
                      construirTexto(ibovespaVariacao!, ibovespaVariacao!),
                      Divider(
                        color: Colors.deepPurpleAccent,
                      ),
                      construirTexto(nasdaqNome!, nasdaqVariacao!),
                      construirTexto(nasdaqLocal!, nasdaqVariacao!),
                      construirTexto(nasdaqPontos!, nasdaqVariacao!),
                      construirTexto(nasdaqVariacao!, nasdaqVariacao!),
                      Divider(
                        color: Colors.deepPurpleAccent,
                      ),
                      construirTexto(nikkeiNome!, nikkeiVariacao!),
                      construirTexto(nikkeiLocal!, nikkeiVariacao!),
                      construirTexto(nikkeiPontos!, nikkeiVariacao!),
                      construirTexto(nikkeiVariacao!, nikkeiVariacao!),
                      Divider(
                        color: Colors.deepPurpleAccent,
                      ),
                      construirTexto(cacNome!, cacVariacao!),
                      construirTexto(cacLocal!, cacVariacao!),
                      construirTexto(cacPontos!, cacVariacao!),
                      construirTexto(cacVariacao!, cacVariacao!),
                    ], //children column
                  ),
                );
              } //if else
          } //swtich
        }, //builder
      ),
    );
  }
}

Future<Map> pegarDados() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

Widget construirTexto(String texto, String variacao) {
  double vari = double.parse(variacao);
  if (vari < 0.0) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.red,
        fontSize: 25,
      ),
    );
  } else {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.green,
        fontSize: 25,
      ),
    );
  }
}
