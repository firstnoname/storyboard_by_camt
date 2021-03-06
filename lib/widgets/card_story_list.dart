import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/widgets/widgets.dart';

class CardStoryList extends StatelessWidget {
  late File? imagePath;
  final int index;
  final StoryboardModel storyboardInfo;

  CardStoryList(
    this.storyboardInfo,
    this.index,
    this.imagePath, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var durationController =
        TextEditingController(text: storyboardInfo.storyList![index].duration);
    var descController = TextEditingController(
        text: storyboardInfo.storyList![index].description);
    var vdoController =
        TextEditingController(text: storyboardInfo.storyList![index].vdoName);
    vdoController.text = '';
    var soundController = TextEditingController(
        text: storyboardInfo.storyList![index].soundDuration);
    var soundSourceController = TextEditingController(
        text: storyboardInfo.storyList![index].soundSource);
    var placeController =
        TextEditingController(text: storyboardInfo.storyList![index].place);

    return Card(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  ImageSelection(
                    onImageSelected: (file) {
                      storyboardInfo.storyList![index].imagePath = file.path;
                      imagePath = file;
                    },
                    currentImage: storyboardInfo.storyList![index].imagePath,
                  ),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.blueGrey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: durationController,
                        decoration: InputDecoration(
                            hintText: '?????????????????????????????????', labelText: '?????????????????????????????????'),
                        onChanged: (value) =>
                            storyboardInfo.storyList![index].duration = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: descController,
                        decoration: InputDecoration(
                            hintText: '????????????????????????', labelText: '????????????????????????'),
                        onChanged: (value) => storyboardInfo
                            .storyList![index].description = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      // const SizedBox(width: 8),
                      // TextFormField(
                      //   controller: vdoController,
                      //   decoration: InputDecoration(hintText: '???????????????????????????????????????'),
                      //   onChanged: (value) =>
                      //       storyboardInfo.storyList![index].vdoName = value,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty)
                      //       return 'Please enter some text';
                      //   },
                      // ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: soundController,
                        decoration: InputDecoration(
                            hintText: '???????????????????????????????????????',
                            labelText: '???????????????????????????????????????'),
                        onChanged: (value) => storyboardInfo
                            .storyList![index].soundSource = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: soundSourceController,
                        decoration: InputDecoration(
                            hintText: '?????????????????????????????????????????????????????????',
                            labelText: '?????????????????????????????????????????????????????????'),
                        onChanged: (value) => storyboardInfo
                            .storyList![index].soundDuration = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: placeController,
                        decoration: InputDecoration(
                            hintText: '?????????????????????', labelText: '?????????????????????'),
                        onChanged: (value) =>
                            storyboardInfo.storyList![index].place = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
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
