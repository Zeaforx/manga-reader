import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:manga/class/chapList.dart';
import 'package:manga/class/imageList.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'imageViewer.dart';


class MangaPage extends StatefulWidget {
  const MangaPage({super.key});

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {

  Map parameters = {};
  WebViewController? _controller;
  List<String> images = [];
  String temp = "";
  final _formglobalKey = GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    // getWebData();
    // getImages(parameters["link"]);


  }
  void getwebd(String rawHtml) {
    dom.Document html = parse(rawHtml);
    final getImage = html.querySelectorAll("div > img")
            .map((element) => element.attributes["data-src"])
            .where((src) => src != null) // Filter out null values
            .cast<String>()
            .toList();
    final temp1 = html.querySelector("#page1 > img")?.attributes["data-src"];
    print(temp1);
    for (final a in getImage) {
      debugPrint(a);
    }
    setState(() {
      images = getImage;
      temp = temp1??"";
    });
  }
  @override
  Widget build(BuildContext context) {
      // boolean flag = false;

      final args = ModalRoute.of(context)!.settings.arguments as Map;
      String link = args["link"];
      List<ChapList> chapList = args["chapList"];
      int currentIndex = args["currentIndex"];
      bool prevCheck() {

        int nextIndex = currentIndex+1;
        print(chapList[currentIndex]);
        if (nextIndex >= 0 && nextIndex < chapList.length){
          return true;
        }
        else {
          return false;
        }

      }
      bool nextCheck() {

        int prevIndex = currentIndex-1;
        print(chapList[currentIndex]);
        if (prevIndex >= 0 && prevIndex < chapList.length){
          return true;
        }
        else {
          return false;
        }

      }
      print("the bad guys: ${nextCheck()}");
    return Scaffold(
      appBar: AppBar(
        leading: Offstage(
          offstage: true,
          child: WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            onPageFinished: (_) async {
              // When the page is fully loaded, inject JS to grab image URLs
              final html = await _controller?.runJavascriptReturningResult("new XMLSerializer().serializeToString(document)");
              getwebd(jsonDecode(html!));


            },
          ),
        ),
        title: SizedBox(
          width: double.infinity,
          child: DropdownButton<String>(

            value: chapList[currentIndex].chapName,
            items: chapList.map((chap) {
              return DropdownMenuItem(
                value: chap.chapName,
                child: Text(chap.chapName),
              );
            }).toList(),
            onChanged: (newValue) {
              int index = chapList.indexWhere((chap) => chap.chapName == newValue);
              Navigator.pushReplacementNamed(context, "/mangaPage", arguments: {
                'link': chapList[index].chapLink,
                "name": chapList[index].chapLink,
                "chapList": chapList,
                "currentIndex": index,
              });
            },
            onTap: () {
              // int dropdownIndex = chapList.map(toElement)
            },
          ),
        ),

        actions: [
        ],
        // actions: [
          // Form(
          //   key: _formglobalKey,
          //     child: DropdownButtonFormField(
          //     items: chapList.map((chap) {
          //       return DropdownMenuItem(child: Text(chap.chapName))
          //
          // }).toList(), 
          //         onChanged: () {}))

        // ],
      ),
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(

                ),
                child: prevCheck() ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/mangaPage", arguments: {
                      'link': chapList[currentIndex+1].chapLink,
                      "name": chapList[currentIndex+1].chapLink,
                      "chapList": chapList,
                      "currentIndex": currentIndex+1,
                    });
                  },
                  child: Text("prev"),
                ) :
                null),
            Expanded(child: Container()),
            Container(
                width: 100,
                height: 50,
                child: nextCheck() ?
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/mangaPage", arguments: {
                      'link': chapList[currentIndex-1].chapLink,
                      "name": chapList[currentIndex-1].chapName,
                      "chapList": chapList,
                      "currentIndex": currentIndex-1,
                    });
                  },
                  child: Text("next"),): null),
          ],
        ),
      ),

      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: images.isNotEmpty ? Imageviewer(images: images) :  Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
