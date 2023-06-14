import 'package:flutter/material.dart';
import 'package:habit_speed_code/pages/catatan.dart';
import 'package:habit_speed_code/pages/create.dart';
import '../services.dart/lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  var db = FirebaseFirestore.instance;

  void saveMoodToFirebase(String title, String subtitle, String trailing) {
    Map<String, dynamic> moodData = {
      'title': title,
      'subtitle': subtitle,
      'trailing': trailing,
    };

// Add a new document with a generated ID
    db.collection("users").add(moodData).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 170, 189),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(children: [
                Image.asset('assets/progressPageBackground.png'),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: const [
                      Text(
                        "Hey Imam !",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Check Your Moods !",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ]),
                  ),
                )
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              // ignore: prefer_const_literals_to_create_immutables
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Best Moods This Week",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),

              // ignore: prefer_const_literals_to_create_immutables
              child: Column(children: [
                ListTile(
                  leading: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 7.5,
                    backgroundColor: Colors.greenAccent,
                    value: 1,
                  ),
                  title: Text(
                    "JOYFUL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Intense positive emotion, feeling delighted and elated",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.sentiment_very_satisfied),
                  onTap: () {
                    saveMoodToFirebase(
                      "JOYFUL",
                      "Intense positive emotion, feeling delighted and elated",
                      "Icon(Icons.sentiment_very_satisfied)",
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 7.5,
                    backgroundColor: Colors.greenAccent,
                    value: 0.75,
                  ),
                  title: Text(
                    "GOOD",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Positive emotional state, feeling content and satisfied",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.sentiment_satisfied),
                  onTap: () {
                    saveMoodToFirebase(
                      "GOOD",
                      "Positive emotional state, feeling content and satisfied",
                      "Icon(Icons.sentiment_satisfied)",
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 7.5,
                    backgroundColor: Colors.greenAccent,
                    value: 0.50,
                  ),
                  title: Text(
                    "NEUTRAL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Lack of strong emotional response, feeling indifferent and uninvolved",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.sentiment_neutral),
                  onTap: () {
                    saveMoodToFirebase(
                      "MOODY",
                      "Lack of strong emotional response, feeling indifferent and uninvolved",
                      "Icon(Icons.sentiment_neutral)",
                    );
                  },
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 15, 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Worst Moods This Week",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Merriweather',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),

              // ignore: prefer_const_literals_to_create_immutables
              child: Column(children: [
                ListTile(
                  leading: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 7.5,
                    backgroundColor: Color.fromARGB(255, 226, 125, 118),
                    value: 0.35,
                  ),
                  title: Text(
                    "MOODY",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Fluctuating emotional state, feeling temperamental and unpredictable",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.sentiment_dissatisfied),
                  onTap: () {
                    saveMoodToFirebase(
                      "MOODY",
                      "Fluctuating emotional state, feeling temperamental and unpredictable",
                      "Icon(Icons.sentiment_dissatisfied)",
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 7.5,
                    backgroundColor: Color.fromARGB(255, 226, 125, 118),
                    value: 0.20,
                  ),
                  title: Text(
                    "UNHAPPY",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Negative emotional state, feeling sad and dissatisfied",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.sentiment_very_dissatisfied),
                  onTap: () {
                    saveMoodToFirebase(
                      "UNHAPPY",
                      "Negative emotional state, feeling sad and dissatisfied",
                      "Icon(Icons.sentiment_very_dissatisfied)",
                    );
                  },
                ),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "tag1",
        onPressed: () {
          // Navigasi ke halaman ProfilePage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CatatanPage()),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
