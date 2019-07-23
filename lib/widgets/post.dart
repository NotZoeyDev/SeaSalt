/*
  Cards for posts
  By @ZoeyLovesMiki, 2019
*/

/* Imports */
import "package:flutter/material.dart";
import "package:seasalt/models/post.dart";
import "package:seasalt/pages/viewer.dart";
import "package:cached_network_image/cached_network_image.dart";

/* Our card */
class PostCard extends StatefulWidget {
  // Our post object
  final Post post;

  PostCard({Key key, this.post}) : super(key: key);

  @override
  PostCardState createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewerPage(post: widget.post)));
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                  ),
                  child: Stack(
                    children: <Widget> [
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                            child: Hero(
                            tag: widget.post.id,
                            child: Image(image: new CachedNetworkImageProvider(widget.post.fileUrl), fit: BoxFit.cover)
                          )
                        )
                      ),
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: GestureDetector(
                          onTap: () {
                            
                          },
                          child: Icon(Icons.star_border, color: Colors.orange, size: 24.0,)
                        ),
                      )
                    ]
                  )
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.arrow_upward),
                        onTap: () {

                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(widget.post.score.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_downward),
                        onTap: () {

                        },
                      ),
                    ]
                  )
                ),
              )
            ],
          )
        )
    );
  }
}