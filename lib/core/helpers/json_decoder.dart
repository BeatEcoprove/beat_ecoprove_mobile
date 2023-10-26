import 'dart:convert';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    final splitToken = token.split("."); // Split the token by '.'
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final decodedPayload = jsonDecode(payloadString);

      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  static Map<String, dynamic>? tryDecode(String token) {
    try {
      return decode(token);
    } catch (error) {
      return null;
    }
  }

  static bool isExpired(String token) {
    final expirationDate = getExpirationDate(token);

    return DateTime.now().isAfter(expirationDate);
  }

  static DateTime _getDate({required String token, required String claim}) {
    final decodedToken = decode(token);
    final expiration = decodedToken[claim] as int?;
    if (expiration == null) {
      return throw Exception("There is no expire data");
    }
    return DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
  }

  static DateTime getExpirationDate(String token) {
    return _getDate(token: token, claim: 'exp');
  }

  static Duration? getTokenTime(String token) {
    final issuedAtDate = _getDate(token: token, claim: 'iat');

    return DateTime.now().difference(issuedAtDate);
  }

  static Duration? getRemainingTime(String token) {
    final expirationDate = getExpirationDate(token);

    return expirationDate.difference(DateTime.now());
  }
}
