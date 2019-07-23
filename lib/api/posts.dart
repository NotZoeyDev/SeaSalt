/*
  Anything related to posts
  By @ZoeyLovesMiki, 2019
*/

/* Imports */
import 'dart:convert';
import "package:http/http.dart" as http;
import './utils.dart';
import '../models/post.dart';

class Posts {
  /**
   * Create a post
   */
  static Future<void> create() async {
  }

  /**
   * Update a post
   */
  static Future<void> update() async {

  }

  /**
   * Show a post
   */
  static Future<Post> show({String id, String md5}) async {
    // Make sure we got either an id or md5
    if(id == null && md5 == null) {
      throw("ID or md5 must be defined.");
    }
    
    // The url to retreive the post
    var url = '${Utils.getBaseURL()}/post/show.json?';
    // Append either "id=" or "md5="
    url += (id != null 
      ? "id=$id"
      : "md5=$md5");

    // Do our request
    var response = await http.get(url, headers: Utils.getHeaders());

    // Make sure the request went well
    if(response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw("Error");
    }
  }

  /**
   * List posts
   */
  static Future<List<Post>> list({String beforeID, int limit = 50, String tags}) async {
    // Url in the api
    var url = "${Utils.getBaseURL()}/post/index.json?limit=$limit";

    // Paramters to add
    List<String> params = new List<String>();

    // If beforeID is specified
    if(beforeID != null) {
      params.add("beforeID=$beforeID");
    }

    // If tags are specified
    if(tags != null) {
      params.add("tags=${tags.split(' ').join('+')}");
    }

    // Add params if any are required
    if(params.length > 0) {
      url += "&" + params.join("&");
    }

    // Do our web request
    var response = await http.get(url, headers: Utils.getHeaders());

    // Make sure the request went well
    if(response.statusCode == 200) {
      // Decode the json
      var postsJson = jsonDecode(response.body);

      // Create our list of posts
      return postsJson.map<Post>((json) => Post.fromJson(json)).toList();
    } else {
      throw("Error");
    }
  }
}