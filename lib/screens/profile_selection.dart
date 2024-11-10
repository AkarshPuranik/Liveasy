import 'package:flutter/material.dart';

class ProfileSelectionScreen extends StatefulWidget {
  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  String selectedProfile = 'Shipper';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please select your profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Shipper option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProfile = 'Shipper';
                });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedProfile == 'Shipper' ? Colors.blue.shade900 : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: 'Shipper',
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value.toString();
                        });
                      },
                    ),
                    Icon(Icons.home_work, size: 40, color: Colors.grey),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipper',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Are you a Shipper',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Transporter option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedProfile = 'Transporter';
                });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedProfile == 'Transporter' ? Colors.blue.shade900 : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: 'Transporter',
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value.toString();
                        });
                      },
                    ),
                    Icon(Icons.local_shipping, size: 40, color: Colors.grey),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transporter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Are you a Transporter',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {

              },
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
