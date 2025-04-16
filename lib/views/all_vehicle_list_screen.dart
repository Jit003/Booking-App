import 'package:flutter/material.dart';

import '../widgets/static_vehicle_list_widget.dart';



class AllVehicleListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SetupCard(
                  title: 'Tata Setup',
                  plans: [
                    'Normal - 85000/- (Include GST)',
                    'King - 100000/- (Include GST)',
                    'Startup Full Setup - 115000/- (Include GST)',
                    'Medium Full Setup - 130000/- (Include GST)',
                    'Grand Full Setup - 165000 (Include GST)',
                  ],
                ),
                SizedBox(height: 20),
                SetupCard(
                  title: 'Eicher',
                  plans: [
                    'Basic - 90000/- (Include GST)',
                    'Pro - 110000/- (Include GST)',
                    'Elite Setup - 125000/- (Include GST)',
                    'Premium - 140000/- (Include GST)',
                    'Ultimate - 170000/- (Include GST)',
                  ],
                ),
                SizedBox(height: 20),
                SetupCard(
                  title: 'Bharat on wheels',
                  plans: [
                    'Entry - 80000/- (Include GST)',
                    'Advanced - 105000/- (Include GST)',
                    'Business Full Setup - 120000/- (Include GST)',
                    'Enterprise - 150000/- (Include GST)',
                    'Legend - 180000/- (Include GST)',
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
    );
  }
}

