/*
  Post model for e621
  By @ZoeyLovesMiki, 2019
*/

class Post {
  int id;
  String tags;
  String description;
  int createdAt;
  int creatorId;
  String author;
  String source;
  int score;
  int favCount;
  String fileUrl;
  String fileExt;
  String previewUrl;
  String sampleUrl;
  String rating;
  String children;
  List<dynamic> artist;
  List<dynamic> sources;

  Post({
    this.id,
    this.tags,
    this.description,
    this.createdAt,
    this.creatorId,
    this.author,
    this.source,
    this.score,
    this.favCount,
    this.fileUrl,
    this.fileExt,
    this.previewUrl,
    this.sampleUrl,
    this.rating,
    this.children,
    this.artist,
    this.sources,
  });

  factory Post.fromJson(Map<String, dynamic> postJson) {
    return Post(
      id: postJson['id'],
      tags: postJson['tags'],
      description: postJson['description'],
      createdAt: postJson['created_at']['s'],
      creatorId: postJson['creator_id'],
      author: postJson['author'],
      source: postJson['source'],
      score: postJson['score'],
      favCount: postJson['fav_count'],
      fileUrl: postJson['file_url'],
      fileExt: postJson['file_ext'],
      previewUrl: postJson['preview_url'],
      sampleUrl: postJson['preview_url'],
      rating: postJson['rating'],
      children: postJson['children'],
      artist: postJson['artist'],
      sources: postJson['sources']
    );
  }
}