class UserEntity {
  final String accessToken;
  final String refreshToken;
  final String? email;
  final String? name;
  final String? role;
  final String? id;

  UserEntity({
    required this.accessToken,
    required this.refreshToken,
    this.email,
    this.name,
    this.role,
    this.id,
  });
}
