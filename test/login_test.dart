import 'package:HOMECARE/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('empty email returns error string', () {
    final result = EmailFieldValidator.validate('');
    expect(result, 'Email cannot be empty');
  });
  test('non-valid email returns error', () {
    final result = EmailFieldValidator.validate('email');
    expect(result, 'Please enter a valid email');
  });
  test('empty password returns error string', () {
    final result = PasswordFieldValidator.validate('');
    expect(result, 'Password cannot be empty');
  });
  test('non-valid password returns error', () {
    final result = PasswordFieldValidator.validate('pass');
    expect(result, 'please enter valid password min. 6 character');
  });
  test('valid email', () {
    final result = EmailFieldValidator.validate('vt9796@gmail.com');
    expect(result, null);
  });
  test('valid password', () {
    final result = PasswordFieldValidator.validate('vimal@123');
    expect(result, null);
  });
}