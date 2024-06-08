import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practical080624/widgets/listSelection.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController inputFied = TextEditingController();
  TextEditingController dateField = TextEditingController();
  DateTime? selectedDate;
  String dropdownValue = 'Option 1';
  String? selectedGrid='Item 1';
  List selectedListItems = [];
  dynamic surveyList=[];
  var dataItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  var gridItems = ['Item 1', 'Item 2', 'Item 3'];

  var listItems = ['List 1', 'List 2', 'List 3'];

  clearform(){
    inputFied.clear();
    dateField.clear();
    selectedListItems=[];
    selectedGrid='Item 1';
    setState(() {
      
    });
  }

  Widget gridSelection() {
    return GridView.builder(
      itemCount: gridItems.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 9,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedGrid = gridItems[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                    width: 2.0,
                    color: selectedGrid == gridItems[index]
                        ? Colors.black
                        : Colors.amber)),
            // color: Colors.amber[100],
            height: 50,
            width: 50,
            child: Center(child: Text(gridItems[index])),
          ),
        );
      },
    );
  }

  selecteDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2025));
    if (selectedDate != null) {
      setState(() {
        String formateDate=DateFormat.yMd().format(selectedDate!);
        dateField.text = formateDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Survey')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                  controller: inputFied,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter something';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter something...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: dateField,
                  readOnly: true,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please selected the date';
                    }
                    return null;
                  },
                  onTap: () {
                    selecteDate(context);
                  },
                  decoration: InputDecoration(
                      hintText: 'Selected Date',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: dropdownValue,
                items: dataItems.map((String dataItems) {
                  return DropdownMenuItem(
                      value: dataItems, child: Text(dataItems));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
              Container(height: 140, child: gridSelection()),
              ListSelection(listItems: listItems,selectedListItems: selectedListItems,),
      
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      // side: BorderSide(width: 5)
                    ),
                    onPressed: () {
                      if(formKey.currentState!.validate() && selectedListItems.isNotEmpty){
                       Map<String,dynamic>surveyData={
                        'text':inputFied.text,
                        'date':selectedDate,
                        'dropdownValue':dropdownValue,
                        'gridOption':selectedGrid,
                        'listOption':selectedListItems
                       };

                       surveyList.add(surveyData);
                       log('survey listing ${surveyList}');
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Survey submitted successfully...'),backgroundColor: Colors.green,));
                       clearform();
                       

                      }
                    },
                    child: Text('Submit')),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
