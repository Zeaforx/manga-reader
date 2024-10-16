import "package:html/dom.dart" as dom;
import "package:http/http.dart" as http;

class SearchList {
  SearchList({required this.title, required this.description, required this.uriImage, required this.uriLink});
  String title;
  String description;
  String uriImage;
  String uriLink;
  Future<List<SearchList>> getWebData(searchParam) async{
    final url = Uri.parse("https://mangakatana.com/?search=${searchParam}&search_by=book_name");
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
    //   // Searchs.addAll(title);
    //   debugPrint(title);
    // }
    int counter = -1;
    print(counter++);
    List<SearchList> searchs = List.generate(titles.length, (index) => SearchList(
      title: titles[index],
      description: description[index],
      uriImage: uriimage[index] ?? "",
      uriLink: urilinks[index] ?? "",
    ));
    int count = -1;
    print(count++);
    return searchs;




  }
}