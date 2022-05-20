import 'package:dex_team_builder/models/pokemon_species.dart';

class Pokemon extends PokemonSpecies {
  String nickname;
  List<String> moves;
  late String uid;

  Pokemon({
    required int id,
    required String name,
    required List<String> types,
    required List<String> possibleMoves,
    required this.nickname,
    required this.moves,
    this.uid = "0"
  }) : super(id: id, name: name, types: types, possibleMoves: possibleMoves);

  set pokemonUid(String pokemonUid){
    uid = pokemonUid;
  }
}
