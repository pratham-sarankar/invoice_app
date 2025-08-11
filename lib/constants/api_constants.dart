class ApiConstants {
  // Base URL
  static const String baseURL = 'https://new-invoice.acttconnect.com';
  
  // API Endpoints
  static const String sendOTP = '/api/send-otp';
  static const String verifyOTP = '/api/verify-otp';
  static const String updateUserInfo = '/api/update-user-info';
  
  // API Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // API Response Keys
  static const String messageKey = 'message';
  static const String otpKey = 'otp';
  static const String successKey = 'success';
  static const String errorKey = 'error';
} 