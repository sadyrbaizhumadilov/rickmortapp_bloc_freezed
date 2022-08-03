import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmortapp_bloc_freezed_tdd/bloc/character_bloc.dart';
import 'package:rickmortapp_bloc_freezed_tdd/ui/widgets/custom_listTile.dart';

import '../../data/models/character.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSeachStr = '';

  @override
  void initState() {
    if (_currentResults.isEmpty) {
      context
          .read<CharacterBloc>()
          .add(const CharacterEvent.fetch(name: '', page: 1));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 15),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search name',
                hintStyle: TextStyle(color: Colors.white)),
            onChanged: (value) {
              _currentPage = 1;
              _currentResults = [];
              _currentSeachStr = value;

              context
                  .read<CharacterBloc>()
                  .add(CharacterEvent.fetch(name: value, page: _currentPage));
            },
          ),
        ),
        Expanded(
          child: state.when(loading: () {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Loading ...')
              ],
            ));
          }, loaded: (characterStateLoaded) {
            _currentCharacter = characterStateLoaded;
            _currentResults = _currentCharacter.results;
            return _currentResults.isNotEmpty
                ? _customListView(_currentResults)
                : SizedBox();
          }, error: () {
            return const Text('Nothing founded');
          }),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResults) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final result = currentResults[index];
          return Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
              child: CustomListTile(
                result: result,
              ));
        },
        separatorBuilder: (_, context) => SizedBox(
              height: 5,
            ),
        itemCount: currentResults.length);
  }
}
