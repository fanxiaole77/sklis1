import 'package:flutter/material.dart';
class wzcotnett extends StatefulWidget {
  final String image;

  wzcotnett({required this.image});
  @override
  _wzcotnettState createState() => _wzcotnettState(image);
}

class _wzcotnettState extends State<wzcotnett> {

  final String image;

  _wzcotnettState(this.image);

  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("违章图片详情"),
        centerTitle: true,
      ),
      body: Center(
       child: ZoomableImage(imageUrl: image),
      ),
    );
  }
}



class ZoomableImage extends StatefulWidget {
  final String imageUrl;

  ZoomableImage({required this.imageUrl});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = details.scale;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: Image.asset(widget.imageUrl),
      ),
    );
  }
}
