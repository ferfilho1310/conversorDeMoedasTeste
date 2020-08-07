import 'dart:convert';

import 'package:conversordemoedasapp/Helper/ConversoHelperDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Moeda.dart';

enum mHistorico { historico }

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=00ae39b7";

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ConversorDeMoedasUi(),
  ));
}

class ConversorDeMoedasUi extends StatefulWidget {
  @override
  _ConversorDeMoedasUiState createState() => _ConversorDeMoedasUiState();
}

class _ConversorDeMoedasUiState extends State<ConversorDeMoedasUi> {
  ConversorHelper _conversorHelper = ConversorHelper();

  Moeda _moeda;

  double dolar;
  double euro;

  int _valueDropDownFirst = 1;
  int _valueDropDownSecond = 1;

  final _valorParaConversao = TextEditingController();
  final _valorConvertido = TextEditingController();

  void clear(){
    _valorParaConversao.text = "";
    _valorConvertido.text = "";
  }

  void _realChanged(String string, int dropDownFirst, int dropDownSecond) {
    String conversoes;

    _valorParaConversao.text = string;

    double valores = double.parse(string);

    if (dropDownFirst == 1 && dropDownSecond == 2) {
      conversoes = (valores * this.euro / dolar).toStringAsFixed(2);
    } else if (dropDownFirst == 2 && dropDownSecond == 1) {
      conversoes = (valores * this.dolar / euro).toStringAsFixed(2);
    }
    _valorConvertido.text = conversoes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Conversão de Moedas"),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            PopupMenuButton<mHistorico>(
              itemBuilder: (context) => <PopupMenuEntry<mHistorico>>[
                const PopupMenuItem(
                    child: Text("Histórico"), value: mHistorico.historico)
              ],
            )
          ],
        ),
        body: FutureBuilder<Map> (
          future: getMoeda(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Dialog(
                  backgroundColor: Colors.white,
                  child: Text(
                    "Erro na conexão com servidor.\nTente mais tarde",
                    style: TextStyle(color: Colors.deepPurple,fontSize: 25.0),
                  ),
                ),
              );
            } else {
              dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
              euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

              return SingleChildScrollView(
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        DropdownButton(
                          isExpanded: true,
                          value: _valueDropDownFirst,
                          items: [
                            DropdownMenuItem(
                              child: Text("Euro"),
                              value: 1,
                              onTap: (){
                                setState(() {
                                  clear();
                                });
                              },
                            ),
                            DropdownMenuItem(
                              child: Text("Dolar"),
                              value: 2,
                              onTap: (){
                                setState(() {
                                  clear();
                                });
                              },
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _valueDropDownFirst = value;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _valorParaConversao,
                            decoration: InputDecoration(
                                hintText: "R\$",
                                labelStyle: TextStyle(color: Colors.deepPurple),
                                labelText: "Digite o valor a ser convertido"),
                            onChanged: (text) {
                              _realChanged(text, _valueDropDownFirst, _valueDropDownSecond);
                              _moeda.mValorParaConversao = text;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: _valueDropDownSecond,
                            items: [
                              DropdownMenuItem(
                                child: Text("Euro"),
                                value: 1,
                                onTap: (){
                                  setState(() {
                                    clear();
                                  });
                                },
                              ),
                              DropdownMenuItem(
                                child: Text("Dolar"),
                                value: 2,
                                onTap: (){
                                  setState(() {
                                    clear();
                                  });
                                },
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _valueDropDownSecond = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: TextField(
                            controller: _valorConvertido,
                            enabled: false,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.deepPurple),
                                labelText: "Resultado da Conversão"),
                            onChanged: (text){
                                _moeda.mNomeMoedaConvertida = text;
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 40.0),
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text("Salvar"),
                            textColor: Colors.white,
                            color: Colors.deepPurple,
                            onPressed: () {
                             _conversorHelper.saveConversao(_moeda);
                            },
                          ),
                        ),
                      ],
                    ),
                  ));
            }
          },
        ));
  }
}

Future<Map> getMoeda() async {
  http.Response reponse = await http.get(request);
  print(reponse.body);
  return json.decode(reponse.body);
}
