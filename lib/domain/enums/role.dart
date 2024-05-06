import 'package:konsuldoc/core/constants/table_constants.dart';

enum Role {
  member(TableConstants.members),
  admin(TableConstants.admins),
  doctor(TableConstants.doctors);

  final String table;

  const Role(this.table);
}
