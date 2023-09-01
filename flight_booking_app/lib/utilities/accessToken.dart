class AccessToken {
  final String tokenType;
  final String accessToken;
  final int expiresIn;

  AccessToken({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
    );
  }
}

