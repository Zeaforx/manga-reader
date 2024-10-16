import 'package:flutter/material.dart';
import 'package:manga/class/chapList.dart';


class Imageviewer extends StatefulWidget {
  const Imageviewer({required this.images, super.key});
  final images;

  @override
  State<Imageviewer> createState() => _ImageviewerState();
}

class _ImageviewerState extends State<Imageviewer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            final image = widget.images[index];
            return Container(
              width: double.infinity,
              // child: Text("lists ${image}"),
              child: Image.network(image),
            ); // Display the extracted images
          },
        ),
      ),
    );
  }
}
