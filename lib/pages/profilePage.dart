import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? _capturedImage;

  // Data profil pengguna
  String _name = "Allans";
  int _age = 25;
  String _sex = "Male";
  String _city = "New York";
  String _job = "Software Engineer";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize();
    });

    // Mengisi nilai awal controller dengan data profil saat ini
    _nameController.text = _name;
    _ageController.text = _age.toString();
    _sexController.text = _sex;
    _cityController.text = _city;
    _jobController.text = _job;
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _sexController.dispose();
    _cityController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      setState(() {
        _capturedImage = image;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Foto Terambil'),
          content: Image.network(image.path),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                _saveImageToFirebase(image.path);
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _saveImageToFirebase(String imagePath) async {
    try {
      // Membaca file gambar
      File file = File(imagePath);

      // Mendapatkan nama file
      String fileName = file.path.split('/').last;

      // Membuat referensi ke file di Firebase Storage
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      // Mengunggah file ke Firebase Storage
      await ref.putFile(file);

      // Mendapatkan URL unduhan gambar
      String downloadURL = await ref.getDownloadURL();
      print('Download URL: $downloadURL');
    } catch (e) {
      print('Error saving image to Firebase Storage: $e');
    }
  }

  void _saveProfileData() async {
    setState(() {
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text) ?? 0;
      _sex = _sexController.text;
      _city = _cityController.text;
      _job = _jobController.text;
    });

    // Simpan data profil ke Firebase atau database lainnya
    try {
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc('userId')
          .set({
        'name': _name,
        'age': _age,
        'sex': _sex,
        'city': _city,
        'job': _job,
      });
    } catch (e) {
      print('Error saving profile data to Firestore: $e');
    }

    // Menampilkan snackbar untuk memberi tahu pengguna bahwa profil telah disimpan
    final snackBar = SnackBar(content: Text('Profil tersimpan'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(15, 50, 15, 20),
            children: [
              CircleAvatar(
                radius: 150,
                backgroundColor: Color.fromARGB(255, 226, 125, 118),
                backgroundImage: _capturedImage != null
                    ? NetworkImage(_capturedImage!.path)
                    : NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3048/3048127.png',
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 10),
                child: Center(
                  child: Text(
                    "Welcome, $_name!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Take care of your mental health!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Divider(),
              ),
              ListTile(
                leading: Icon(Icons.person_outline,
                    color: Color.fromARGB(255, 226, 125, 118)),
                title: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person_outline,
                    color: Color.fromARGB(255, 226, 125, 118)),
                title: TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: "Age",
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person_outline,
                    color: Color.fromARGB(255, 226, 125, 118)),
                title: TextFormField(
                  controller: _sexController,
                  decoration: InputDecoration(
                    labelText: "Sex",
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.location_on,
                    color: Color.fromARGB(255, 226, 125, 118)),
                title: TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: "City",
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.work_outline,
                    color: Color.fromARGB(255, 226, 125, 118)),
                title: TextFormField(
                  controller: _jobController,
                  decoration: InputDecoration(
                    labelText: "Job",
                  ),
                ),
              ),
              Divider(),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfileData,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 226, 125, 118),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Center(
                child: TextButton(
                  onPressed: (() {
                    print("User logged out");
                  }),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 226, 125, 118),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: "tag3",
              onPressed: () {
                _takePicture();
              },
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
