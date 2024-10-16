import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;

class ImageList {
    String images;
    ImageList({required this.images});

    void getImages(String link) async{
        final url = Uri.parse(link);
        final response = await http.get(url);


        dom.Document html = dom.Document.html(response.body);
        final getImages = html
            .querySelectorAll("#page1 > img")
            .map((element) => element.attributes["src"] ?? "")
            .toList()
        ;
        // ImageList(images: getImages??["", ""])
        // images = getImages ;
    }
}