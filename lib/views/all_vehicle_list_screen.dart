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
                    'Normal - 65000/- (Include GST)',
                    'King - 85000/- (Include GST)',
                    'Full Setup - 115000/- (Include GST)',
                  ],
                ),
                SizedBox(height: 20),
                SetupCard(
                  title: 'Barat on wheels',
                  plans: [
                    'Normal - 70000/- (Include GST)',
                    'Royal - 170000/- (Include GST)',
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

