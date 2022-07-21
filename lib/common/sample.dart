import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class Sample extends StatefulWidget {

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ExpansionTileCard Demo'),
      ),
      body: Center(
        child: Container(
          width: 250,
            height: 50,
            child: FlatButton(
              minWidth: 320,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              onPressed: () {
                blah();
              },
              child: Column(
                children: <Widget>[

                  Text('Date Difference', style: TextStyle(fontSize:16),),
                ],
              ),
            ),

        ),
      ),
    );
  }
  void blah() {
    DateTime dt1 = DateTime(2022,07,06);
    DateTime dt2 = DateTime(2022,07,15);
    final difference = dt2.difference(dt1).inDays;
    print(difference);
  }
}