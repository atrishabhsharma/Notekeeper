import 'package:flutter/material.dart';


class NoteDetail extends StatefulWidget {
  final String
      appBarTitle; // string variable to store title (put final its due tu immutablity porblem)

  NoteDetail(
      this.appBarTitle); // constructor with is taking the value of title bar

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  String appBarTitle; // varialble

  TextEditingController titleController =
      TextEditingController(); // that can be changed
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.appBarTitle); // constructor for title value

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title; // text style for whole code base

    return WillPopScope(

      onWillPop: () {

         moveToLastScreen();
        return ;
    
      },
        
      child:Scaffold(
          appBar: AppBar(
              title: Text(appBarTitle), // title value
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    moveToLastScreen();   //////////// for back arrow button on appbar
                  }
                  )
                  ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // First element
                ListTile(
                  // tile in list
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: textStyle,
                      value: 'Low',
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('User selected $valueSelectedByUser');
                        });
                      }),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      // first button
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                            });
                          },
                        ),
                      ),

                      Container(
                        width: 5.0,
                      ),

                      //second button

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
