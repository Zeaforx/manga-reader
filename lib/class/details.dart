import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
class Details {
  Details({required this.title, required this.Description, required this.uriImage, required this.author,
    required this.genre, required this.status
  });

  String title;
  String Description;
  String uriImage;
  List<String> author;
  List<String> genre;
  String status;


  Future<Details> geterWebData( String link ) async{
      final url = Uri.parse(link);
      final response = await http.get(url);


      dom.Document html = dom.Document.html(response.body);
      final gettitle = html
          .querySelector("#single_book > div.d-cell-medium.text > div > h1")?.text;
      final getimage = html
          .querySelector("#single_book > div.d-cell-medium.media > div > img")?.attributes["src"];


      final getdescription = html
          .querySelector("#single_book > div.summary > p")?.text;
      final getauthor = html
          .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.authors > a")
          .map((element) => element.innerHtml.trim())
          .toList();
      final getgenre = html
          .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value > div > a")
          .map((element) => element.innerHtml.trim())
          .toList();


      final getstatus = html
          .querySelector("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.status")?.text;


      title = gettitle!;
      uriImage = getimage!;
      status = getstatus!;
      genre = getgenre;
      author = getauthor;
      Description = getdescription!;

      Map<dynamic, dynamic> dataMap = {
        'title': gettitle??"",
        'image': getimage??"",
        'description': getdescription??"",
        'author': getauthor??[],
        'status': getstatus??"",
        "genre": getgenre??[],
      };
      return Details(
        title: gettitle,
        uriImage: getimage,
        Description: getdescription,
        author: getauthor,
        status: getstatus,
        genre: getgenre,

      );
      // return dataMap;
  }
  Future seterWebData( String link ) async{
    final url = Uri.parse(link);
    final response = await http.get(url);


    dom.Document html = dom.Document.html(response.body);
    final gettitle = html
        .querySelector("#single_book > div.d-cell-medium.text > div > h1")?.text;
    final getimage = html
        .querySelector("#single_book > div.d-cell-medium.media > div > img")?.attributes["src"];


    final getdescription = html
        .querySelector("#single_book > div.summary > p")?.text;
    final getauthor = html
        .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.authors > a")
        .map((element) => element.innerHtml.trim())
        .toList();
    final getgenre = html
        .querySelectorAll("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value > div > a")
        .map((element) => element.innerHtml.trim())
        .toList();


    final getstatus = html
        .querySelector("#single_book > div.d-cell-medium.text > div > ul > li > div.d-cell-small.value.status")?.text;


    title = gettitle!;
    uriImage = getimage!;
    status = getstatus!;
    genre = getgenre;
    author = getauthor;
    Description = getdescription!;


    // return dataMap;
  }
}