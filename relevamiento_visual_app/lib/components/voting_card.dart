import 'package:flutter/material.dart';

class VotingCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotingCardState();
  }
}

class _VotingCardState extends State<VotingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ColoredBox(
                    color: Colors.red,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.9), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(),
                      Image(
                        image: AssetImage('images/like.png'),
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Text("22"),
                      ),
                      Image(
                        image: AssetImage('images/dislike.png'),
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Text("22"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text("Subida por Dani"),
            Text("Fecha: "),
          ],
        ),
      ),
    );
  }
}
