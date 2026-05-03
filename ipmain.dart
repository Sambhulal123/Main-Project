import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cyber_bullying/Loginmain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

final _formkey = GlobalKey<FormState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Bullying App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
        ),
      ),
      home: const ipmainp(),
    );
  }
}

class ipmainp extends StatefulWidget {
  const ipmainp({super.key});

  @override
  State<ipmainp> createState() => _ipmainpState();
}

class _ipmainpState extends State<ipmainp> {
  TextEditingController ipController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setIp();
  }

  void _setIp() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? savedIp = sh.getString("ip");
    if (savedIp != null && savedIp != "null") {
      setState(() {
        ipController.text = savedIp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0A0E21),
        body: SingleChildScrollView(
          child: Container(
            height: height,
            child: Stack(
              children: [
                // Background Elements
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Main Content
                Column(
                  children: [
                    SizedBox(height: height * 0.15),

                    // Logo/Icon Section
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            Colors.purpleAccent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.dns_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Title Text
                    Text(
                      "Server Configuration",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Enter your server IP address to continue",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 40),

                    // IP Input Form
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            // IP Input Field
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1D1E33),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: TextFormField(
                                controller: ipController,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "192.168.1.100",
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey[500],
                                  ),
                                  prefixIcon: Icon(
                                    Icons.computer_outlined,
                                    color: Colors.grey[500],
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.grey[800]!,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter server IP address';
                                  }
                                  // Basic IP validation
                                  if (!RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid IP address';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 20),

                            // Example Text
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.blueAccent,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Example: 192.168.1.100 or 10.0.2.2 for emulator",
                                      style: GoogleFonts.poppins(
                                        color: Colors.blueAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 30),

                            // Connect Button
                            Container(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _connectToServer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.link_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "CONNECT TO SERVER",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // Additional Info
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Make sure your device and server are on the same network",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _connectToServer() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      await Future.delayed(Duration(milliseconds: 500));

      String ipv = ipController.text.trim();
      final sh = await SharedPreferences.getInstance();

      // Save both IP and formatted URLs
      sh.setString("ip", ipv);
      sh.setString("url", "http://" + ipv + ":8000/myapp");
      sh.setString("img_url", "http://" + ipv + ":8000");
      setState(() {
        _isLoading = false;
      });

      // Navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginNewFull()),
      );
    }
  }
}