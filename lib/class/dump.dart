final urilinks = html
    .querySelectorAll("#single_book > div.chapters > table > tbody > tr > td > div > a")
    .map((element) => element.attributes["href"])
    .toList();
final uriimage = html
    .querySelectorAll("#single_book > div.d-cell-medium.media > div > img")
    .map((element) => element.attributes["src"])
    .toList();
final description = html.querySelector("#single_book > div.summary > p")?.innerHtml.trim();
// .map((element) => element.innerHtml.trim());
print(description);
final genre = html
    .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li:nth-child(3) > div.d-cell-small.value > div > a")
    .map((element) => element.innerHtml.trim())
    .toList();
final status = html
    .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li:nth-child(4) > div")
    .map((element) => element.className)
    .toList();
// print(description.length);
// for (final title in description) {
//   // articles.addAll(title);
//   debugPrint(title);
// }


// setState(() {
//   details = List.generate(titles.length, (index) => Details(
//     title: titles[index],
//     Description: description[index],
//     uriImage: uriimage[index] ?? "",
//     author: urilinks[index] ?? "",
//     genre:  genre[index] ?? "",
//     status: status[index] ?? '',
//   ));
// });
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
class Details {
  Details({required this.url
  });
  late String title;
  late String Description;
  late String uriImage;
  late String author;
  late List<String> genre;
  late String status;
  late String url;
  Future<Details> getdata() async{

    final url = Uri.parse(this.url);
    final response = await http.get(url);


    dom.Document html = dom.Document.html(response.body);
    final title = await html
        .querySelector("#single_book > div.d-cell-medium.text > div > h1")?.text;
    final image = html
        .querySelector("#single_book > div.d-cell-medium.media > div > img")?.attributes["src"];
    final description = html
        .querySelector("#single_book > div.summary > p")?.text;
    final author = html
        .querySelector("#single_book > div.d-cell-medium.text > div > ul > li:nth-child(2) > div.d-cell-small.value.authors > a")?.text;
    final genre = html
        .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li:nth-child(3) > div.d-cell-small.value > div > a")
        .toList();

    final status = html
        .querySelector("#single_book > div.d-cell-medium.text > div > ul > li:nth-child(4) > div")?.text;
    // print(titles);



    return Details(title: title??'', Description: description??'', uriImage: image??'', author: author??"", genre: [], status: status??""
      // title: map['title'],
      // notes: map['notes'],
    );
  }
}

// Future getWebData() async{
//   final url = Uri.parse("https://mangakatana.com/");
//   final response = await http.get(url);
//
//
//   dom.Document html = dom.Document.html(response.body);
//   final titles = html
//       .querySelectorAll("#book_list > div > div.text > h3 > a")
//       .map((element) => element.text)
//       .toList();
//   final urilinks = html
//       .querySelectorAll("#book_list > div > div.text > h3 > a")
//       .map((element) => element.attributes["href"])
//       .toList();
//   final uriimage = html
//       .querySelectorAll("#book_list > div > div.media > div.wrap_img > a > img")
//       .map((element) => element.attributes["src"])
//       .toList();
//   final description = html
//       .querySelectorAll("#book_list > div > div.text > div.summary")
//       .map((element) => element.innerHtml.trim())
//       .toList();
//   // print(description.length);
//   // for (final title in description) {
//   //   // articles.addAll(title);
//   //   debugPrint(title);
//   // }
//
//
//   setState(() {
//     articles = List.generate(titles.length, (index) => Article(
//       title: titles[index],
//       Description: description[index],
//       uriImage: uriimage[index] ?? "",
//       uriLink: urilinks[index] ?? "",
//     ));
//   });
//
// }
//
// Future<Map<dynamic, dynamic>> getWebData() async{
//   final url = Uri.parse(args["link"]);
//   final response = await http.get(url);
//
//
//   dom.Document html = dom.Document.html(response.body);
//   final title = html
//       .querySelector("#single_book > div.d-cell-medium.text > div > h1")?.text;
//   final image = html
//       .querySelector("#single_book > div.d-cell-medium.media > div > img")?.attributes["src"];
//
//
//   final description = html
//       .querySelector("#single_book > div.summary > p")?.text;
//   final author = html
//       .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.authors > a")
//       .map((element) => element.innerHtml.trim())
//       .toList();
//   // print("author: ${author}");
//   final genre = html
//       .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value > div > a")
//       .map((element) => element.innerHtml.trim())
//       .toList();
//   print(author.length);
//   for (final title in author) {
//     // articles.addAll(title);
//     debugPrint(title);
//   }
//
//   final status = html
//       .querySelector("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.status")?.text;
//   print("status: ${status}");
//
//   // print(titles);
//
//       ;
//   Map<dynamic, dynamic> dataMap = {
//     'title': title??"",
//     'image': image??"",
//     'description': description??"",
//     'author': author??[],
//     'status': status??"",
//     "genre": genre??[],
//   };
//   return dataMap;
// }
// Future tempfxt() async{
//   Map<dynamic, dynamic> temp = await getWebData();
//   setState(() {
//     temp.forEach((key, value) {
//       print("${key} and ${value}");
//       if(key == "genre") {
//         details.genre = value;
//
//       }
//       if(key == "title") {
//         details.title = value;
//       }
//       if(key == "image") {
//         details.uriImage = value;
//       }
//       if(key == "description") {
//         details.Description = value;
//       }
//       if(key == "author") {
//         details.author = value;
//       }
//       if(key == "status") {
//         details.status = value;
//       }
//       if(key == "title") {
//         details.title = value;
//       }
//
//     });
//     print(details.genre);
//     print(details.title);
//     print(details.Description);
//   });
//
// }

ListTile(


// style: ListTileStyle(),
shape: Border(),
leading: Image.network(
article.uriImage,
width: 100,
height: 100,
fit: BoxFit.cover,
),
title: Text(article.title),
subtitle: Text(article.Description,
overflow: TextOverflow.ellipsis,
maxLines: 2,
softWrap: false,
style: const TextStyle( ),),

),

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MangaPage extends StatefulWidget {
@override
_MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
InAppWebViewController? webViewController;
List<String> images = [];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Manga Page"),
),
body: Column(
children: [
Expanded(
child: InAppWebView(
initialUrlRequest: URLRequest(
url: Uri.parse("https://mangakatana.com/manga/usogui.270/c539")),
onWebViewCreated: (controller) {
webViewController = controller;
},
onLoadStop: (controller, url) async {
// Run JavaScript to extract the images once the page is fully loaded
String js = """
                  (function() {
                    let images = document.querySelectorAll("div.wrap_img.uk-width-1-1 > img");
                    let srcList = [];
                    images.forEach(img => {
                      srcList.push(img.getAttribute('data-src'));
                    });
                    return JSON.stringify(srcList);
                  })();
                """;

// Execute the JavaScript and get the list of image URLs
var result = await controller.evaluateJavascript(source: js);

setState(() {
images = List<String>.from(result != null ? result : []);
});

print("Extracted images: $images");
},
),
),
Expanded(
child: ListView.builder(
itemCount: images.length,
itemBuilder: (context, index) {
return Image.network(images[index]); // Display the extracted images
},
),
),
],
),
);
}
}
