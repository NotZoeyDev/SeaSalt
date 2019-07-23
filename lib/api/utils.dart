/*
  Constant values and such
  By @ZoeyLovesMiki, 2019
*/

class Utils {
  /*
    Get e621"s base url
  */
  static String getBaseURL() {
    return "https://e621.net";
  }

  /*
    Headers for request
  */
  static Map<String, String> getHeaders() {
    return {
      "User-Agent": "SealSalt/1.0 (by @ZoeyLovesMiki)"
    };
  }
}