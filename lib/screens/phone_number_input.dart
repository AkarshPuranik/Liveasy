import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mazdoor_user/auth/otp.dart';
import 'package:mazdoor_user/screens/profile_selection.dart';


class PhoneNumberInputScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _sendOtp(BuildContext context) async {
    final phoneNumber = '+91${phoneController.text}';
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSelectionScreen(),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed. Try again.')));
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Please enter your mobile number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'You’ll receive a 6 digit code to verify next.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '+91',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _sendOtp(context),
              child: Text(
                'CONTINUE',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
