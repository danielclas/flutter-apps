import 'package:flutter/material.dart';
import 'package:visual_survey_app/components/voting_card.dart';
import 'package:visual_survey_app/services/pictures_service.dart';

class VotingComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotingComponentState();
  }
}

class _VotingComponentState extends State<VotingComponent> {
  List<Widget> tiles = [];

  Future<void> getPictures() async {
    final pictures = PictureService.getAllPictures()
        .where((e) => (PictureService.niceThings && e.isNice) || (!PictureService.niceThings && !e.isNice));
    setState(() => tiles = pictures.map((e) => VotingCard(e)).toList());
  }

  @override
  void initState() {
    super.initState();
    getPictures();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: tiles.length > 0
          ? ListView(
              children: tiles,
            )
          : Center(
              child: Text('No hay imagenes para mostrar'),
            ),
    ));
  }
}
