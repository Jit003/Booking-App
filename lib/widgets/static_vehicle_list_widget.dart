import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupCard extends StatelessWidget {
  final String title;
  final List<String> plans;

  const SetupCard({super.key, required this.title, required this.plans});

  // Function to launch the phone dialer
  Future<void> _makeCall() async {
    const phoneNumber = 'tel:+1234567890'; // Replace with the phone number you want to dial
    final Uri phoneUri = Uri.parse(phoneNumber);

    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Action button widget


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5F5F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...plans.map(
            (plan) => Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'SFX complimentary',
                    style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _actionButton("Inquiry"),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionButton(String label) {
    return Expanded(
      child: GestureDetector(
        onTap: _makeCall,  // Trigger the call function when the button is tapped
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFF5F5F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
