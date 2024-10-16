import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;

class Article {
  Article({required this.title, required this.Description, required this.uriImage, required this.uriLink});
   String title;
   String Description;
   String uriImage;
   String uriLink;

  Future<List<Article>> getWebData() async{
    final url = Uri.parse("https://mangakatana.com/");
    final response = await http.get(url);


    dom.Document html = dom.Document.html(response.body);
    final titles = html
        .querySelectorAll("#book_list > div > div.text > h3 > a")
        .map((element) => element.text)
        .toList();
    final urilinks = html
        .querySelectorAll("#book_list > div > div.text > h3 > a")
        .map((element) => element.attributes["href"])
        .toList();
    final uriimage = html
        .querySelectorAll("#book_list > div > div.media > div.wrap_img > a > img")
        .map((element) => element.attributes["src"])
        .toList();
    final description = html
        .querySelectorAll("#book_list > div > div.text > div.summary")
        .map((element) => element.innerHtml.trim())
        .toList();
    // print(description.length);
    // for (final title in titles) {
    //   // articles.addAll(title);
    //   debugPrint(title);
    // }
    int counter = -1;
    print(counter++);
    List<Article> articles = List.generate(titles.length, (index) => Article(
     title: titles[index],
     Description: description[index],
     uriImage: uriimage[index] ?? "",
     uriLink: urilinks[index] ?? "",
    ));
    int count = -1;
    print(count++);
    return articles;




  }
  int melt() {
   print("smth");
   return 5;
  }
}