import 'package:storyboard_camt/models/base_object.dart';

import 'models.dart';

class User extends BaseObject {
  String? firstName;
  String? lastName;

  User({this.firstName, this.lastName, String? id, Log? log})
      : super(id: id, log: log);

  User.fromMap(dynamic map)
      : firstName = map['firstName'],
        lastName = map['lastName'],
        super.fromMap(map);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;

    return map;
  }
}
