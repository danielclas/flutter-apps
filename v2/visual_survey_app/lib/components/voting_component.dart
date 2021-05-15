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
    await PictureService.getAllPictures();
    setState(() => tiles = PictureService.pictures.map((e) => VotingCard(e)).toList());
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
      child: ListView(
        children: tiles,
      ),
    ));
  }
}
