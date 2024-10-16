import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
import "package:manga/class/details.dart";
import "class/article.dart";
import "package:manga/mangadetails.dart";
import 'package:go_router/go_router.dart';
import 'mangaPage.dart';
import "search.dart";
void main() {
  runApp(MaterialApp(home: MyApp(),
    routes:
    {
      "/mangadetails": (contex) => const MangaDetails(),
      "/mangaPage": (contex) => const MangaPage(),
      "/search": (contex) => const SearchPage()
    },

  ), );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Article> articles = [];
  Article temp = Article(title: "title", Description: "Description", uriImage: "uriImage", uriLink: "uriLink");
  int _bottomNavIndex = 0;

  @override
  void initState(){
    super.initState();
    // getWebData();
    getterWebData();


  }

  Future getterWebData() async{
    List<Article> temp2 = await temp.getWebData();

    setState(() {
      articles = temp2;
    });



  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Reader"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
            },
          ),
        ],
      ),

      body: ListView.separated(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

            article.getWebData();
            return Material(
              child: InkWell(

                splashColor: Colors.blue.withOpacity(0.5), // Custom splash color
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushNamed(context, "/mangadetails", arguments: {
                      'link': article.uriLink,
                      "title": article.title,

                    });
                  });


                },
                child: ListTile(
                  minTileHeight: 150,
                  shape: Border(),
                  leading: SizedBox(

                    height: 250,
                    width: 152,
                    child: Image.network(
                        article.uriImage,
                        // width: double.infinity,
                        // height: double.infinity,
                        fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(article.title),
                  subtitle: Text(article.Description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: false,
                    style: const TextStyle( ),),
                ),



              ),
            );

          }, separatorBuilder: (BuildContext context, int index) { return Divider(); },),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Boookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Download',
          ),
        ],
      ),
    );
  }
}
