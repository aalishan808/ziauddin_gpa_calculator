import '../models/course.dart';
import '../services/calculator_service.dart';

class GPAViewModel {
  List<Course> _courses = []; // List to store courses

  List<Course> get courses => _courses;

  void addCourse(Course course) {
    // Add course only if valid
    if (course.creditHours > 0 && course.percentage >= 0 && course.percentage <= 100) {
      _courses.add(course);
    }
  }

  void removeCourse(int index) {
    _courses.removeAt(index);
  }

  double calculateGPA() {
    return CalculatorService.calculateGPA(_courses); // Pass the courses array
  }
}
