import 'package:storyboard_camt/models/base_object.dart';
import 'package:storyboard_camt/models/user.dart';

import 'models.dart';

class StoryboardModel extends BaseObject {
  String? projectName;
  DateTime? createDate;
  User? author;

  List<StoryDetail>? storyList;

  StoryboardModel(
      {this.projectName,
      this.createDate,
      this.author,
      this.storyList,
      String? id,
      Log? log})
      : super(id: id, log: log);

  Map<String, dynamic> toMap() {
    var map;
    if (projectName != null) map['projectName'] = projectName;
    if (createDate != null) map['createDate'] = createDate;
    if (author != null) map['author'] = author!.toMap();
    return map;
  }

  StoryboardModel.fromMap(dynamic map)
      : projectName = map['projectName'],
        createDate = map['createDate'],
        author = map['author'],
        storyList = [],
        super.fromMap(map) {
    if (map['storyList'] != null)
      map['storyList'].forEach((v) {
        storyList!.add(StoryDetail.fromMap(v));
      });
  }
}
