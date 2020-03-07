import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.1),
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.purple[400],
          size: 50,
        ),
      ),
    );
  }
}
