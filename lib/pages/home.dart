/*
  SeaSalt's home page, basically just a feed filled with yiff
  By @ZoeyLovesMiki, 2019
*/

/* Imports */
import "package:flutter/material.dart";
import 'package:seasalt/api/posts.dart';
import 'package:seasalt/models/post.dart';
import 'package:seasalt/widgets/post.dart';

/* Homepage class */
class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Listen to scrolling in our listview
  ScrollController controller;

  // Are we loading?
  bool isLoading = true;

  // List of posts
  List<Post> posts = new List<Post>();

  // Our search tags
  String tags = "";

  @override 
  void initState() {
    super.initState();
    _fetchPosts();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /* Handles loading more posts when almost scrolled all the way down */
  void _scrollListener() {
    if (controller.position.extentAfter < 500 && !isLoading) {
      setState(() {
        this.isLoading = true;
      });

      _fetchPosts(loadMore: true);
    }
  }

  /* Used to fetch our Posts from API */
  Future<void> _fetchPosts({bool loadMore = false}) async {
    Posts.list(
      beforeID: loadMore ? posts.last.id.toString() : null, tags: tags.length > 0 ? tags : null).then((posts) {
      setState(() {
        this.posts.addAll(posts);
        this.isLoading = false;
      });
    }).catchError((error) {
      print(error);
    });
  }

  /* Generate a nice looking listview with our posts */
  Widget _buildPostsList() {
    if(posts.length > 0) {
      return ListView.builder(controller: controller, itemCount: posts.length, itemBuilder: (context, index) {
        return PostCard(post: posts[index],);
      });
    } else if(posts.length == 0 && isLoading == false) {
      return Center(
        child: Text("No posts were found."),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  /* Open a dialog for search */
  void _openSearch() {
    // Key for our form
    final _formKey = GlobalKey<FormState>();

    // Open a dialog asking for tags
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Search for tags'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            autocorrect: false,
            autofocus: true,
            initialValue: tags.length > 0 ? tags.split("+").join(" ") : "",
            decoration: InputDecoration(
              hintText: 'Isabelle_(animal_crossing)'
            ),
            onSaved: (String value) {
              // Our new tags
              String _newTags = value.trim().length > 0 ? value.trim().split(" ").join("+").trim() : "";

              // Update our state
              setState(() {
                this.tags = _newTags;
                this.posts.clear();
                this.isLoading = true;
              });

              // Close the dialog
              Navigator.of(context).pop();

              // Fetch posts again
              _fetchPosts();
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              // Close our dialog
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Clear'),
            onPressed: () {
              // Reset our tags and posts list
              setState(() {
                this.tags = "";
                this.posts.clear();
                this.isLoading = true;
              });

              // Close the dialog
              Navigator.of(context).pop();

              // Fetch posts again
              _fetchPosts();
            },
          ),
          FlatButton(
            child: Text('Search'),
            onPressed: () {
              _formKey.currentState.save();
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            controller.jumpTo(0);
          },
          child: Text("Home")
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _openSearch,
          )
        ],
      ),
      drawer: Drawer(
        child: Center(
          child: Text("Why my pp hurt")
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            this.posts.clear();
            this.isLoading = true;
          });

          return _fetchPosts();
        },
        child: _buildPostsList()
      )
    );
  }
}