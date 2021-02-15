import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _controller = TextEditingController();

  List _toList = [];

  void _addNumber(){
      setState(() {
        Map<String, dynamic>  newNumber = Map();
        newNumber["number"] = _controller.text;
        newNumber["ok"] = false;
        _controller.text = "";
          _toList.add(newNumber);

      });
  }

  Future<Null> _ascendingOrder() async{
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toList.sort((a,b ){
        if(a["ok"] && !b["ok"]) return 1;
        else if (!a["ok"] && b["ok"]) return -1;
        else return 0;
      });

    });

    return null;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desafio numeros inteiros "),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
             child: Row(
              children:<Widget> [
               Expanded(
                 child:TextField(
                   controller: _controller,
                  decoration: InputDecoration(
                     labelText: "Adicione um numero inteiro",
                     labelStyle: TextStyle(color: Colors.blue)
                 ),
                 keyboardType: TextInputType.number,
               ),),
                RaisedButton(
                    onPressed: _addNumber,
                     color: Colors.blue,
                      child: Text("ADD"),
                       textColor: Colors.white,
                )
              ],
             ),
          ),
          Expanded(
                  child: RefreshIndicator(onRefresh: _ascendingOrder,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                        itemCount: _toList.length,
                        itemBuilder: (context,index){
                          return CheckboxListTile(
                           title: Text(_toList[index]["number"]),
                            value: _toList[index]["ok"], onChanged:
                              (c){
                             setState(() {
                               _toList[index]["ok"] = c;
                             });
                              },
                          );
                        }
                    ),
                  ),
          )
        ],
      ),
    );
  }


}

