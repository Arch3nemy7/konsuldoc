enum Role {
  member,
  admin,
  doctor;
}

class UserModel {
  final String id;
  final String name;
  final Role role;

  UserModel({required this.id, required this.name, required this.role});
}
