import 'package:dex_team_builder/models/pokemon_species.dart';

class Pokemon extends PokemonSpecies {
  String nickname;
  List<String> moves;

  Pokemon({
    required int id,
    required String name,
    required List<String> types,
    required List<String> possibleMoves,
    required this.nickname,
    required this.moves,
  }) : super(id: id, name: name, types: types, possibleMoves: possibleMoves);
}
