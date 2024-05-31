import 'package:konsuldoc/domain/enums/role.dart';

abstract class User {
  final String id;
  final Role role;

  User({required this.id, required this.role});
}
