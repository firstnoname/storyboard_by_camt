import 'package:storyboard_camt/models/base_object.dart';

import 'models.dart';

class StoryDetail extends BaseObject {
  String? imagePath;
  String? duration;
  String? description;
  String? soundSource;
  String? soundDuration;
  String? place;

  StoryDetail(this.imagePath, this.duration, this.description, this.soundSource,
      this.soundDuration, this.place,
      {String? id, Log? log})
      : super(id: id, log: log);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'sb_image_path': imagePath,
      'sb_duration': duration,
      'sb_description': description,
      'sb_sound': soundSource,
      'sb_sound_duration': soundDuration,
      'sb_place': place,
    };
  }

  StoryDetail.fromMap(dynamic map)
      : imagePath = map['imagePath'],
        duration = map['duration'],
        description = map['description'],
        soundSource = map['soundSource'],
        soundDuration = map['soundDuration'],
        place = map['place'],
        super.fromMap(map);
}
