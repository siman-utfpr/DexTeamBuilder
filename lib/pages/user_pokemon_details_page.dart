import 'package:dex_team_builder/models/pokemon.dart';
import 'package:dex_team_builder/models/pokemon_species.dart';
import 'package:dex_team_builder/repositories/pokemon_repository.dart';
import 'package:dex_team_builder/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;
  const UserPokemonDetailsPage({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<UserPokemonDetailsPage> createState() => _UserPokemonDetailsPage();
}

class _UserPokemonDetailsPage extends State<UserPokemonDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
            "#${widget.pokemon.id} ${widget.pokemon.name} - ${widget.pokemon.nickname}"),
      ),
      body: SingleChildScrollView(
        
       
      ),
    );
  }
}
