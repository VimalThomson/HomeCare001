import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitSpinningLines(
          color: HexColor('#651BD2'),
          duration: const Duration(milliseconds: 3000),
          size: 75.0,
        ),
      ),
    );
  }
}