import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasked/src/data/tarefas_list.dart';
import 'package:tasked/src/models/prioridade.dart';
import 'package:tasked/src/pages/components/prioridades_list.dart';
import 'package:tasked/src/pages/home_page.dart';

import '../../models/tarefa.dart';

class ModalAddTarefa extends StatefulWidget {
  const ModalAddTarefa({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalAddTarefa> createState() => _ModalAddTarefaState();
}

class _ModalAddTarefaState extends State<ModalAddTarefa> {
  DateTime dataFinalizacao = DateTime.now();
  final tituloController = TextEditingController();
  final observacaoController = TextEditingController();
  Prioridade prioridade = Prioridade.normal;

  createForm(var context) {
    List<Tarefa> tarefas = ListaTarefas.tarefas;
    int id = tarefas.length + 1;
    Tarefa tarefa = Tarefa(
        id: id,
        titulo: tituloController.text,
        observacao: observacaoController.text,
        dataFinalizacao: dataFinalizacao,
        prioridade: getPrioridadeSelecionada());
    ListaTarefas.addTarefa(tarefa);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

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
    final size = MediaQuery.of(context).size;
    _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2023))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          dataFinalizacao = pickedDate;
        });
      });
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Adicionar Tarefa'),
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(
              hintText: 'Título',
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: observacaoController,
            decoration: const InputDecoration(
              hintMaxLines: 3,
              hintText: 'Observação',
              labelText: 'Observação',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child:
                      Text('Data selecionada ${getDataFinalizacaoFormatada()}'),
                ),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar data'))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PrioridadesList(prioridade: prioridade, setState: setState),
          SizedBox(
            width: size.width,
            child: ElevatedButton(
              onPressed: () {
                createForm(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: const Text('Adicionar'),
            ),
          ),
        ],
      ),
    );
  }

  String getDataFinalizacaoFormatada() {
    if (dataFinalizacao == null) {
      return '';
    }
    return DateFormat('dd/MM/y').format(dataFinalizacao);
  }
}
