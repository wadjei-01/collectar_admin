import 'package:collectar_admin/login/user_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<User> getUser() => Hive.box<User>('user');
}
