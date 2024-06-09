import 'package:escucha_tu_historia/models/monument.dart';
import 'package:escucha_tu_historia/models/monument_reduced.dart';
import 'package:escucha_tu_historia/services/monument_service.dart';
import 'package:escucha_tu_historia/share_preferences/preferences.dart';
import 'package:flutter/material.dart';

class MonumentsProvider extends ChangeNotifier {
  MonumentService monumentService = MonumentService();
  final Map<String, List<MonumentReduced>?> _monumentsReduced = {};

  final Map<String, List<Monument>?> _monuments = {};

  Map<String, List<MonumentReduced>?> get monumentsReduced {
    return _monumentsReduced;
  }

  Monument? selectedMonument;

  Map<String, List<Monument>?> get monuments => _monuments;

  MonumentsProvider() {
    getMonumentsReduced();
    getAllMonuments();
  }

  /// Este método se encarga de obtener los monumentos reducidos ahorrandose peticiones innecesarias
  void getMonumentsReduced() async {
    // si existe en el mapa de monumentos reducidos, no se vuelve a hacer la petición
    if (!_monumentsReduced.containsKey(Preferences.language)) {
      _monumentsReduced[Preferences.language] =
          await monumentService.getMonumentsReduced();
      // ordenar los monumentos por numero
      _monumentsReduced[Preferences.language]!.sort((a, b) {
        return a.number!.compareTo(b.number!);
      });
    }
    notifyListeners();
  }

  /// Este método se encarga de obtener un monumento en concreto ahorrandose peticiones innecesarias
  void getMonument(int id) async {
    //compruebo que existe un key con el idioma seleccionado
    if (!_monuments.containsKey(Preferences.language)) {
      _monuments[Preferences.language] = [];
      selectedMonument = await monumentService.getMonument(id);
      _monuments[Preferences.language]!.add(selectedMonument!);
    } else if (_monuments[Preferences.language]!
        .every((element) => element.number != id)) {
      //compruebo que no existe el monumento en la lista
      selectedMonument = await monumentService.getMonument(id);
      _monuments[Preferences.language]!.add(selectedMonument!);
    } else {
      selectedMonument = _monuments[Preferences.language]!.firstWhere(
          (element) =>
              element.number ==
              id); //obtengo el monumento de la lista si ya existe
    }
  }

  ///indica si hay un monumento siguiente al actual
  bool thereIsNextMonument(int idCurrentMonument) {
    try {
      final nextMonument = _monumentsReduced[Preferences.language]!
          .firstWhere((element) => element.number == idCurrentMonument + 1);
      return nextMonument.number != null;
    } catch (e) {
      return false;
    }
  }

//indica si hay un monumento anterior al actual
  ///indica si hay un monumento anterior al actual
  bool thereIsPreviousMonument(int idCurrentMonument) {
    try {
      final previousMonument = _monumentsReduced[Preferences.language]!
          .firstWhere((element) => element.number == idCurrentMonument - 1);
      return previousMonument.number != null;
    } catch (e) {
      return false;
    }
  }

//obtiene el monumento anterior al actual
  void getNextMonument(int idCurrentMonument) {
//como el number no tiene que ser por orden tengo que buscar el siguiente monumento desde reduce
    final nextMonument = _monumentsReduced[Preferences.language]!
        .firstWhere((element) => element.number == idCurrentMonument + 1);
    getMonument(nextMonument.number!);

    notifyListeners();
  }

//obtiene el monumento anterior al actual
  void getPreviousMonument(int idCurrentMonument) {
    final previousMonument = _monumentsReduced[Preferences.language]!
        .firstWhere((element) => element.number == idCurrentMonument - 1);
    getMonument(previousMonument.number!);
    notifyListeners();
  }

  /// Este método se encarga de obtener todos los monumentos ahorrandose peticiones innecesarias
  void getAllMonuments() async {
    // si existe en el mapa de monumentos reducidos, no se vuelve a hacer la petición
    if (!_monuments.containsKey(Preferences.language)) {
      _monuments[Preferences.language] =
          await monumentService.getAllMonuments();
      // ordenar los monumentos por numero
      _monuments[Preferences.language]!.sort((a, b) {
        return a.number!.compareTo(b.number!);
      });
    }
    notifyListeners();
  }

/// Este método se encarga de obtener los monumentos de una ruta en concreto
  List<MonumentReduced>? getMonumentsByRoute(List<int> monumentsByRoute) {
    List<MonumentReduced>? monuments;

    for (var element in monumentsByRoute) {
      final monument = _monumentsReduced[Preferences.language]!
          .firstWhere((elementReduced) => elementReduced.number == element);
      monuments ??= [];
      monuments.add(monument);
    }

    return monuments;
  }
}
