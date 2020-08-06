import 'package:conversordemoedasapp/conversor_moedas_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ConversorDeMoedasUi(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: Colors.deepPurple,
                size: 100,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Bem vindo ao conversor de moedas do Fernando.\nDigite seu dados para entrar.",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 300),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      hintText: "Digite seu e-mail"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      hintText: "Digite sua senha"),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text("SIGN IN",
                      style: TextStyle(color: Colors.white)
                  ),
                  color: Colors.deepPurple,
                  onPressed: (){
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child:Text("Forgot Password ?",
                  style: TextStyle(color: Colors.deepPurple,
                  fontWeight: FontWeight.bold)) ,
              )
            ],
          ),
        ));
  }
}
