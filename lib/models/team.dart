import 'package:dex_team_builder/models/pokemon.dart';

class Team {
  String name;
  String description;
  List<Pokemon> pokemons;

  Team({
    required this.name,
    required this.description,
    required this.pokemons,
  });
}
