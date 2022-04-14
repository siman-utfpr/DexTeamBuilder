import 'package:dex_team_builder/models/pokemon_species.dart';
import 'package:dex_team_builder/pages/new_pokemon_page.dart';
import 'package:dex_team_builder/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dex_team_builder/repositories/pokemon_species_repository.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPage();
}

class _PokedexPage extends State<PokedexPage> {
  openNewPokemonPage(PokemonSpecies pokemonSpecies) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => NewPokemonPage(pokemonSpecies: pokemonSpecies)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.supervised_user_circle),
            onPressed: () => {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 0, 10),
        child: Consumer<PokemonSpeciesRepository>(
            builder: (context, pokemonSpeciesRepository, _) {
          final pokemonSpeciesList = pokemonSpeciesRepository.pokemonSpecies;
          return ListView.separated(
            itemBuilder: (context, int index) {
              return ListTile(
                  leading: ClipRRect(
                    child: Hero(
                      tag: 'pokemon_${pokemonSpeciesList[index].id}',
                      child: Image.asset(
                        'assets/images/pokemon/${pokemonSpeciesList[index].id}.png',
                        scale: 0.1,
                      ),
                    ),
                  ),
                  title: Text(
                      '#${pokemonSpeciesList[index].id} - ${pokemonSpeciesList[index].name}'),
                  subtitle: Row(
                    children: [
                      Image.asset(
                          'assets/images/types/${pokemonSpeciesList[index].types[0]}.png'),
                      const Text('  '),
                      pokemonSpeciesList[index].types.length == 2
                          ? Image.asset(
                              'assets/images/types/${pokemonSpeciesList[index].types[1]}.png')
                          : const Text(''),
                    ],
                  ),
                  onTap: () => openNewPokemonPage(pokemonSpeciesList[index]));
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: pokemonSpeciesList.length,
          );
        }),
      ),
    );
  }
}
