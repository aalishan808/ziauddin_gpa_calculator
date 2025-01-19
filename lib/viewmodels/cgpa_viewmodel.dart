class CGPAViewModel {
  List<double> _gpas = []; // List to store GPAs of each semester
  List<int> _creditHours = []; // List to store credit hours of each semester

  List<double> get gpas => _gpas;
  List<int> get creditHours => _creditHours;

  void addGPA(double gpa) {
    _gpas.add(gpa);
  }

  void addCreditHours(int creditHours) {
    _creditHours.add(creditHours);
  }

  double calculateCGPA() {
    if (_gpas.isEmpty || _creditHours.isEmpty) return 0.0; // Avoid division by zero

    double totalGradePoints = 0;
    int totalCreditHours = 0;

    for (int i = 0; i < _gpas.length; i++) {
      totalGradePoints += _gpas[i] * _creditHours[i]; // Sum of (GPA * Credit Hours)
      totalCreditHours += _creditHours[i]; // Sum of Credit Hours
    }

    return totalGradePoints / totalCreditHours; // CGPA formula
  }
}