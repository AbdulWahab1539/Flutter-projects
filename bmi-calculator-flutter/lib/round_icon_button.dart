import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {

  RoundIconButton({@required this.icon, @required this.changeWeight});

  final IconData icon;
  final Function changeWeight;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: changeWeight,
      child: Icon(icon),
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
