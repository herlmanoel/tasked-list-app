import 'package:tasked/src/models/prioridade.dart';

class Tarefa {
  int id;
  Prioridade prioridade;
  String titulo;
  String observacao;
  DateTime dataCriacao = DateTime.now();
  DateTime dataFinalizacao;
  bool isConcluida = false;

  Tarefa({
    this.prioridade = Prioridade.normal, 
    required this.id,
    required this.titulo,
    required this.observacao, 
    required this.dataFinalizacao
  });

  
}