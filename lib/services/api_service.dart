import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  // Send OTP API
  static Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    try {
      // Debug: Print request details
      final url = '${ApiConstants.baseURL}${ApiConstants.sendOTP}';
      
      // Try different phone number formats
      String cleanPhone = phoneNumber;
      if (phoneNumber.startsWith('+91')) {
        cleanPhone = phoneNumber.substring(3); // Remove +91 prefix
      }
      
      final requestBody = {
        'phone': cleanPhone,
      };
      
      print('🔍 [DEBUG] Send OTP Request:');
      print('   URL: $url');
      print('   Headers: ${ApiConstants.defaultHeaders}');
      print('   Body: $requestBody');
      print('   JSON Body: ${jsonEncode(requestBody)}');
      
      // Try different request formats if the first one fails
      print('📡 [DEBUG] Making HTTP POST request...');
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConstants.defaultHeaders,
        body: jsonEncode(requestBody),
      );

      // Debug: Print response details
      print('📡 [DEBUG] Send OTP Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Headers: ${response.headers}');
      print('   Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ [DEBUG] Success Response Data: $data');
        return {
          ApiConstants.successKey: true,
          ApiConstants.messageKey: data[ApiConstants.messageKey],
          ApiConstants.otpKey: data[ApiConstants.otpKey],
        };
      } else {
        // Handle different status codes
        final errorData = jsonDecode(response.body);
        print('❌ [DEBUG] Error Response Data: $errorData');
        print('❌ [DEBUG] Error Status Code: ${response.statusCode}');
        
        // Try to extract error message from different possible fields
        String errorMessage = 'Failed to send OTP';
        if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('msg')) {
          errorMessage = errorData['msg'];
        }
        
        return {
          ApiConstants.successKey: false,
          ApiConstants.messageKey: errorMessage,
          ApiConstants.errorKey: 'HTTP ${response.statusCode}',
        };
      }
    } catch (e) {
      print('💥 [DEBUG] Exception occurred: $e');
      print('💥 [DEBUG] Exception type: ${e.runtimeType}');
      print('💥 [DEBUG] Stack trace: ${StackTrace.current}');
      return {
        ApiConstants.successKey: false,
        ApiConstants.messageKey: 'Network error: ${e.toString()}',
        ApiConstants.errorKey: 'Exception',
      };
    }
  }

  // Verify OTP API
  static Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String otp) async {
    try {
      // Debug: Print request details
      final url = '${ApiConstants.baseURL}${ApiConstants.verifyOTP}?phone=$phoneNumber&otp=$otp';
      
      print('🔍 [DEBUG] Verify OTP Request:');
      print('   URL: $url');
      print('   Headers: ${ApiConstants.defaultHeaders}');
      print('   Phone: $phoneNumber, OTP: $otp');
      
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConstants.defaultHeaders,
      );

      // Debug: Print response details
      print('📡 [DEBUG] Verify OTP Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Headers: ${response.headers}');
      print('   Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ [DEBUG] Success Response Data: $data');
        return {
          ApiConstants.successKey: true,
          ApiConstants.messageKey: data[ApiConstants.messageKey],
        };
      } else {
        // Handle different status codes
        final errorData = jsonDecode(response.body);
        print('❌ [DEBUG] Error Response Data: $errorData');
        return {
          ApiConstants.successKey: false,
          ApiConstants.messageKey: errorData[ApiConstants.messageKey] ?? 'Failed to verify OTP',
          ApiConstants.errorKey: 'HTTP ${response.statusCode}',
        };
      }
    } catch (e) {
      print('💥 [DEBUG] Exception occurred: $e');
      print('💥 [DEBUG] Exception type: ${e.runtimeType}');
      print('💥 [DEBUG] Stack trace: ${StackTrace.current}');
      return {
        ApiConstants.successKey: false,
        ApiConstants.messageKey: 'Network error: ${e.toString()}',
        ApiConstants.errorKey: 'Exception',
      };
    }
  }

  // Update User Profile API
  static Future<Map<String, dynamic>> updateUserProfile({
    required String phoneNumber,
    required String name,
    required String email,
    required String state,
    required String district,
    required String fullAddress,
  }) async {
    try {
      // Debug: Print request details
      final url = '${ApiConstants.baseURL}${ApiConstants.updateUserInfo}';
      
      // Clean phone number (remove +91 prefix if present)
      String cleanPhone = phoneNumber;
      if (phoneNumber.startsWith('+91')) {
        cleanPhone = phoneNumber.substring(3); // Remove +91 prefix
      }
      
      final requestBody = {
        'phone': cleanPhone,
        'name': name,
        'email': email,
        'state': state,
        'district': district,
        'full_address': fullAddress,
      };
      
      print('🔍 [DEBUG] Update Profile Request:');
      print('   URL: $url');
      print('   Headers: ${ApiConstants.defaultHeaders}');
      print('   Body: $requestBody');
      print('   JSON Body: ${jsonEncode(requestBody)}');
      
      print('📡 [DEBUG] Making HTTP POST request...');
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConstants.defaultHeaders,
        body: jsonEncode(requestBody),
      );

      // Debug: Print response details
      print('📡 [DEBUG] Update Profile Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Headers: ${response.headers}');
      print('   Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ [DEBUG] Success Response Data: $data');
        return {
          ApiConstants.successKey: true,
          ApiConstants.messageKey: data[ApiConstants.messageKey],
          'user': data['user'],
        };
      } else {
        // Handle different status codes
        final errorData = jsonDecode(response.body);
        print('❌ [DEBUG] Error Response Data: $errorData');
        print('❌ [DEBUG] Error Status Code: ${response.statusCode}');
        
        // Try to extract error message from different possible fields
        String errorMessage = 'Failed to update profile';
        if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('msg')) {
          errorMessage = errorData['msg'];
        }
        
        return {
          ApiConstants.successKey: false,
          ApiConstants.messageKey: errorMessage,
          ApiConstants.errorKey: 'HTTP ${response.statusCode}',
        };
      }
    } catch (e) {
      print('💥 [DEBUG] Exception occurred: $e');
      print('💥 [DEBUG] Exception type: ${e.runtimeType}');
      print('💥 [DEBUG] Stack trace: ${StackTrace.current}');
      return {
        ApiConstants.successKey: false,
        ApiConstants.messageKey: 'Network error: ${e.toString()}',
        ApiConstants.errorKey: 'Exception',
      };
    }
  }
} 