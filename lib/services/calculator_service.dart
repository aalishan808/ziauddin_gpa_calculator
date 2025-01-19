import '../models/course.dart';

class CalculatorService {
  static double calculateGPA(List<Course> courses) {
    double totalGradePoints = 0;
    int totalCreditHours = 0;

    for (var course in courses) {
      double gradePoint = _getGradePoint(course.percentage); // Calculate grade point
      totalGradePoints += gradePoint * course.creditHours; // Sum of (grade point * credit hours)
      totalCreditHours += course.creditHours; // Sum of credit hours
    }

    if (totalCreditHours == 0) return 0.0; // Avoid division by zero
    return totalGradePoints / totalCreditHours; // GPA formula
  }

  static double _getGradePoint(double percentage) {
    if (percentage > 85) {
      return 4.0;
    } else if (percentage >= 80 && percentage <= 84) {
      return 3.66;
    } else if (percentage >= 75 && percentage <= 79) {
      return 3.33;
    } else if (percentage >= 71 && percentage <= 74) {
      return 3.00;
    } else if (percentage >= 68 && percentage <= 70) {
      return 2.66;
    } else if (percentage >= 64 && percentage <= 67) {
      return 2.33;
    } else if (percentage >= 61 && percentage <= 63) {
      return 2.00;
    } else if (percentage >= 59 && percentage <= 60) {
      return 1.66;
    } else if (percentage >= 54 && percentage <= 57) {
      return 1.30;
    } else if (percentage >= 50 && percentage <= 53) {
      return 1.00;
    } else {
      return 0.00;
    }
  }
}