import 'package:dex_team_builder/pages/pokedex_page.dart';
import 'package:dex_team_builder/pages/user_pokemon_page.dart';
import 'package:dex_team_builder/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        children: [
          ListTile(
            title: const Text("Pokédex"),
            tileColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const PokedexPage()));
            },
          ),
          ListTile(
            title: Text("Pokémons"),
            tileColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const UserPokemonPage()));
            },
          ),
          ListTile(
            title: Text("Times"),
            tileColor: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            tileColor: Color.fromARGB(255, 216, 216, 216),
            onTap: () {
              context.read<AuthService>().logout();
            },
          )
        ],
      ),
    );
  }
}
