import 'package:flutter/material.dart';
import 'package:tasked/src/models/tarefa.dart';

class TarefaPage extends StatefulWidget {
  Tarefa tarefa;
  TarefaPage({required this.tarefa, Key? key }) : super(key: key);

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa.titulo),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.tarefa.observacao),
            Text(widget.tarefa.dataFinalizacao.toString()),
            Text(widget.tarefa.isConcluida.toString()),
            Text(widget.tarefa.prioridade.toString()),
          ],
        ),
      ),
    );
  }
}