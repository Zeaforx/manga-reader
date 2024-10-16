// import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;

class ChapList {
    String chapName;
    String chapLink;
    ChapList({required this.chapLink, required this.chapName});


    Future<List<ChapList>> seterWebData( String link ) async{
        final url = Uri.parse(link);
        final response = await http.get(url);


        dom.Document html = dom.Document.html(response.body);

        final getChapName = html
            .querySelectorAll("#single_book > div.chapters > table > tbody > tr > td > div > a")
            .map((element) => element.innerHtml.trim())
            .toList();
        final getChapLink = html
            .querySelectorAll("#single_book > div.chapters > table > tbody > tr > td > div > a")
            .map((element) => element.attributes["href"]!)
            .toList();
        print(chapLink.length);
        print(chapName.length);
        for (final title in getChapName) {
            // articles.addAll(title);
            debugPrint(title);
        };




        List<ChapList> list = List.generate(getChapName.length, (index) => ChapList(
          chapLink: getChapLink[index],
          chapName: getChapName[index]

        ));
        return list;
  }
}