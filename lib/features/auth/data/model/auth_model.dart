class AuthModel {
  final String token;
  final String email;
  final String refreshToken;
  final int expiresIn;
  final String id;

  AuthModel({
    required this.token,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.id,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json["idToken"],
      email: json["email"],
      refreshToken: json["refreshToken"],
      expiresIn: int.parse(json["expiresIn"]),
      id: json["localId"],
    );
  }
}
