import 'package:flutter/material.dart';
import '../viewmodels/degree_cgpa_viewmodel.dart';

class DegreeCGPAScreen extends StatefulWidget {
  @override
  _DegreeCGPAScreenState createState() => _DegreeCGPAScreenState();
}

class _DegreeCGPAScreenState extends State<DegreeCGPAScreen> {
  final DegreeCGPAViewModel _viewModel = DegreeCGPAViewModel();
  final List<TextEditingController> _gpaControllers = List.generate(8, (index) => TextEditingController());
  final List<TextEditingController> _creditHoursControllers = List.generate(8, (index) => TextEditingController());

  void _calculateDegreeCGPA() {
    _viewModel.cGPAs.clear(); // Clear previous GPAs
    _viewModel.creditHours.clear(); // Clear previous credit hours
    for (int i = 0; i < 8; i++) {
      final gpa = double.tryParse(_gpaControllers[i].text) ?? 0.0;
      final creditHours = int.tryParse(_creditHoursControllers[i].text) ?? 0;
      _viewModel.addSemester(gpa, creditHours);
    }

    setState(() {}); // Refresh UI to show Degree CGPA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Degree cgpa calculator'),
        backgroundColor: Color(0xFF006c2c),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF006c2c), // Dark shade of primary color
              Color(0xFF4CAF50), // Lighter shade of green
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Semester Inputs
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Semester ${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _gpaControllers[index],
                              decoration: InputDecoration(
                                labelText: 'GPA',
                                labelStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _creditHoursControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Credit Hours',
                                labelStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Calculate Degree CGPA Button
              ElevatedButton(
                onPressed: _calculateDegreeCGPA,
                child: Text(
                  'Calculate BS CGPA',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006c2c), // Primary color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Display Degree CGPA
              if (_viewModel.cGPAs.isNotEmpty)
                Text(
                  'BS CGPA: ${_viewModel.calculateDegreeCGPA().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}