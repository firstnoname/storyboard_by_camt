import 'package:storyboard_camt/models/base_object.dart';
import 'package:storyboard_camt/models/user.dart';

import 'models.dart';

class StoryboardModel extends BaseObject {
  String? id;
  String? projectName;
  DateTime? createDate;
  User? author;
  String? userId;

  List<StoryDetail>? storyList;

  StoryboardModel(
      {this.projectName,
      this.createDate,
      this.author,
      this.userId,
      this.storyList,
      this.id,
      Log? log})
      : super(id: id, log: log);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (projectName != null) map['project_name'] = projectName;
    if (createDate != null) map['create_date'] = createDate.toString();
    if (author != null) map['author'] = author!.toMap();
    if (userId != null) map['user_id'] = userId;
    return map;
  }

  StoryboardModel.fromMap(dynamic map)
      : id = map['id'],
        projectName = map['project_name'],
        createDate = DateTime(map['create_date']),
        author = map['author'],
        userId = map['user_id'],
        storyList = [],
        super.fromMap(map) {
    if (map['story_list'] != null)
      map['story_list'].forEach((v) {
        storyList!.add(StoryDetail.fromMap(v));
      });
  }
}
