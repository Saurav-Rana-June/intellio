import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerWidget extends StatefulWidget {
  final String imageUrl;

  const ImageViewerWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageViewerWidget> createState() => _ImageViewerWidgetState();
}

class _ImageViewerWidgetState extends State<ImageViewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: PhotoView(
            minScale: PhotoViewComputedScale.contained * 1.0, 
            imageProvider: NetworkImage(widget.imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
