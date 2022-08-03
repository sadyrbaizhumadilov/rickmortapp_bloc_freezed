import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmortapp_bloc_freezed_tdd/bloc/character_bloc.dart';
import 'package:rickmortapp_bloc_freezed_tdd/data/repositories/character_repo.dart';

import 'search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final repository = CharacterRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Rick and Morty', style: TextStyle(color: Colors.white)),
      ),
      body: BlocProvider(
        create: (context) => CharacterBloc(characterRepo: repository),
        child: Container(
            decoration: BoxDecoration(color: Colors.black87),
            child: SearchPage()),
      ),
    );
  }
}
