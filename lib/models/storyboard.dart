import 'package:storyboard_camt/models/base_object.dart';

import 'models.dart';

class StoryboardModel extends BaseObject {
  String title;
  DateTime createDate;
  List<StoryDetail> storyList;

  StoryboardModel(
      this.title, this.createDate, this.storyList, String id, Log log)
      : super(id, log);
}
