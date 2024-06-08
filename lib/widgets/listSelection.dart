import 'package:flutter/material.dart';

class ListSelection extends StatefulWidget {
  var listItems;
  List selectedListItems;
   ListSelection({super.key,required this.listItems,required this.selectedListItems});

  @override
  State<ListSelection> createState() => _ListSelectionState();
}

class _ListSelectionState extends State<ListSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: widget.listItems.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!widget.selectedListItems.contains(widget.listItems[index])) {
                    setState(() {
                      widget.selectedListItems.add(widget.listItems[index]);
                    });
                  } else {
                    setState(() {
                      widget.selectedListItems.remove(widget.listItems[index]);
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2.0,
                          color: widget.selectedListItems.contains(widget.listItems[index])
                              ? Colors.black
                              : Colors.amber)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20,bottom: 20),
                    child: Text(widget.listItems[index]),
                  ),
                ),
              );
            }),
                    widget.selectedListItems.isEmpty? Text('Please select item',style: TextStyle(color: Colors.red),):SizedBox(),
      ],
    );
  }
}