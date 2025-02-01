import 'package:flutter/material.dart';

class CrisisScreen extends StatefulWidget {
  @override
  _CrisisScreenState createState() => _CrisisScreenState();
}

class _CrisisScreenState extends State<CrisisScreen> {
  int expandedIndex = -1; // Tracks which card is expanded (-1 means none)

  void toggleExpansion(int index) {
    setState(() {
      expandedIndex = expandedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Map Image with Location Pin
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/img1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Icon(
                  Icons.location_on,
                  size: 80,
                  color: Colors.orange,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Title
            Text(
              'CrisisConnect',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15),

            // Address Card
            CrisisCard(
              title: 'Type Address or Use GPS',
              description:
                  'Enter your address manually or use GPS to get your location.',
              isExpanded: expandedIndex == 0,
              onPressed: () => toggleExpansion(0),
            ),

            // Disaster Type Card
            CrisisCard(
              title: 'Disaster Type',
              description:
                  'Select the type of disaster (Flood, Earthquake, Fire, etc.).',
              isExpanded: expandedIndex == 1,
              onPressed: () => toggleExpansion(1),
            ),

            // Resources Needed Card
            CrisisCard(
              title: 'Resources Needed',
              description:
                  'Specify the resources needed (Food, Medical Aid, Shelter, etc.).',
              isExpanded: expandedIndex == 2,
              onPressed: () => toggleExpansion(2),
            ),
          ],
        ),
      ),
    );
  }
}

// Card Widget with Expandable Form
class CrisisCard extends StatefulWidget {
  final String title;
  final String description;
  final bool isExpanded;
  final VoidCallback onPressed;

  const CrisisCard({
    required this.title,
    required this.description,
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  _CrisisCardState createState() => _CrisisCardState();
}

class _CrisisCardState extends State<CrisisCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4, // Adds a shadow effect
        child: Padding(
          padding: EdgeInsets.all(20), // Increased padding
          child: Column(
            children: [
              // White Button with Padding
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White button
                    padding:
                        EdgeInsets.symmetric(vertical: 18), // Increased padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.blue[900]!), // Dark blue border
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.blue[900], // Dark blue text
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Expanded Section (Form)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: widget.isExpanded ? 200 : 50,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[900], // Dark blue background
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.isExpanded
                    ? Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Name Input
                                TextFormField(
                                  controller: nameController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Location Input
                                TextFormField(
                                  controller: locationController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Location",
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          // Submit Button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  widget.onPressed(); // Collapse the form
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // White button
                              foregroundColor:
                                  Colors.blue[900], // Dark blue text
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Submit'),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          widget.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // White text
                            fontSize: 14,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
