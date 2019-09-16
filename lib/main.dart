import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController altController = TextEditingController();
  String _txtInfo = "Informe seus dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    pesoController.text = "";
    altController.text = "";
    setState(() {
      _txtInfo = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _caculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(altController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _txtInfo = "Abaixo do Peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _txtInfo = "Peso Ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        _txtInfo = "Levemento Acima do Peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _txtInfo = "Obesidade Grau I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _txtInfo = "Obesidade Grau II";
      } else if (imc >= 40) {
        _txtInfo = "Obesidade Grau III";
      }
      _txtInfo += " IMC: ${imc.toStringAsPrecision(4)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _resetFields,
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 120.0, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: pesoController,
                    validator: (value) {
                      if(value.isEmpty){
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: altController,
                    validator: (value) {
                      if(value.isEmpty){
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: (){
                          if (_formKey.currentState.validate()){
                            _caculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _txtInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
