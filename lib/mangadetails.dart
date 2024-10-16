import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
import "package:manga/class/article.dart";
import "package:manga/class/chapList.dart";
import "package:manga/class/details.dart";
import 'chapListWidget.dart';
class MangaDetails extends StatefulWidget {
  const MangaDetails({super.key});

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  Details details = Details(title: "title@0", Description: "Description", uriImage: "uriImage", author: [], genre: [], status: "status");
  Details temp = Details(title: "title@0", Description: "Description", uriImage: "uriImage", author: [], genre: [], status: "status");
  List<ChapList> list = [];
  ChapList templist = ChapList(chapLink: "chapLink", chapName: "chapName");
  @override
  void initState(){
    super.initState();
    // getWebData();

  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    String link = args["link"] ;
    Future getterdata() async {
      Details temp1 =  await temp.geterWebData(link) ;
      List<ChapList> temp2 = await templist.seterWebData(link);

      setState(() {
        // details = temp1;
        list = temp2;


        details.seterWebData(link);
      });
    }
    if (details.title == "title@0") {

      getterdata();
      for (final title in list) {
          // articles.addAll(title);
          debugPrint(title.chapLink);
        };

    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Manga Viewer"),
        backgroundColor: Colors.blue,

      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                    color: Colors.blue[200]
            ),

            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  details.uriImage == "uriImage" ? Text("data") : Image.network(details.uriImage),
                  // Image.network(details.uriImage),
                  Text(details.title, style: TextStyle(
                    fontSize: 27,
                  ),),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Row(
                      children: [
                        Text("Author: "),

                        ...details.author.map((string) => Text("${string}, ")).toList(),]


                    ),
                  ),

                  Row(
                      children: <Widget>[
                        Text("Status: ${details.status}"),
                      ]

                  ),
                Expanded(child: Chaplistwidget(chaplist: list,))
                // ListView.builder(
                //     itemCount: list.length,
                //     itemBuilder: (count, index) {
                //       final currentlist = list[index];
                //       return ListTile(
                //         title: Text(currentlist.chapName),
                //       );
                //     })
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
