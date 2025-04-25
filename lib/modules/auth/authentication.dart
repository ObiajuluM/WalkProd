import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:walkit/global/constants.dart';
import 'package:walkit/modules/auth/access_token_handling.dart';


class WalkItBackendAuth {
  // final String connectToBackendUrl;
  // final String? djangoClientId;
  // final String? googleAccessToken;

  // WalkItBackendAuth({
  //   required this.connectToBackendUrl,
  //   this.djangoClientId,
  // this.googleAccessToken,
  // });

  // sign in
  Future<String> signInWithCredential({
    required String djangoClientId,
    required String? googleAccessToken,
  }) async {
    // http://uri:port/auth/convert-token
    final connectTo = Uri.parse("$kbaseURL/auth/convert-token");
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final data =
        "grant_type=convert_token&client_id=$djangoClientId&backend=google-oauth2&token=$googleAccessToken";
    final result = await http.post(
      connectTo,
      headers: headers,
      body: data,
    );
    if (result.statusCode == 200) {
      final userData = jsonDecode(result.body) as Map<String, dynamic>;
      //  do the access token assignment here
      log("BACKEND SIGN IN SUCCESS");
      //  write token to local storage
      await writeAccessTokenToLocal(userData["access_token"]);
      return userData["access_token"];
    } else {
      throw Exception(result.body);
    }
  }

//  delete all refresh code and all access tokens and clear storage
  signOut(
    String accessToken,
    String djangoClientId,
    String accessDeleteBackendUrl,
    String refreshDeleteBackendUrl,
  ) async {
    // http://localhost:8000/auth/invalidate-sessions - access tokens
    // 'http://localhost:8000/auth/invalidate-refresh-tokens' - refresh tokens
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final data = 'client_id=$djangoClientId';

    // remove refresh token
    final rurl = Uri.parse(refreshDeleteBackendUrl);
    final deleteRefreshTokens =
        await http.post(rurl, headers: headers, body: data);

    //

    // remove access token
    final aurl = Uri.parse(accessDeleteBackendUrl);
    final deleteAccessTokens =
        await http.post(aurl, headers: headers, body: data);
    //

    // log the result code
    log(deleteRefreshTokens.statusCode.toString());
    log(deleteAccessTokens.statusCode.toString());

    // then clear access token from local
    await clearAccessTokenFromLocal();

    log("sign out success");
  }
}
