import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum mHistorico { historico }

void main() {
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

  int _valueDropDownFirst = 1;
  int _valueDropDownSecond = 1;

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
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 40,left: 20,right: 20),
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
                     ),
                     DropdownMenuItem(
                       child: Text("Dolar"),
                       value: 2,
                     )
                   ],
                   onChanged: (value){
                     setState(() {
                       _valueDropDownFirst = value;
                     });
                   },
                 ),
                 Padding(
                   padding: EdgeInsets.only(top: 25.0),
                   child:  TextField(
                     decoration: InputDecoration(
                         hintText: "R\$",
                         labelStyle: TextStyle(color: Colors.deepPurple),
                         labelText:  "Digite o valor a ser convertido"
                     ),
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
                        ),
                        DropdownMenuItem(
                          child: Text("Dolar"),
                          value: 2,
                        )
                      ],
                      onChanged: (value){
                        setState(() {
                          _valueDropDownSecond = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          labelText:  "Resultado da Conversão"
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 40.0),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: Text("Converter"),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: (){

                    },),
                  )
                ],
              ),
            )
        )
    );
  }
}
