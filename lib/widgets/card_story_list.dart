import 'package:flutter/material.dart';
import 'package:storyboard_camt/widgets/widgets.dart';

class CardStoryList extends StatelessWidget {
  final TextEditingController textTimeController;
  final TextEditingController textVdoController;
  final TextEditingController textSoundController;
  final int index;
  CardStoryList(this.index, this.textTimeController, this.textVdoController,
      this.textSoundController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  ImageSelection(
                    onImageSelected: (file) {},
                  ),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Text('${index + 1}'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: this.textTimeController,
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: this.textVdoController,
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: this.textSoundController,
                      ),
                      const SizedBox(width: 8),
                      TextFormField(),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
