/*
  Fullscreen viewer for posts
  By @ZoeyLovesMiki, 2019
*/

/* Imports */
import "package:flutter/material.dart";
import "package:seasalt/models/post.dart";
import 'package:photo_view/photo_view.dart';
import "package:cached_network_image/cached_network_image.dart";

/* Our page class */
class ViewerPage extends StatefulWidget {
  final Post post;
  final bool pressView;

  ViewerPage({Key key, this.post, this.pressView}) : super(key : key);

  @override
  ViewerPageState createState() => ViewerPageState();
}

class ViewerPageState extends State<ViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        onLongPress: () {
          
        },
        child: PhotoView(
          heroTag: widget.post.id,
          imageProvider: CachedNetworkImageProvider(widget.post.fileUrl),
        )
      )
    );
  }
}