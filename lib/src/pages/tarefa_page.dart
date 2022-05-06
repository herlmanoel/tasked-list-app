import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasked/src/models/prioridade.dart';
import 'package:tasked/src/models/tarefa.dart';

class TarefaPage extends StatefulWidget {
  Tarefa tarefa;
  TarefaPage({required this.tarefa, Key? key}) : super(key: key);

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  @override
  Widget build(BuildContext context) {
    final sizeBlocoWidth = (MediaQuery.of(context).size.width - 80) / 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefa"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              const Text("✅"),
              Expanded(
                child: Text(
                  widget.tarefa.titulo,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Row(children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    width: sizeBlocoWidth,
                    child: const Text("Prazo:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: sizeBlocoWidth,
                    child: Text(
                      DateFormat('d MMM y')
                          .format(widget.tarefa.dataFinalizacao),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: sizeBlocoWidth,
                    child: const Text("Concluída:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: sizeBlocoWidth,
                    child:
                        Text(widget.tarefa.isConcluida == true ? "Sim" : "Não",
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 10),
              Column(
                children: [
                  SizedBox(
                    width: sizeBlocoWidth,
                    child: const Text("Prioridade:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: sizeBlocoWidth,
                    child: Text(getPrioridadeTitulo(widget.tarefa.prioridade),
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 20),
            const SizedBox(
                width: double.infinity,
                child: Text("Observação:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.tarefa.observacao,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
