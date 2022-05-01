import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasked/src/data/tarefas_list.dart';
import 'package:tasked/src/models/prioridade.dart';
import 'package:tasked/src/pages/components/prioridades_list.dart';
import 'package:tasked/src/pages/tarefa_page.dart';

import '../models/tarefa.dart';
import 'components/modal_add_tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tarefa> tarefas = [];
  Prioridade prioridade = Prioridade.normal;

  getPrioridadeSelecionada() {
    var prioridadeSelected =
        listPrioridades.firstWhere((element) => element['isSelected'] == true);
    return prioridadeSelected['prioridade'];
  }

  updateCategorySelected(var prioridadeItem) {
    for (var category in listPrioridades) {
      if (category['prioridade'] == prioridadeItem) {
        category['isSelected'] = true;
      } else {
        category['isSelected'] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    tarefas = ListaTarefas.getTarefasPrioridade(getPrioridadeSelecionada());
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: const Text(
              'Tasked',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  PrioridadesList(prioridade: prioridade, setState: setState)),
          const SizedBox(height: 20),
          Expanded(
            child: tarefas.isEmpty
                ? const Text('Nenhuma tarefa encontrada neste status.\n'
                    'Clique no botão abaixo para adicionar uma nova tarefa.')
                : createListTarefas(),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            updateCategorySelected(Prioridade.normal);
            showModalBottomSheet(
            context: context, builder: (context) => const ModalAddTarefa());
        },
        tooltip: 'Increment',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView createListTarefas() {
    return ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (context, index) {
        final bool tarefaNaoAtrasada =
            tarefas[index].dataFinalizacao.day >= DateTime.now().day;
        final bool tarefaIsConcluida = tarefas[index].isConcluida;
        return ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.black,
              value: tarefas[index].isConcluida,
              onChanged: (bool? newValue) {
                setState(() => {
                      tarefas[index].isConcluida = newValue ?? false,
                    });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TarefaPage(tarefa: tarefas[index]),
                      ),
                    ),
                  },
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    tarefas[index].titulo,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: tarefas[index].isConcluida == true
                          ? Colors.grey
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: tarefas[index].isConcluida == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Text(getPrioridadeTitulo(tarefas[index].prioridade),
                  style: TextStyle(
                    color: tarefas[index].isConcluida == true
                        ? Colors.grey
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: tarefas[index].isConcluida == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  )),
              const SizedBox(width: 5),
              Text(DateFormat('d MMM y').format(tarefas[index].dataFinalizacao),
                  style: TextStyle(
                      color: tarefaNaoAtrasada ? Colors.black : Colors.red[400],
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // subtitle: Text(tarefas[index].observacao),
          //   trailing: IconButton(
          //     icon: const Icon(Icons.delete),
          //     onPressed: () {
          //       setState(() {
          //         tarefas.removeAt(index);
          //       });
          //     },
          //   ),
        );
      },
    );
  }
}
