import 'package:flutter/material.dart';

class CollapsingAppbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  CollapsingAppbarScreen(),
      ),

    );
  }
}

class CollapsingAppbarScreen extends StatefulWidget {
  @override
  _CollapsingAppbarScreenState createState() => _CollapsingAppbarScreenState();
}


class _CollapsingAppbarScreenState extends State<CollapsingAppbarScreen> {
 // const CollapsingAppbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("Collapsing Appbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.asset('lib/assets/Algeria.png')),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text("Item $index", textAlign: TextAlign.center));
          },
        ),
      ),
    );
  }
}
