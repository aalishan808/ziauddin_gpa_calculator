import 'package:flutter/material.dart';
import '../viewmodels/gpa_viewmodel.dart';
import '../models/course.dart';

class GPAScreen extends StatefulWidget {
  @override
  _GPAScreenState createState() => _GPAScreenState();
}

class _GPAScreenState extends State<GPAScreen> {
  final GPAViewModel _viewModel = GPAViewModel();
  final TextEditingController _numCoursesController = TextEditingController();
  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _creditHoursControllers = [];
  final List<TextEditingController> _percentageControllers = [];

  int _numCourses = 0;
  bool _showCourseInputs = false;

  void _setNumCourses() {
    if(_numCoursesController.text.isEmpty) {
      return;
    }
    setState(() {
      _numCourses = int.tryParse(_numCoursesController.text) ?? 0;
      _showCourseInputs = _numCourses > 0;

      // Initialize controllers for each course
      if (_showCourseInputs) {
        _nameControllers.clear();
        _creditHoursControllers.clear();
        _percentageControllers.clear();
        for (int i = 0; i < _numCourses; i++) {
          _nameControllers.add(TextEditingController());
          _creditHoursControllers.add(TextEditingController());
          _percentageControllers.add(TextEditingController());
        }
      }
    });
  }

  void _calculateGPA() {
    _viewModel.courses.clear(); // Clear previous courses
    for (int i = 0; i < _numCourses; i++) {
      final course = Course(
        name: _nameControllers[i].text,
        creditHours: int.tryParse(_creditHoursControllers[i].text) ?? 0,
        percentage: double.tryParse(_percentageControllers[i].text) ?? 0.0,
      );
      _viewModel.addCourse(course);
    }

    setState(() {}); // Refresh UI to show GPA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator'),
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
              // Input for Number of Courses
              TextField(
                controller: _numCoursesController,
                decoration: InputDecoration(
                  labelText: 'Number of Courses',
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
                onPressed: _setNumCourses,
                child: Text(
                  'Set Number of Courses',
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

              // Course Inputs
              if (_showCourseInputs)
                Expanded(
                  child: ListView.builder(
                    itemCount: _numCourses,
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
                                'Course ${index + 1}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _nameControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Course Name',
                                  labelStyle: TextStyle(color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
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
                              SizedBox(height: 10),
                              TextField(
                                controller: _percentageControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Percentage',
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

              // Calculate GPA Button
              if (_showCourseInputs)
                ElevatedButton(
                  onPressed: _calculateGPA,
                  child: Text(
                    'Calculate GPA',
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

              // Display GPA
              if (_viewModel.courses.isNotEmpty)
                Text(
                  'GPA: ${_viewModel.calculateGPA().toStringAsFixed(2)}',
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