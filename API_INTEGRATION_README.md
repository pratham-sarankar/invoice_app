# API Integration Documentation

## Overview
This document describes the API integration implemented in the Flutter invoice app for sending OTP verification.

## API Endpoints

### Send OTP
- **URL**: `https://new-invoice.acttconnect.com/api/send-otp`
- **Method**: POST
- **Content-Type**: application/json

#### Request Body
```json
{
  "phone_number": "+91XXXXXXXXXX"
}
```

#### Response
**Success (200)**
```json
{
  "message": "OTP sent successfully",
  "otp": 1234
}
```

**Error (4xx/5xx)**
```json
{
  "message": "Error message here"
}
```

### Verify OTP
- **URL**: `https://new-invoice.acttconnect.com/api/verify-otp?phone=9876543210&otp=1234`
- **Method**: GET
- **Parameters**: 
  - `phone`: Phone number (without country code)
  - `otp`: 4-digit OTP code

#### Response
**Success (200)**
```json
{
  "message": "OTP verified"
}
```

**Error (4xx/5xx)**
```json
{
  "message": "Error message here"
}
```

### Update User Profile
- **URL**: `https://new-invoice.acttconnect.com/api/update-user-info`
- **Method**: POST
- **Content-Type**: application/json

#### Request Body
```json
{
  "phone": "9876543210",
  "name": "John Doe",
  "email": "john@example.com",
  "state": "Maharashtra",
  "district": "Pune",
  "full_address": "123 MG Road, Pune"
}
```

#### Response
**Success (200)**
```json
{
  "message": "User details updated successfully",
  "user": {
    "id": 2,
    "otp_verified": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "9876543210",
    "email_verified_at": null,
    "state": null,
    "district": null,
    "full_address": null,
    "avatar": null,
    "created_at": "2025-08-11T05:36:50.000000Z",
    "updated_at": "2025-08-11T05:50:07.000000Z"
  }
}
```

**Error (4xx/5xx)**
```json
{
  "message": "Error message here"
}
```

## Implementation Details

### Files Created/Modified

1. **`lib/constants/api_constants.dart`** - API configuration constants
2. **`lib/services/api_service.dart`** - API service class for HTTP requests
3. **`lib/screens/login_screen.dart`** - Updated to use API service
4. **`lib/screens/otp_verification_screen.dart`** - Updated to use API service
5. **`lib/screens/complete_profile_screen.dart`** - New screen for profile completion with state/district dropdowns
6. **`lib/utils/location_data.dart`** - Comprehensive Indian states and districts data
6. **`lib/main.dart`** - Updated with new routes
7. **`pubspec.yaml`** - Added http package dependency

### Key Features

- **Error Handling**: Comprehensive error handling for network issues and API errors
- **User Feedback**: Success/error messages displayed via SnackBar
- **Loading States**: Loading indicator during API calls
- **Constants Management**: Centralized API configuration
- **Service Layer**: Clean separation of API logic from UI
- **Location Data**: Comprehensive Indian states and districts from utility class

### Usage

The API integration is automatically triggered when the user:

**Send OTP Flow:**
1. Enters a valid 10-digit phone number
2. Clicks the "Send OTP" button
3. The app validates the input and makes the API call
4. On success, navigates to OTP verification screen
5. On error, displays appropriate error message

**Verify OTP Flow:**
1. User enters the 4-digit OTP received
2. App automatically verifies OTP when all digits are entered
3. Makes API call to verify OTP
4. On success, navigates to complete profile screen
5. On error, displays error message and allows retry

**Complete Profile Flow:**
1. After OTP verification, user is taken to profile completion screen
2. User fills in personal information (name, email, state, district, address)
3. State and district fields use dropdowns with comprehensive Indian location data
4. App validates all required fields
5. Makes API call to update user profile
6. On success, navigates to main screen
7. On error, displays error message and allows retry
8. User can also skip profile completion and go directly to main screen

**Resend OTP:**
1. User can request new OTP after 30 seconds
2. App calls the send OTP API again
3. Resets the 30-second timer

### Dependencies

- `http: ^1.1.0` - For making HTTP requests

### Testing

To test the API integration:
1. Run `flutter pub get` to install dependencies
2. Ensure the device/emulator has internet access
3. Enter a valid phone number and tap "Send OTP"
4. Check the console for API request/response logs
5. Verify success/error handling works correctly

## Future Enhancements

- Add retry mechanism for failed requests
- Implement request timeout handling
- Add request/response logging for debugging
- Implement API rate limiting
- Add offline mode support 