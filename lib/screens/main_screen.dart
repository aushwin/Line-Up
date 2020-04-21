import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:line_up/constants.dart';

bool checkMark = false;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List todos = List();

  @override
  void initState() {
    super.initState();
    todos.add('Go get Some Work Done');
    todos.add('Water the plants');
    todos.add('Complete Journel');
    todos.add('Read the remaing novel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildCurvedNavigationBar((value) {
        final popup = BeautifulPopup(
          context: context,
          template: TemplateThumb,
        );
        popup.show(
          title: 'Add Todo',
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'add ToDo Here',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.red.shade900,
                    ),
                  ),
                  prefixIcon: Icon(Icons.check),
                  filled: true,
                  fillColor: Colors.redAccent,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
          actions: [
            popup.button(label: 'Add', onPressed: () {}),
            popup.button(
              label: 'Close',
              onPressed: Navigator.of(context).pop,
            ),
          ],
          // bool barrierDismissible = false,
          // Widget close,
        );
      }),
      backgroundColor: Color(kRedAccentCostum),
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text('Line up'),
        ),
        backgroundColor: Colors.redAccent.shade400,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                'Juzo Susumiya',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              leading: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://cdn4.vectorstock.com/i/1000x1000/64/83/web-developer-avatar-vector-25996483.jpg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    leading: Text(
                      'Today\'s Goal',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '3',
                      style: TextStyle(color: Color(kRedDark), fontSize: 30),
                    )),
                //creating list view
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          key: Key(todos[index]),
                          child: Container(
                            height: 55,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Color(kRedDark),
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  child: Text(
                                    todos[index],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
