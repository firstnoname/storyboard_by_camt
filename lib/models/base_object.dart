import 'models.dart';

abstract class BaseObject {
  String? id;
  Log? log;

  BaseObject({this.id, this.log});

  BaseObject.fromMap(dynamic map, {String? id})
      : this(
          id: '',
          // log: map["log"] != null ? Log.fromMap(map["log"]) : null,
        );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) map['id'] = id;

    return map;
  }
}
