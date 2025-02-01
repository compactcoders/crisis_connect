import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';

// Placeholder for the AssistanceScreen
class AssistanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistance Screen'),
      ),
      body: Center(
        child: Text(
          'Here you can request assistance.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showForm = false;
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  bool foodNeeded = false;
  bool clothNeeded = false;
  bool medicineNeeded = false;
  File? _image;
  File? _video;
  File? _audio;

  // Function to Get Location and Send It
  Future<void> sendLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if GPS is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showAlert(
          "Location Service Disabled", "Please enable GPS and try again.");
      return;
    }

    // Check Permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showAlert("Permission Denied", "GPS permission is required.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showAlert("Permission Permanently Denied",
          "Allow location access from settings.");
      return;
    }

    // Get Current Location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Show Confirmation Message
    _showAlert("Location Sent",
        "Location successfully sent. Rescue team will connect with you soon.\n\n📍 Lat: ${position.latitude}, Long: ${position.longitude}");
  }

  // Function to show an Alert Dialog
  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // Form submission function
  void _submitForm() {
    String name = _nameController.text;
    String location = _locationController.text;
    List<String> requirements = [];
    if (foodNeeded) requirements.add("Food");
    if (clothNeeded) requirements.add("Cloth");
    if (medicineNeeded) requirements.add("Medicine");

    if (name.isEmpty || location.isEmpty || requirements.isEmpty) {
      // Show an alert if any field is missing
      _showAlert("Error", "Please fill all fields before submitting.");
    } else {
      // Form submitted successfully
      _showAlert("Help Request Submitted",
          "Name: $name\nLocation: $location\nRequirements: ${requirements.join(', ')}");

      // Close form after submission
      setState(() {
        showForm = false;
      });
    }
  }

  // Function to pick image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to pick video
  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  // Function to pick audio
  Future<void> _pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        _audio = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade800,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: 'Assistance'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AssistanceScreen()));
          }
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Header Image
              Stack(
                children: [
                  Image.asset(
                    'assets/images/img1.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: Text(
                      "CrisisConnect",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMainButton(
                        "📍 Locate Me", Colors.orange, sendLocation),
                    SizedBox(height: 20),
                    _buildMainButton("🚑 Request Help", Colors.red, () {
                      setState(() {
                        showForm = !showForm; // Toggle form visibility
                      });
                    }),
                    SizedBox(height: 20),
                    _buildMainButton("⚠️ Report Issue", Colors.yellow.shade700,
                        () {
                      setState(() {
                        showForm = !showForm; // Toggle form visibility
                      });
                    }),
                  ],
                ),
              ),
            ],
          ),

          // SOS Floating Button in Top-Right Corner
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: sendLocation,
              child: Icon(Icons.sos, color: Colors.white, size: 30),
              tooltip: "Send SOS Location",
            ),
          ),

          // Form for Request Help or Report Incident
          Visibility(
            visible: showForm,
            child: Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:", style: TextStyle(fontSize: 18)),
                      TextField(
                        controller: _nameController,
                        decoration:
                            InputDecoration(hintText: "Enter your name"),
                      ),
                      SizedBox(height: 20),
                      Text("Location:", style: TextStyle(fontSize: 18)),
                      TextField(
                        controller: _locationController,
                        decoration:
                            InputDecoration(hintText: "Enter your location"),
                      ),
                      SizedBox(height: 20),
                      Text("Disaster Type:", style: TextStyle(fontSize: 18)),
                      DropdownButton<String>(
                        items: <String>['Flood', 'Fire', 'Earthquake', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        hint: Text("Select disaster type"),
                      ),
                      SizedBox(height: 20),
                      Text("Requirements:", style: TextStyle(fontSize: 18)),
                      CheckboxListTile(
                        title: Text("Food"),
                        value: foodNeeded,
                        onChanged: (bool? value) {
                          setState(() {
                            foodNeeded = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Cloth"),
                        value: clothNeeded,
                        onChanged: (bool? value) {
                          setState(() {
                            clothNeeded = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Medicine"),
                        value: medicineNeeded,
                        onChanged: (bool? value) {
                          setState(() {
                            medicineNeeded = value!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text("Upload Media (Image, Video, Audio):",
                          style: TextStyle(fontSize: 18)),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text("Pick Image"),
                      ),
                      ElevatedButton(
                        onPressed: _pickVideo,
                        child: Text("Pick Video"),
                      ),
                      ElevatedButton(
                        onPressed: _pickAudio,
                        child: Text("Pick Audio"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Submit Request"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom button method
  Widget _buildMainButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
