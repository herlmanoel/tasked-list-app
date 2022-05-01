import 'package:flutter/material.dart';
import 'package:tasked/src/models/prioridade.dart';

class PrioridadesList extends StatelessWidget {
  Prioridade prioridade;
  
  bool isSelected = false;
  Function setState;
  PrioridadesList({ required this.prioridade, required this.setState, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sortCategorySelected();
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listPrioridades.length,
        itemBuilder: (BuildContext ctxt, int index) {
          var category = listPrioridades[index];
          return itemPrioridade(category['prioridade'], category['text'], category['isSelected']);
        },
      ),
    );
  }

  Container itemPrioridade(var prioridadeItem, var label, var isSelected) {
    return Container(
    margin: const EdgeInsets.only(right: 10),
    height: 10,
    padding: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: isSelected ? Colors.black : Colors.transparent,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextButton(
      onPressed: () {
        setState(() {
          updateCategorySelected(prioridadeItem);
          sortCategorySelected();
        });
      },
      child: Text(
        label,
        style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
  }

  String getTextByPrioridade(Prioridade prioridadeItem) {
    switch (prioridadeItem) {
      case Prioridade.normal:
        return "Normal";
      case Prioridade.baixa:
        return "Baixa";
      case Prioridade.alta:
        return "Alta";
      default:
        return "";
    }
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

  sortCategorySelected() {
    if (listPrioridades[0]['isSelected'] == true) {
      return;
    }
    listPrioridades.sort(
      (a, b) => a['isSelected'] == true ? -1 : 1
    );
  }
}