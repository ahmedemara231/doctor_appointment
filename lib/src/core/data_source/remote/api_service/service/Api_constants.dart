class ApiConstants
{
  static const String baseUrl = 'https://vcare.integration25.com/api';

  // timeout durations
  static Duration timeoutDuration = const Duration(seconds: 15);

  // Auth
  static const String login = '/auth/login';
  static const String signUp = '/auth/register';
  static const String doctorsBasedOnSpecialization = '/specialization/show/';
  static const String makeAppointment = '/appointment/store';

  // Home
  static const String home = '/home/index';
}