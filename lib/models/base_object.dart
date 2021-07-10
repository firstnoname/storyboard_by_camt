import 'models.dart';

abstract class BaseObject {
  String id;
  Log log;

  BaseObject(this.id, this.log);
}
