
import 'package:flutter/material.dart';

class Map extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MapState();
  }
}


class MapState extends State<Map>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.blueAccent,
        title: const Text('Map'),
      ),
      body: BodyState(),
    );
  }

  Widget BodyState(){
    return Column(
      children: const [
        Text("Miaou"),
      ],
    );
  }
}

