import 'package:HOMECARE/pages/workerprofilescreen.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('Empty age field returns error string', () {
    final result = AgeValidator.validate('');
    expect(result, "Can't be empty");
  });
  test('Invalid age returns error string', () {
    final result = AgeValidator.validate('(25)');
    expect(result, "Enter a valid Age");
  });
  test('Empty Aadhar number field returns error string', () {
    final result = AadharValidator.validate('');
    expect(result, "Can't be empty");
  });
  test('Invalid error returns error string', () {
    final result = AadharValidator.validate('(12345123456)');
    expect(result, 'Enter a valid aadhar number');
  });
}