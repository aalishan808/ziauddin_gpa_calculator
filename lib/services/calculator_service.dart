import '../models/course.dart';

class CalculatorService {
  static double calculateGPA(List<Course> courses) {
    double totalGradePoints = 0;
    int totalCreditHours = 0;

    for (var course in courses) {
      double gradePoint = course.percentage; // Calculate grade point
      print('Calculating Grade Point for ${course.name}: ${course.percentage} -> $gradePoint'); // Debugging
      totalGradePoints += gradePoint * course.creditHours; // Sum of (grade point * credit hours)
      totalCreditHours += course.creditHours; // Sum of credit hours
    }

    // Debug prints
    print('Total Grade Points: $totalGradePoints, Total Credit Hours: $totalCreditHours');

    if (totalCreditHours == 0) return 0.0; // Avoid division by zero
    return totalGradePoints / totalCreditHours; // GPA formula
  }

static double _getGradePoint(double percentage) {
    print('Received Percentage: $percentage'); // Debugging
    if (percentage > 85) {
        print('Returning 4.0');
        return 4.0;
    } else if (percentage >= 80 && percentage <= 84) {
        print('Returning 3.66');
        return 3.66;
    } else if (percentage >= 75 && percentage <= 79) {
        print('Returning 3.33');
        return 3.33;
    } else if (percentage >= 71 && percentage <= 74) {
        print('Returning 3.00');
        return 3.00;
    } else if (percentage >= 68 && percentage <= 70) {
        print('Returning 2.66');
        return 2.66;
    } else if (percentage >= 64 && percentage <= 67) {
        print('Returning 2.33');
        return 2.33;
    } else if (percentage >= 61 && percentage <= 63) {
        print('Returning 2.00');
        return 2.00;
    } else if (percentage >= 59 && percentage <= 60) {
        print('Returning 1.66');
        return 1.66;
    } else if (percentage >= 54 && percentage <= 57) {
        print('Returning 1.30');
        return 1.30;
    } else if (percentage >= 50 && percentage <= 53) {
        print('Returning 1.00');
        return 1.00;
    } else {
        print('Returning 0');
        return 0.00;
    }
}

}
