import 'package:flutter/material.dart';
import 'class/searchList.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchList> searchlist = [];
  SearchList temp = SearchList(
      title: "title",
      description: "Description",
      uriImage: "uriImage",
      uriLink: "uriLink");
  final _formGlobalKey = GlobalKey<FormState>();
  String _searchValue = "";

  @override
  Widget build(BuildContext context) {
    void getSearch(String param) async {
      List<SearchList> temp2 = await temp.getWebData(param);
      for (var i = 0; i < temp2.length; i++) {
        print(temp2[i].uriImage);
        print(temp2[i].uriLink);
      }
      setState(() {
        searchlist = temp2;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Column(
        children: [
          Form(
              key: _formGlobalKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                        onChanged: (newValue) {},
                        decoration: const InputDecoration(
                            labelText: "Search",
                            suffixIcon: Icon(Icons.search)),
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Input more than 4 charcters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _searchValue = value!;
                        }),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          getSearch(_searchValue);
                        }
                      },
                      child: Text("data"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: ListView.builder(
                // itemCount: 3,
                itemCount: 3,
                itemBuilder: (context, index) {
                  SearchList searchElement = searchlist[index];
                  return InkWell(
                    onTap: () {
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pushNamed(context, "/mangadetails", arguments: {
                          'link': searchElement.uriLink,
                          "title": searchElement.title,

                        });
                      });


                    },
                    child: ListTile(
                      title: Text(
                        searchElement.title,
                        style: TextStyle(),
                        maxLines: 2,
                      ),
                      subtitle: Text(searchElement.description, maxLines: 2,),
                      leading: Image.network(searchElement.uriImage),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
