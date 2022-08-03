import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rickmortapp_bloc_freezed_tdd/ui/widgets/character_status.dart';

import '../../data/models/character.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.result}) : super(key: key);
  final Results result;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: size.height / 7,
        color: Color.fromRGBO(86, 86, 86, 08),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              placeholder: (context, url) => CircularProgressIndicator(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width / 1.9,
                    child: Text(
                      result.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CharacterStatus(
                      liveState: result.status == 'Alive'
                          ? LiveState.alive
                          : result.status == 'Dead'
                              ? LiveState.dead
                              : LiveState.unknown),
                  SizedBox(
                    width: size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Species',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(result.species,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(result.gender,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
