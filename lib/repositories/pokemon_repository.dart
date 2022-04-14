import 'dart:collection';

import 'package:dex_team_builder/models/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonRepository extends ChangeNotifier {
  List<Pokemon> _pokemons = [];

  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemons);

  insert(Pokemon pokemon) {
    _pokemons.add(pokemon);
    notifyListeners();
  }

  PokemonRepository() {
    _pokemons = [
      Pokemon(
        id: 4,
        name: "charmander",
        types: ["fire"],
        possibleMoves: [],
        nickname: "Nick",
        moves: ["Ember", "Scratch"],
      )
    ];
  }
}
