

part of 'authentication_client.dart';


Map<String, dynamic>? _parseGoogleToken(String? token) {

  if( token == null)
    return null;

  final List<String> tokenParts = token.split('.');
  if(tokenParts.length != 3)
    return null;

  final String tokenPayload = tokenParts[1];
  final String normalized = base64Url.normalize(tokenPayload);
  final String response = utf8.decode(base64Url.decode(normalized));

  final payloadMap = json.decode(response);
  if( payloadMap is! Map<String, dynamic>)
    return null;

  return payloadMap;

}


Map<String, dynamic> _createUserData(Map<String, dynamic> payloadMap, GoogleSignInAccount account) {
  return {
    user_fields.firstName : payloadMap["given_name"],
    user_fields.lastName  : payloadMap["family_name"],
    user_fields.email     : account.email,
    user_fields.profilePictureUrl : account.photoUrl,
    user_fields.providerUserId : account.id,
    user_fields.signedInType : SignedInType.Google.parseSignedInType(),
    user_fields.firebaseUserId : FirebaseAuth.instance.currentUser!.uid
  };
}