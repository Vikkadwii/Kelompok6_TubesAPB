import 'package:flutter/material.dart';
import 'package:habit_speed_code/pages/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Judul'),
          TextField(
            controller: judulController,
          ),
          SizedBox(
            height: 15,
          ),
          Text('Isi'),
          TextField(
            controller: isiController,
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                await databaseInstance.insert({
                  'judul': judulController.text,
                  'isi': isiController.text,
                });
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Tambah'))
        ]),
      ),
    );
  }
}
