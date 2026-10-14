class SignUpEntity {
  int id;
  String email;
  String password;
  String name;
  String role;
  String avatar;
  String creationAt;
  String updatedAt;
  SignUpEntity({
    this.id = 0,
    this.email = '',
    this.password = '',
    this.name = '',
    this.role = '',
    this.avatar = '',
    this.creationAt = '',
    this.updatedAt = '',
  });
}
