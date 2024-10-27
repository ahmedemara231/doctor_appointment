class ApiConstants
{
  static const String baseUrl = 'https://vcare.integration25.com/api';

  // timeout durations
  static Duration timeoutDuration = const Duration(seconds: 15);

  // Auth
  static const String login = '/auth/login';
  static const String signUp = '/auth/register';
  static const String doctorsBasedOnSpecialization = '/specialization/show/';

  // Home
  static const String home = '/home/index';
}