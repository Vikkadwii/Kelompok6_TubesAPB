import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services.dart/lists.dart';
import 'vidio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  CollectionReference getCollection() {
    FirebaseFirestore myDB = FirebaseFirestore.instance;
    CollectionReference response = myDB.collection("response");
    return response;
  }

  void watch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  void upvideo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFAA9BF),
          title: Text(
            "Hey Allans",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Take A Minute, Calm Down Before Starting The Day Again",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              onPressed: () {
                watch(context);
              },
              child: Text("WATCH"),
            ),
          ],
        );
      },
    );
  }

  void addHabit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFAA9BF),
          title: Text(
            "Hey Allans",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Don't Forget to Report Your Mood Today",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void addresponse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controllerTFresponse = TextEditingController();

        return AlertDialog(
          title: const Text("Tell Me How's your day"),
          content: SizedBox(
            height: 50,
            width: 150,
            child: Column(
              children: [
                TextField(
                  controller: controllerTFresponse,
                  decoration: const InputDecoration(hintText: "ResponHere"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              child: const Text('Save'),
              onPressed: () {
                getCollection().add(
                  {
                    "response": controllerTFresponse.text,
                  },
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.purple,
              child: Icon(Icons.notifications),
              onPressed: () {
                addHabit(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 34),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.purple,
                child: Icon(Icons.video_call),
                onPressed: () {
                  upvideo(context);
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 227, 170, 189),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Image.asset('assets/MainBackground.png'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            "Hey Alllans !",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "You have ${moodList.length - counter} moods left for today",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Life is Going Just Fine !",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${((counter / moodList.length) * 100).round()}%",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        minHeight: 12,
                        color: Color.fromARGB(255, 38, 172, 83),
                        backgroundColor: Color.fromARGB(255, 142, 203, 144),
                        value: (counter / moodList.length),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Divider(),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: moodList.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(moodList[index][1]),
                          subtitle: Text(moodList[index][2]),
                          trailing: moodList[index][3],
                          leading: Checkbox(
                            value: moodList[index][0],
                            onChanged: ((value) {
                              setState(() {
                                if (value == false) {
                                  counter -= 1;
                                  print(counter.toString());
                                  moodList[index][0] = value;
                                } else {
                                  counter += 1;
                                  print(counter.toString());
                                  moodList[index][0] = value;
                                }
                              });
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                      ),
                      onPressed: () {
                        addresponse(context);
                      },
                      child: Text("How's Today ?"),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: getCollection().snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var dataIndex = snapshot.data!.docs[index];
                            return ListTile(
                              title: Text("${dataIndex['response']}",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  )),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
