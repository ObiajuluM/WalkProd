import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:walkit/global/constants.dart';
import 'package:walkit/modules/auth/access_token_handling.dart';
import 'package:walkit/modules/models/backend_model.dart';

Future<WalkUserBackend> getUser() async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/user/");

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  // make request
  final response = await http.get(url, headers: headers);

// parse response
  if (response.statusCode == 200) {
    log("GET USER REQUEST SUCCESSFUL");
    final responseData = WalkUserBackend.fromJson(jsonDecode(response.body));
    return responseData;
  } else {
    log("GET USER REQUEST FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

///  get the user last recorded steps
Future<Map<String, dynamic>> getUserLastRecordedSteps() async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/user-step/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  // make request
  final response = await http.get(url, headers: headers);

  // parse response
  if (response.statusCode == 200) {
    log("GET USER LAST STEPS SUCCESSFUL");
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    return responseMap;
  } else {
    log("GET USER LAST STEPS FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

Future<void> uploadSteps(int steps) async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/steps-today/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };
  final body = jsonEncode({"steps": steps});

  // make request
  final response = await http.post(url, headers: headers, body: body);

  // parse response
  if (response.statusCode == 200) {
    log("POST USER STEPS SUCCESSFUL");
  } else {
    log("POST USER STEPS FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

/// get leaderboard
Future<List<LeaderBoardBackend>> getLeaderBoard() async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  // final url = Uri.parse("http://127.0.0.1:8080/steps-today/");
  final url = Uri.parse("$kbaseURL/steps-today/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  // make request
  final response = await http.get(url, headers: headers);

  // parse response
  if (response.statusCode == 200) {
    log("GET LEADERBOARD SUCCESSFUL");
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List responseList = responseMap["data"];
    final leaders = responseList.map((item) {
      return LeaderBoardBackend.fromJson(item);
    }).toList();
    return leaders;
  } else {
    log("GET LEADERBOARD FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

// get the people the user invited
Future<List<WalkUserBackend>> getUserInvites() async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/user-invites/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  // make request
  final response = await http.get(url, headers: headers);

  // parse response
  if (response.statusCode == 200) {
    log("GET USER INVITES SUCCESSFUL");
    List<dynamic> responseMap = jsonDecode(response.body);
    final responseList =
        responseMap.map((item) => WalkUserBackend.fromJson(item)).toList();
    return responseList;
  } else {
    log("GET USER INVITES FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

Future<void> modifyUser(Map<String, dynamic> data) async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/user/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };
  final body = jsonEncode(data);

  // make request
  final response = await http.patch(url, headers: headers, body: body);

  // parse response
  if (response.statusCode == 200) {
    log("MODIFY USER REQUEST SUCCESSFUL");
  } else {
    log("MODIFY USER REQUEST FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}

Future<List<ClaimBackend>> getUserClaims() async {
  // create params
  final access_token = await retrieveAccessTokenFromLocal();
  final url = Uri.parse("$kbaseURL/user-claims/");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $access_token',
  };

  // make request
  final response = await http.get(url, headers: headers);

  // parse response
  if (response.statusCode == 200) {
    log("GET USER CLAIMS SUCCESSFUL");
    List<dynamic> responseMap = jsonDecode(response.body);
    final responseList =
        responseMap.map((item) => ClaimBackend.fromJson(item)).toList();
    return responseList;
  } else {
    log("GET USER CLAIMS FAILED");
    log(response.body);
    throw Exception(response.body);
  }
}
