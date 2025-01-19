class DegreeCGPAViewModel {
  List<double> _cGPAs = []; // List to store GPAs of each semester
  List<int> _creditHours = []; // List to store credit hours of each semester

  List<double> get cGPAs => _cGPAs;
  List<int> get creditHours => _creditHours;

  void addSemester(double cgpa, int creditHours) {
    _cGPAs.add(cgpa);
    _creditHours.add(creditHours);
  }

  double calculateDegreeCGPA() {
    if (_cGPAs.isEmpty || _creditHours.isEmpty) return 0.0; // Avoid division by zero

    double totalGradePoints = 0;
    int totalCreditHours = 0;

    for (int i = 0; i < _cGPAs.length; i++) {
      totalGradePoints += _cGPAs[i] * _creditHours[i]; // Sum of (GPA * Credit Hours)
      totalCreditHours += _creditHours[i]; // Sum of Credit Hours
    }

    return totalGradePoints / totalCreditHours; // Degree CGPA formula
  }
}