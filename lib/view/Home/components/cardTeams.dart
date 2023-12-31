import 'package:comic_hub/model/character.dart';
import 'package:comic_hub/model/teams.dart';
import 'package:flutter/material.dart';

import '../../../styles/styleSheet.dart';

class MyTeamCard extends StatelessWidget {
  //const MyTeamCard({super.key, this.character, this.teams});
  const MyTeamCard({super.key, this.team, });
  final Character? team;
  //final Teams? teams;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              team?.image?['screen_url']?? '',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            team?.name ?? 'NULL',
            style: cardTextStyle,
          ),
        ],
      ),
    );

  }
}
