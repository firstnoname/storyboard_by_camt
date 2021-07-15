import 'models.dart';

abstract class BaseObject {
  String? id;
  Log? log;

  BaseObject({this.id, this.log});

  BaseObject.fromMap(dynamic map, {String? id})
      : this(
          id: map["id"] ?? id,
          // log: map["log"] != null ? Log.fromMap(map["log"]) : null,
        );
}
