import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum LiveState { alive, dead, unknown }

class CharacterStatus extends StatelessWidget {
  const CharacterStatus({Key? key, required this.liveState}) : super(key: key);
  final LiveState liveState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            size: 11,
            color: liveState == LiveState.alive
                ? Colors.lightGreenAccent[400]
                : liveState == LiveState.dead
                    ? Colors.red
                    : Colors.white),
                    SizedBox(width: 6,),
                    Text(liveState==LiveState.dead?'Dead':liveState==LiveState.alive?'Alive':'Unknown',style: Theme.of(context).textTheme.bodyText2,),
      ],
    );
  }
}
