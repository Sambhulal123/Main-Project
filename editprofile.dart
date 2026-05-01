import 'dart:convert';
import 'dart:io';
import 'package:cyber_bullying/viewprofilenew.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewProfilePage(title: 'Profile'),
            ));
        return false;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyEditProfilePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyEditProfilePage extends StatefulWidget {
  const MyEditProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  _MyEditProfilePageState() {
    send_data();
  }

  String upic = "";
  String gender = 'Male';
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController postcontroller = TextEditingController();
  TextEditingController placeconrtoller = TextEditingController();

  TextEditingController dobcontroller = TextEditingController();

  void send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String post = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String image = sh.getString("img_url").toString() +
              jsonDecode(response.body)['image'];

          setState(() {
            namecontroller.text = name;
            dobcontroller.text = dob;
            gender = gender;
            emailcontroller.text = email;
            phonecontroller.text = phone;
            placeconrtoller.text = place;
            postcontroller.text = post;
            pincontroller.text = pin;
            upic = image;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              if (_selectedImage != null) ...{
                InkWell(
                  child: Image.file(
                    _selectedImage!,
                    height: 400,
                  ),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(upic),
                        height: 200,
                        width: 200,
                      ),
                      Text('Select Image', style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: phonecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'phone'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: pincontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'pin'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: postcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'post'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: placeconrtoller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'place'),
              ),
              SizedBox(
                height: 20,
              ),
              RadioListTile(
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Male";
                  });
                },
                title: Text("Male"),
              ),
              RadioListTile(
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Female";
                  });
                },
                title: Text("Female"),
              ),
              RadioListTile(
                value: "Other",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Other";
                  });
                },
                title: Text("Other"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: dobcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'dob'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _send_data();
                  },
                  child: Text('update'))
            ],
          ),
        ),
      ),
    );
  }

  // String name_="";
  // String dob_="";
  // String gender_="";
  // String email_="";
  // String phone_="";
  // String place_="";
  // String post_="";
  // String pin_="";
  // String photo_="";

  void _send_data() async {
    String name = namecontroller.text;
    String email = emailcontroller.text;
    String phone = phonecontroller.text;
    // String image = imagecontroller.text;
    String pin = pincontroller.text;
    String post = postcontroller.text;
    String place = placeconrtoller.text;
    String gender = '';
    String dob = dobcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofileandeditprofile/');
    try {
      final response = await http.post(urls, body: {
        'name': name,
        'email': email,
        'dob': dob,
        'place': place,
        'gender': gender,
        'phone': phone,
        'image': photo,
        'pin': pin,
        'post': post,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewProfilePage(title: "Home"),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String photo = '';
  File? _selectedImage;
  String? _encodedImage;

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

// String photo = "";
}
