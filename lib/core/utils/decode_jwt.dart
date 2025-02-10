import 'dart:convert';
import 'dart:typed_data';

Map<String, dynamic> decodeJwt(String token) {
  final List<String> splitToken = token.split('.');
  final String payloadBase64 = splitToken[1];
  final String normalizedPayload = base64.normalize(payloadBase64);
  final Uint8List decoded64Payload = base64.decode(normalizedPayload);
  final String payloadString = utf8.decode(decoded64Payload);
  final Map<String, dynamic> decodedPayload = jsonDecode(payloadString);
  return decodedPayload;
}