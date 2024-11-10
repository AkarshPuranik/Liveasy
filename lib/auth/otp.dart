import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mazdoor_user/screens/profile_selection.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  OTPScreen({required this.phoneNumber, required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  void _verifyOtp() async {
    final otpCode = otpControllers.map((controller) => controller.text).join();
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otpCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileSelectionScreen()),
      );
    } catch (e) {
      _showError("Invalid OTP. Please try again.");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 60, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Verify Phone',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Code is sent to ${widget.phoneNumber}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50, // Set width to make the boxes square
                  child: TextField(
                    controller: otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.blue.shade100, // Light blue background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Square corners
                        borderSide: BorderSide(color: Colors.blue.shade900, width: 2), // Blue border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900, // Blue text color for consistency
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _verifyOtp,
              child: Text(
                'VERIFY AND CONTINUE',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
