import 'package:dex_team_builder/models/pokemon.dart';
import 'package:dex_team_builder/models/pokemon_species.dart';
import 'package:dex_team_builder/repositories/pokemon_repository.dart';
import 'package:dex_team_builder/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPokemonPage extends StatefulWidget {
  final PokemonSpecies pokemonSpecies;
  const NewPokemonPage({Key? key, required this.pokemonSpecies})
      : super(key: key);

  @override
  State<NewPokemonPage> createState() => _NewPokemonPage();
}

class _NewPokemonPage extends State<NewPokemonPage> {
  final _formKey = GlobalKey<FormState>();
  final _nickname = TextEditingController();
  List<String> _moves = ['', '', '', ''];

  save() {
    final pokemonRepository =
        Provider.of<PokemonRepository>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      pokemonRepository.insert(Pokemon(
        id: widget.pokemonSpecies.id,
        name: widget.pokemonSpecies.name,
        types: widget.pokemonSpecies.types,
        possibleMoves: widget.pokemonSpecies.possibleMoves,
        nickname: _nickname.value.text,
        moves: _moves,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokémon cadastrado!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<String> currentPossibleMoves = widget.pokemonSpecies.possibleMoves;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
            "#${widget.pokemonSpecies.id} - ${widget.pokemonSpecies.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/images/pokemon/${widget.pokemonSpecies.id}.png'),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/types/${widget.pokemonSpecies.types[0]}.png'),
                    const Text('  '),
                    widget.pokemonSpecies.types.length == 2
                        ? Image.asset(
                            'assets/images/types/${widget.pokemonSpecies.types[1]}.png')
                        : const Text(''),
                  ],
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nickname,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Apelido',
                      ),
                      validator: (value) {
                        if (value!.length > 10) {
                          return 'O número máximo de caracteres é 10.';
                        }
                        return null;
                      },
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Padding(
                            padding: EdgeInsets.zero,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Movimento ${index + 1}: '),
                              ),
                              items: [
                                ...widget.pokemonSpecies.possibleMoves.map(
                                    (e) => DropdownMenuItem(
                                        child: Text(e), value: e))
                              ],
                              onChanged: (value) => _moves[index] = value ?? '',
                              validator: (value) {
                                if (_moves
                                    .every((element) => element.isEmpty)) {
                                  return "Selecione pelo menos um movimento.";
                                }
                                return null;
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: _moves.length,
                      separatorBuilder: (_, __) => const Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: save,
                          child: const Text('Salvar'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
