import '../models/prioridade.dart';
import '../models/tarefa.dart';

class ListaTarefas {
    static DateTime dataAnterior(){
        DateTime now = DateTime.now();
        DateTime date = DateTime(now.year, now.month, now.day - 1);
        return date;
    }
  static List<Tarefa> tarefas = [
    Tarefa(
      id: 1, 
      titulo: "estudar", 
      observacao: "estudar flutter", 
      dataFinalizacao: DateTime.now()
    ),
    Tarefa(
      id: 2, 
      titulo: "estudar math", 
      observacao: "estudar math math", 
      dataFinalizacao: DateTime.now()
    ),
    Tarefa(
      id: 3, 
      titulo: "estudar math", 
      observacao: "estudar math math", 
      dataFinalizacao: dataAnterior()
    ),
    Tarefa(
      id: 4, 
      titulo: "estudar math", 
      observacao: "estudar atradasa", 
      prioridade: Prioridade.alta,
      dataFinalizacao: DateTime.now().subtract(const Duration(days:1))
    ),
  ];

  static void addTarefa(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  static void removeTarefa(int id) {
    tarefas.removeWhere((tarefa) => tarefa.id == id);
  }

  static List<Tarefa> getTarefasPrioridade(Prioridade prioridade) {
    List<Tarefa> listaDeTarefas = tarefas
        .where((tarefa) => tarefa.prioridade == prioridade)
        .toList();
    listaDeTarefas.sort((a, b) => a.isConcluida ? 1 : -1);
    return listaDeTarefas;
  }

  static List<Tarefa> getTarefasPrioridadeNormal() {
    Prioridade prioridade = Prioridade.normal;
    return tarefas.where((tarefa) => tarefa.prioridade == prioridade).toList();
  }

  static List<Tarefa> getTarefasPrioridadeAlta() {
    Prioridade prioridade = Prioridade.alta;
    return tarefas.where((tarefa) => tarefa.prioridade == prioridade).toList();
  }

  static List<Tarefa> getTarefasPrioridadeBaixa() {
    Prioridade prioridade = Prioridade.baixa;
    return tarefas.where((tarefa) => tarefa.prioridade == prioridade).toList();
  }

  static List<Tarefa> getTarefasByDateAndPriority(Prioridade prioridade, DateTime date) {
    return tarefas
            .where((tarefa) => tarefa.prioridade == prioridade 
                && tarefa.dataFinalizacao.day == date.day).toList();
  }
}