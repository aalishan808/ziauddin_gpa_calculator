import 'package:flutter/material.dart';
import '../viewmodels/cgpa_viewmodel.dart';

class CGPAScreen extends StatefulWidget {
  @override
  _CGPAScreenState createState() => _CGPAScreenState();
}

class _CGPAScreenState extends State<CGPAScreen> {
  final CGPAViewModel _viewModel = CGPAViewModel();
  final TextEditingController _numSemestersController = TextEditingController();
  final List<TextEditingController> _gpaControllers = [];
  final List<TextEditingController> _creditHoursControllers = [];

  int _numSemesters = 0;
  bool _showSemesterInputs = false;

  void _setNumSemesters() {
    setState(() {
      _numSemesters = int.tryParse(_numSemestersController.text) ?? 0;
      _showSemesterInputs = _numSemesters > 0;

      // Initialize controllers for each semester
      if (_showSemesterInputs) {
        _gpaControllers.clear();
        _creditHoursControllers.clear();
        for (int i = 0; i < _numSemesters; i++) {
          _gpaControllers.add(TextEditingController());
          _creditHoursControllers.add(TextEditingController());
        }
      }
    });
  }

  void _calculateCGPA() {
    _viewModel.gpas.clear(); // Clear previous GPAs
    _viewModel.creditHours.clear(); // Clear previous credit hours
    for (int i = 0; i < _numSemesters; i++) {
      final gpa = double.tryParse(_gpaControllers[i].text) ?? 0.0;
      final creditHours = int.tryParse(_creditHoursControllers[i].text) ?? 0;
      _viewModel.addGPA(gpa);
      _viewModel.addCreditHours(creditHours);
    }

    setState(() {}); // Refresh UI to show CGPA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA Calculator'),
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
              // Input for Number of Semesters
              TextField(
                controller: _numSemestersController,
                decoration: InputDecoration(
                  labelText: 'Number of Semesters',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _setNumSemesters,
                child: Text(
                  'Set Number of Semesters',
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

              // Semester Inputs
              if (_showSemesterInputs)
                Expanded(
                  child: ListView.builder(
                    itemCount: _numSemesters,
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

              // Calculate CGPA Button
              if (_showSemesterInputs)
                ElevatedButton(
                  onPressed: _calculateCGPA,
                  child: Text(
                    'Calculate CGPA',
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

              // Display CGPA
              if (_viewModel.gpas.isNotEmpty)
                Text(
                  'CGPA: ${_viewModel.calculateCGPA().toStringAsFixed(2)}',
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