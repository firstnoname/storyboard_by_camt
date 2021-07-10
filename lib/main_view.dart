import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:storyboard_camt/views/create_storyboard/create_storyboard_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String? _colorName;
  Color? _color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.cyan[200],
          title: Text('Storyboard by CAMT'),
        ),
        body: SafeArea(
          child: CircularMenu(
            alignment: Alignment.bottomCenter,
            startingAngleInRadian: 1.25 * 3.14,
            endingAngleInRadian: 1.75 * 3.14,
            backgroundWidget: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Text('A card that can be tapped'),
                  ),
                ),
              ),
            ),
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceInOut,
            toggleButtonColor: Colors.cyan[400],
            items: [
              CircularMenuItem(
                  icon: Icons.home,
                  color: Colors.brown,
                  onTap: () {
                    setState(() {
                      _color = Colors.brown;
                      _colorName = 'Brown';
                    });
                  }),
              CircularMenuItem(
                  icon: Icons.add,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateStoryboardView(),
                        ));
                    setState(() {
                      _color = Colors.green;
                      _colorName = 'Green';
                    });
                  }),
              CircularMenuItem(
                  icon: Icons.settings,
                  color: Colors.red,
                  onTap: () {
                    setState(() {
                      _color = Colors.red;
                      _colorName = 'red';
                    });
                  }),
              // CircularMenuItem(
              //     icon: Icons.chat,
              //     color: Colors.orange,
              //     onTap: () {
              //       setState(() {
              //         _color = Colors.orange;
              //         _colorName = 'orange';
              //       });
              //     }),
              // CircularMenuItem(
              //     icon: Icons.notifications,
              //     color: Colors.purple,
              //     onTap: () {
              //       setState(() {
              //         _color = Colors.purple;
              //         _colorName = 'purple';
              //       });
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
