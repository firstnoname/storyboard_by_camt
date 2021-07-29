import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/widgets/widgets.dart';

class CardStoryList extends StatelessWidget {
  final List<File?> imagePath;
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
                      imagePath[index] = file;
                    },
                    currentImage: storyboardInfo.storyList![index].imagePath,
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
                color: Colors.blueGrey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: durationController,
                        decoration: InputDecoration(hintText: 'วินาทีในฉาก'),
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
                        decoration: InputDecoration(hintText: 'คำอธิบาย'),
                        onChanged: (value) => storyboardInfo
                            .storyList![index].description = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: vdoController,
                        decoration: InputDecoration(hintText: 'ภาพเคลื่อนไหว'),
                        onChanged: (value) =>
                            storyboardInfo.storyList![index].vdoName = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                        },
                      ),
                      const SizedBox(width: 8),
                      TextFormField(
                        controller: soundController,
                        decoration: InputDecoration(hintText: 'ชื่อไฟล์เสียง'),
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
                        decoration:
                            InputDecoration(hintText: 'ช่วงเวลาในไฟล์เสียง'),
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
                        decoration: InputDecoration(hintText: 'สถานที่'),
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
