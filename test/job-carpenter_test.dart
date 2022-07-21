
import 'package:HOMECARE/pages/screens/job-carpenter.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('Empty Work description returns error string', () {
    final result = WorkDescValidator.validate('');
    expect(result, "Can't be empty");
  });
  test('Non valid work description returns error ', () {
    final result = WorkDescValidator.validate('Hi');
    expect(result, 'Not Valid');
  });
  test('Empty address field returns error string', () {
    final result = AddressValidator.validate('');
    expect(result, 'Address cannot be empty');
  });
}