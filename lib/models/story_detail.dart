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
  String? id;
  String? storyboardId;
  String? keyIndex;

  StoryDetail(
      {this.imagePath,
      this.duration,
      this.description,
      this.vdoName,
      this.soundSource,
      this.soundDuration,
      this.place,
      this.storyboardId,
      this.id,
      this.keyIndex,
      Log? log})
      : super(id: id, log: log);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (imagePath != null)
      map['image_path'] = imagePath;
    else
      map['image_path'] = '';
    if (duration != null) map['duration'] = duration;
    if (vdoName != null)
      map['vdo_name'] = vdoName;
    else
      map['vdo_name'] = '';
    if (description != null) map['description'] = description ?? '';
    if (soundSource != null) map['sound'] = soundSource ?? '';
    if (soundDuration != null) map['sound_duration'] = soundDuration ?? '';
    if (place != null) map['place'] = place ?? '';
    if (storyboardId != null) map['storyboard_id'] = storyboardId;

    return map;
  }

  StoryDetail.fromMap(dynamic map)
      : id = map['id'].toString(),
        imagePath = map['image_path'],
        duration = map['duration'],
        vdoName = map['vdo_name'],
        description = map['description'],
        soundSource = map['sound'],
        soundDuration = map['sound_duration'],
        place = map['place'],
        storyboardId = map['storyboard_id'].toString(),
        keyIndex = map['key_index'].toString(),
        super.fromMap(map);
}
