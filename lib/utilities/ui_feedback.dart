import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UIFeedback {
  final BuildContext _context;
  bool isShowingDialog = false;

  UIFeedback(this._context);

  Future showLoading() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.circle;
    EasyLoading.show(status: "Loading");

    return Future.delayed(Duration(seconds: 2, milliseconds: 1));
  }

  Future hideLoading() {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    return Future.delayed(Duration(microseconds: 1));
  }

  Future<void> showErrorDialog(BuildContext context,
      {String title = '', String content = ''}) {
    return showOKDialog(context, title, content);
  }

  Future<void> showOKDialog(
      BuildContext context, String title, String content) {
    isShowingDialog = true;
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  showConfirmDialog2(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$title'),
        content: Text('$content'),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('ยืนยัน'),
          ),
        ],
      ),
    );
  }

  showConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('title'),
        content: Text('content'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยืนยัน'),
          ),
        ],
      ),
    );
  }
}
