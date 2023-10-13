import 'dart:convert';

String convertTokenToId(String jwtToken) {
  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTFmYWU3M2M0ODA5ZDQ1ZDI1ODA3OGYiLCJpYXQiOjE2OTcwMTc5NTIsImV4cCI6MTY5NzAyMTU1Mn0.S0ounfLQM2pwD6WtarWOu6DXpHxiIEZf0XckT8hIvsw";

  Map<dynamic, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT format');
    }

    final payload = parts[1];
    final String normalizedPayload = base64Url.normalize(payload);

    final String decodedPayload =
        utf8.decode(base64Url.decode(normalizedPayload));

    return json.decode(decodedPayload);
  }

  Map<dynamic, dynamic> decodedToken = parseJwt(jwtToken);

  String userId = decodedToken['userId'];

  return userId;
}
