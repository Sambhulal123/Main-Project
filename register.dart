import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loginmain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Bullying App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        primaryColor: Colors.blueAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
        ),
      ),
      home: const MyRegisterPage(title: 'Register'),
    );
  }
}

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  String gender = "Male";
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool _isLoading = false;

  // Text Controllers
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController pincontroller = TextEditingController();
  final TextEditingController placecontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();

  // Form Key
  final _formkey = GlobalKey<FormState>();

  // Image Picker - Only using image_picker, no permission_handler
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();
  String _formattedDob = '';

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    pincontroller.dispose();
    placecontroller.dispose();
    dobcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: height,
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section with Background
                _buildHeader(),

                // Form Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    children: [
                      // Profile Image Section
                      _buildProfileImageSection(),
                      const SizedBox(height: 20),

                      // Form Fields
                      _buildFullNameField(),
                      const SizedBox(height: 15),

                      _buildEmailPhoneRow(),
                      const SizedBox(height: 15),

                      _buildDateOfBirthField(),
                      const SizedBox(height: 15),

                      _buildGenderSection(),
                      const SizedBox(height: 15),

                      _buildLocationField(),
                      const SizedBox(height: 15),

                      _buildBioField(),
                      const SizedBox(height: 15),

                      _buildPasswordRow(),
                      const SizedBox(height: 30),

                      // Terms and Conditions
                      _buildTermsSection(),
                      const SizedBox(height: 25),

                      // Sign Up Button
                      _buildSignUpButton(),
                      const SizedBox(height: 20),

                      // Login Link
                      _buildLoginLink(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withOpacity(0.8),
            Colors.purpleAccent.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 25),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Join our community today',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile Image Section - Fixed with image_picker only
  Widget _buildProfileImageSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: _showImagePickerOptions,
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: _selectedImage != null
                        ? Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    )
                        : Container(
                      color: const Color(0xFF1D1E33),
                      child: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0A0E21),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            _selectedImage != null
                ? 'Tap to change photo'
                : 'Tap to add profile picture',
            style: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Show Image Picker Options - Using only image_picker
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1D1E33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Select Profile Picture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blueAccent),
                title: const Text(
                  'Choose from Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blueAccent),
                title: const Text(
                  'Take a Photo',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Remove Image',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImage = null;
                    });
                    _showToast('Image removed', Colors.orange);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // Pick Image - Using only image_picker (handles permissions internally)
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        _showToast('Image selected successfully', Colors.green);
      }
    } catch (e) {
      // Handle any errors (including permission errors)
      String errorMessage = e.toString();
      if (errorMessage.contains('permission') || errorMessage.contains('denied')) {
        _showToast('Please allow permission in settings', Colors.red);
      } else {
        _showToast('Error: $errorMessage', Colors.red);
      }
    }
  }

  // Full Name Field
  Widget _buildFullNameField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: namecontroller,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your full name';
          }
          if (RegExp(r'\d').hasMatch(value)) {
            return 'Name should not contain numbers';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Full Name',
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  // Email and Phone Row
  Widget _buildEmailPhoneRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: TextFormField(
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Email',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: TextFormField(
              controller: phonecontroller,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (!RegExp(r"^[6-9][0-9]{9}$").hasMatch(value)) {
                  return 'Invalid number';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Phone',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
                prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.grey),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Date of Birth Field
  Widget _buildDateOfBirthField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: dobcontroller,
        readOnly: true,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select date of birth';
          }
          return null;
        },
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    surface: Color(0xFF1D1E33),
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: const Color(0xFF0A0E21),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            // Format for display
            String displayDate = "${picked.day.toString().padLeft(2, '0')}/"
                "${picked.month.toString().padLeft(2, '0')}/"
                "${picked.year}";

            // Format for API (YYYY-MM-DD)
            _formattedDob = "${picked.year}-"
                "${picked.month.toString().padLeft(2, '0')}-"
                "${picked.day.toString().padLeft(2, '0')}";

            setState(() {
              dobcontroller.text = displayDate;
            });
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Date of Birth',
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  // Gender Section
  Widget _buildGenderSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.transgender, color: Colors.blueAccent, size: 18),
              const SizedBox(width: 8),
              Text(
                'Gender',
                style: GoogleFonts.poppins(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildGenderOption("Male", Icons.male),
              _buildGenderOption("Female", Icons.female),
              _buildGenderOption("Other", Icons.transgender),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String value, IconData icon) {
    bool isSelected = gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            gender = value;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey[700]!,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.blueAccent : Colors.grey[500],
                size: 20,
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  color: isSelected ? Colors.blueAccent : Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Location Field
  Widget _buildLocationField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: placecontroller,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Location',
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  // Bio Field
  Widget _buildBioField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: pincontroller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'About Yourself (Bio)',
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.description_outlined, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  // Password Row
  Widget _buildPasswordRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: TextFormField(
              controller: passwordcontroller,
              obscureText: showPassword,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                } else if (value.length < 8) {
                  return 'Minimum 8 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Password',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey[500],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: TextFormField(
              controller: confirmpasswordcontroller,
              obscureText: showConfirmPassword,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm';
                } else if (value != passwordcontroller.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Confirm',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                  icon: Icon(
                    showConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey[500],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Terms Section
  Widget _buildTermsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By creating an account, you agree to our ',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            height: 1.5,
          ),
          children: [
            const TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' and acknowledge our ',
              style: TextStyle(color: Colors.grey[400]),
            ),
            const TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '.',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  // Sign Up Button
  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _validateAndSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          shadowColor: Colors.blueAccent.withOpacity(0.5),
        ),
        child: _isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add_alt_1, size: 20),
            const SizedBox(width: 10),
            Text(
              'CREATE ACCOUNT',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Login Link
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginNewFull()),
            );
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Show Toast Message
  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  // Validate and Submit
  void _validateAndSubmit() {
    if (_formkey.currentState!.validate()) {
      if (_selectedImage == null) {
        _showToast('Please select a profile photo', Colors.red);
      } else if (dobcontroller.text.isEmpty) {
        _showToast('Please select date of birth', Colors.red);
      } else {
        _sendData();
      }
    }
  }

  // Send Data to Server
  Future<void> _sendData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();

      var request = http.MultipartRequest(
          'POST',
          Uri.parse('$url/user_register/')
      );

      // Add text fields
      request.fields['name'] = namecontroller.text;
      request.fields['email'] = emailcontroller.text;
      request.fields['dateofbirth'] = _formattedDob;
      request.fields['country'] = placecontroller.text;
      request.fields['gender'] = gender;
      request.fields['phonenumber'] = phonecontroller.text;
      request.fields['pin'] = pincontroller.text;
      request.fields['password'] = passwordcontroller.text;
      request.fields['confirmpassword'] = confirmpasswordcontroller.text;

      // Add image file
      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _selectedImage!.path,
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(respStr);

        if (jsonResponse['status'] == 'ok') {
          _showToast('Registered successfully!', Colors.green);

          // Navigate to login after successful registration
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginNewFull()),
                  (route) => false,
            );
          });
        } else if (jsonResponse['status'] == 'no') {
          _showToast('Email already exists', Colors.orange);
        } else {
          _showToast('Registration failed', Colors.red);
        }
      } else {
        _showToast('Network error', Colors.red);
      }
    } catch (e) {
      _showToast('Error: ${e.toString()}', Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}