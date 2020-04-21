import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:line_up/constants.dart';
import 'package:line_up/screens/login_screen.dart';
import 'package:quotes/quotes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool checkMark = false;
String input = '';
int todosSize;
UserDetails userGlobal;

class MainScreen extends StatefulWidget {
  MainScreen({this.user});
  final UserDetails user;
  @override
  _MainScreenState createState() => _MainScreenState();
}

createToDos() {
  DocumentReference documentReference =
      Firestore.instance.collection("${userGlobal.userEmail}").document(input);

  //map
  Map<String, String> todos = {
    'todosTitle': input,
  };
  documentReference.setData(todos).whenComplete(() => print("Input created"));
}

deleteToDos(item) {
  DocumentReference documentReference =
      Firestore.instance.collection("${userGlobal.userEmail}").document(item);
  documentReference.delete().whenComplete(() => print("deleted"));
}

class _MainScreenState extends State<MainScreen> {
  List todos = List();

  @override
  void initState() {
    super.initState();
    todosSize = todos.length + 1;
    userGlobal = widget.user;
    Firestore.instance
        .collection('${userGlobal.userEmail}')
        .document('default')
        .setData({'todosTitle': 'Add your todo here'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: buildCurvedNavigationBar(
          (value) {
            if (value == 2) {
              Navigator.pop(context);
            } else if (value == 1) {
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
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: buildInputDecoration(),
                      onChanged: (value) => input = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Quotes.getRandom().getContent(),
                      style: TextStyle(color: Colors.white, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  popup.button(
                      label: 'Add',
                      onPressed: () {
                        setState(() {
                          createToDos();
                        });
                        Navigator.pop(context);
                      }),
                  popup.button(
                    label: 'Close',
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
                // bool barrierDismissible = false,
                // Widget close,
              );
            }
          },
        ),
        backgroundColor: Color(kRedAccentCostum),
        appBar: AppBar(
          title: Title(
            color: Colors.white,
            child: Text('Line up'),
          ),
          backgroundColor: Colors.redAccent.shade400,
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('${userGlobal.userEmail}')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        '${userGlobal.userName}',
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
                        backgroundImage: NetworkImage('${userGlobal.photoUrl}'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    child: Expanded(
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
                          ),
                          //creating list view
                          Container(
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, int index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data.documents[index];
                                  print(documentSnapshot.data[index]);
                                  return Dismissible(
                                    onDismissed: (direction) {
                                      setState(() {
                                        deleteToDos(
                                            documentSnapshot['todosTitle']);
                                        todos.remove(todos[index]);
                                        todosSize = todos.length;
                                      });
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text("$todos dismissed")));
                                    },
                                    key: UniqueKey(),
                                    child: Container(
                                      height: 55,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Color(kRedDark),
                                        child: ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10, left: 10),
                                            child: Text(
                                              documentSnapshot
                                                  .data['todosTitle'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
