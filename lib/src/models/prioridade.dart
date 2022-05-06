import 'package:flutter/material.dart';

enum Prioridade {
  alta,
  normal,
  baixa,
}



var listPrioridades = [
  {
    'prioridade': Prioridade.alta,
    'text': 'Alta',
    'color': Colors.red[400],
    'isSelected': false,
  },
  {
    'prioridade': Prioridade.normal,
    'text': 'Normal',
    'color': Colors.amber[400],
    'isSelected': true,
  },
  {
    'prioridade': Prioridade.baixa,
    'text': 'Baixa',
    'color': Colors.blue,
    'isSelected': false,
  },
];

getPrioridadeTitulo(Prioridade prioridade) {
  switch (prioridade) {
    case Prioridade.alta:
      return "Alta";
    case Prioridade.normal:
      return "Normal";
    case Prioridade.baixa:
      return "Baixa";
    default:
      return "";
  }
}

getPropriedadeColor(Prioridade prioridade) {
  switch (prioridade) {
    case Prioridade.alta:
      return Colors.red[400];
    case Prioridade.normal:
      return Colors.amber[400];
    case Prioridade.baixa:
      return Colors.blue;
    default:
      return Colors.black;
  }
}