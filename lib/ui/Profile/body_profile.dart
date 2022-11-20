import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          SizedBox(
            height: 40,
            child: Stack(
              children: <Widget>
              [
                Container(
                  height: 25,
                  color: Colors.deepPurple,
                )
              ],
            ),
          )
      ],
    );
  }
}