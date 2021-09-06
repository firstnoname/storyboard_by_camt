import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelection extends StatefulWidget {
  final String? currentImage;
  final void Function(File)? onImageSelected;

  const ImageSelection({Key? key, this.onImageSelected, this.currentImage})
      : super(key: key);

  @override
  _ImageSelectionState createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  final _picker = ImagePicker();

  File? _image;

  _imgFromCamera() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
      widget.onImageSelected!(_image!);
    });
  }

  _imgFromGallery() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    print('image from gallery -> ${image?.path}');

    if (image != null) {
      setState(() {
        _image = File(image.path);
        widget.onImageSelected!(_image!);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentImage != null && _image == null) {
      _image = File(widget.currentImage!);
    } else if (_image != null) {
    } else
      _image = null;

    return Stack(
      children: [
        _image != null
            ? Container(
                height: double.infinity,
                child: Image.file(
                  _image!,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(),
        Container(
          child: Center(
            child: IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => _showPicker(context),
            ),
          ),
        ),
      ],
    );
  }
}
