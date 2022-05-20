import 'dart:collection';

import 'package:dex_team_builder/models/pokemon.dart';
import 'package:dex_team_builder/models/pokemon_species.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dex_team_builder/database/db.dart';
import 'package:dex_team_builder/services/auth_service.dart';

import 'package:dex_team_builder/repositories/pokemon_species_repository.dart';
import 'package:provider/provider.dart';

class PokemonRepository extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  late FirebaseFirestore db;
  late AuthService auth;

  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemons);

  insert(Pokemon pokemon) async {
    _pokemons.add(pokemon);
    var result = await db.collection('usuarios/${auth.usuario!.uid}/pokemons').add({
      'id': pokemon.id,
      'nickname': pokemon.nickname,
      'moves': pokemon.moves
    });
    pokemon.pokemonUid = result.id;
    await db.collection('usuarios/${auth.usuario!.uid}/pokemons').doc(result.id).update({'uid': result.id},);
    notifyListeners();
  }

  remove(Pokemon pokemon) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/pokemons')
        .doc(pokemon.uid).delete();
        
    _pokemons.remove(pokemon);
    notifyListeners();
  }

  _startRepository() async {
    await _startFirestore();
    await _readPokemon();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }



  _readPokemon() async {
    if (auth.usuario != null && _pokemons.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/pokemons').get();

      snapshot.docs.forEach((doc) {
        int id = doc.get('id');
        String nickname = doc.get('nickname');
        List<String> moves = [];
        for(var move in doc.get('moves')){
          moves.add(move);
        }
        PokemonSpecies pokemonSpecies = PokemonSpeciesRepository()
            .pokemonSpecies
            .where((element) => element.id == id)
            .first;

        Pokemon pokemon = Pokemon(
          id: id,
          name: pokemonSpecies.name,
          types: pokemonSpecies.types,
          possibleMoves: pokemonSpecies.possibleMoves,
          nickname: nickname,
          moves: moves,
        );
        _pokemons.add(pokemon);
        notifyListeners();
      });
    }
  }

  PokemonRepository({required this.auth}) {
    _startRepository();
  }
}
