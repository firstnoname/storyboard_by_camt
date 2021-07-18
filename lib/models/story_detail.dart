import 'package:storyboard_camt/models/base_object.dart';

import 'models.dart';

class StoryDetail extends BaseObject {
  String? imagePath;
  String? duration;
  String? description;
  String? vdoName;
  String? soundSource;
  String? soundDuration;
  String? place;

  String? storyboardId;

  StoryDetail(
      {this.imagePath,
      this.duration,
      this.description,
      this.vdoName,
      this.soundSource,
      this.soundDuration,
      this.place,
      this.storyboardId,
      String? id,
      Log? log})
      : super(id: id, log: log);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (imagePath != null)
      map['image_path'] = imagePath;
    else
      map['image_path'] = '';
    if (duration != null) map['duration'] = duration;
    if (vdoName != null) map['vdo_name'] = vdoName;
    if (description != null) map['description'] = description;
    if (soundSource != null) map['sound'] = soundSource;
    if (soundDuration != null) map['sound_duration'] = soundDuration;
    if (place != null) map['place'] = place;
    if (storyboardId != null) map['storyboard_id'] = storyboardId;

    return map;
  }

  StoryDetail.fromMap(dynamic map)
      : imagePath = map['image_path'],
        duration = map['duration'],
        vdoName = map['vdo_name'],
        description = map['description'],
        soundSource = map['sound'],
        soundDuration = map['sound_duration'],
        place = map['place'],
        storyboardId = map['storyboard_id'].toString(),
        super.fromMap(map);
}
