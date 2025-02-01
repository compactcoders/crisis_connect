import 'package:flutter/material.dart';

class AssistanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text('CrisisConnect', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
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
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search Assistance...",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade700,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Prescribed Medications"),
            _buildCategoryButtons([
              "Pain Remover",
              "Immune Booster",
              "Vitamins",
            ]),
            SizedBox(height: 20),
            _buildSectionTitle("Find Assistance"),
            _buildCategoryButtons([
              "General",
              "Oral Health",
              "Genetics",
              "Infections",
              "Heart Health",
              "Mental Well-being",
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryButtons(List<String> categories) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((category) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: Text(
            category,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
