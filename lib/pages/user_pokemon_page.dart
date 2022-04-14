import 'package:dex_team_builder/pages/user_pokemon_details_page.dart';
import 'package:dex_team_builder/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class UserPokemonPage extends StatefulWidget {
  const UserPokemonPage({Key? key}) : super(key: key);

  @override
  State<UserPokemonPage> createState() => _UserPokemonPage();
}

class _UserPokemonPage extends State<UserPokemonPage> {
  openPokemonDetailsPage(Pokemon pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => UserPokemonDetailsPage(pokemon: pokemon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Seus pokémons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.supervised_user_circle),
            onPressed: () => {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 0, 10),
        child: Consumer<PokemonRepository>(
            builder: (context, pokemonRepository, _) {
          final pokemonsList = pokemonRepository.pokemons;
          return ListView.separated(
            itemBuilder: (context, int index) {
              return ListTile(
                  leading: ClipRRect(
                    child: Hero(
                      tag: 'pokemon_${pokemonsList[index].id + index}',
                      child: Image.asset(
                        'assets/images/pokemon/${pokemonsList[index].id}.png',
                        scale: 0.1,
                      ),
                    ),
                  ),
                  title: Text(
                      '#${pokemonsList[index].id} - ${pokemonsList[index].name}: ${pokemonsList[index].nickname}'),
                  subtitle: Row(
                    children: [
                      Image.asset(
                          'assets/images/types/${pokemonsList[index].types[0]}.png'),
                      const Text('  '),
                      pokemonsList[index].types.length == 2
                          ? Image.asset(
                              'assets/images/types/${pokemonsList[index].types[1]}.png')
                          : const Text(''),
                    ],
                  ),
                  onTap: () => openPokemonDetailsPage(pokemonsList[index]));
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: pokemonsList.length,
          );
        }),
      ),
    );
  }
}
