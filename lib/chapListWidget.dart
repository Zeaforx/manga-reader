import 'package:flutter/material.dart';
import 'package:manga/class/chapList.dart';

class Chaplistwidget extends StatefulWidget {
  const Chaplistwidget({required this.chaplist, super.key});
  final List<ChapList> chaplist;

  @override
  State<Chaplistwidget> createState() => _ChaplistwidgetState();
}

class _ChaplistwidgetState extends State<Chaplistwidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 600,

        decoration: BoxDecoration(
          // color: Colors.blue
        ),
        child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: widget.chaplist.length,
            itemBuilder: (count, index) {
              final currentlist = widget.chaplist[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: Material(
                  color: Colors.blue[200],
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/mangaPage", arguments: {
                        'link': currentlist.chapLink,
                        "name": currentlist.chapName,
                        "chapList": widget.chaplist,
                        "currentIndex": index,
                      });
                    },
                    splashColor: Colors.grey,
                    child: ListTile(

                      title: Text(currentlist.chapName),
                    ),
                  ),
                ),
              );

            }),
      ),
    );
  }
}
