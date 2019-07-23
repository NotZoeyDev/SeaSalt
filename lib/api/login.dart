/*
  Handles login/getting API key
  By @ZoeyLovesMiki, 2019
*/

/* Imports */
import 'dart:convert';
import 'package:http/http.dart' as http;
import './utils.dart';

class Login {
  /*
    Get our API/login onto e621
  */
  static Future<String> login(String username, String password) async {
    /* Our endpoint url */
    String url = "${Utils.getBaseURL()}/user/login.json?name=$username&password=$password";

    // Do our web request
    var response = await http.get(url);

    // Check if the request returned 200
    if(response.statusCode == 200) {
      // Parse the result JSON
      dynamic responseJSON = jsonDecode(response.body);

      // Check if it returned a password_hash/api key
      if(responseJSON['password_hash'] != null) {
        return responseJSON['password_hash'];
      } else {
        throw("Invalid login");
      }
    } else {
      throw("Unkown error");
    }
  }
}