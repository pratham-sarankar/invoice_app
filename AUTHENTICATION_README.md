# Authentication System Documentation

## Overview
This app uses a simple local authentication system based on SharedPreferences instead of complex API-based authentication with tokens. The system tracks whether a user is logged in and stores basic user information locally.

## How It Works

### 1. Authentication State Management
- **Login State**: Stored as a boolean flag in SharedPreferences
- **User Data**: Phone number and name are stored locally
- **No Tokens**: No JWT or session tokens are used

### 2. Key Components

#### AuthUtils (`lib/utils/auth_utils.dart`)
- `isLoggedIn()`: Checks if user is currently logged in
- `setLoggedIn(phone, name)`: Sets user as logged in with their details
- `logout()`: Clears login state and user data
- `getUserName()`, `getUserPhone()`: Retrieves stored user information
- `updateUserName()`, `updateUserPhone()`: Updates user information

#### Login Flow
1. **Splash Screen**: Checks authentication status on app launch
2. **Login Screen**: User enters phone number and receives OTP
3. **OTP Verification**: User enters OTP code
4. **Profile Completion**: User fills in profile details
5. **Login Complete**: User is marked as logged in and navigated to main screen

#### Logout Flow
1. **Logout Option**: Available in Account Settings and Menu screens
2. **Confirmation Dialog**: User confirms logout action
3. **State Clear**: Login state and user data are cleared
4. **Navigation**: User is redirected to login screen

### 3. User Experience Features

#### Automatic Login Check
- App remembers login state between sessions
- Users don't need to log in every time they open the app
- Seamless navigation to main screen for logged-in users

#### Data Persistence
- User name and phone number are saved locally
- Changes in Account Settings are automatically saved
- Data persists until user logs out

#### Development Features
- **Skip Login Button**: Available on login screen for testing
- Sets demo user credentials for quick access
- Useful for development and testing purposes

### 4. Security Considerations

#### Local Storage
- User data is stored locally on device
- No encryption of stored data
- Suitable for simple business applications

#### No Server Validation
- Login state is not validated against server
- App assumes local state is accurate
- Consider implementing server-side validation for production

### 5. Usage Examples

#### Check Login Status
```dart
bool isLoggedIn = await AuthUtils.isLoggedIn();
if (isLoggedIn) {
  // User is logged in
  Navigator.pushReplacementNamed(context, '/main');
} else {
  // User needs to log in
  Navigator.pushReplacementNamed(context, '/login');
}
```

#### Set User as Logged In
```dart
await AuthUtils.setLoggedIn(
  phone: '+911234567890',
  name: 'John Doe',
);
```

#### Logout User
```dart
await AuthUtils.logout();
Navigator.pushReplacementNamed(context, '/login');
```

#### Update User Information
```dart
await AuthUtils.updateUserName('New Name');
await AuthUtils.updateUserPhone('+919876543210');
```

## Benefits of This Approach

1. **Simplicity**: No complex token management or API calls
2. **Performance**: Fast authentication checks without network requests
3. **Offline Support**: Works without internet connection
4. **User Experience**: No repeated logins for returning users
5. **Development Friendly**: Easy to test and debug

## Future Enhancements

1. **Server Validation**: Add periodic server-side authentication checks
2. **Data Encryption**: Encrypt locally stored user data
3. **Biometric Authentication**: Add fingerprint/face unlock support
4. **Session Timeout**: Implement automatic logout after inactivity
5. **Multi-User Support**: Allow switching between different user accounts

## Files Modified

- `lib/utils/auth_utils.dart` - New authentication utility class
- `lib/screens/account_settings.dart` - Updated logout functionality
- `lib/screens/complete_profile_screen.dart` - Added login state setting
- `lib/screens/splash_screen.dart` - Added authentication check
- `lib/screens/menu_screen.dart` - Added logout option
- `lib/screens/login_screen.dart` - Added skip login for development

## Dependencies

- `shared_preferences: ^2.2.2` - For local data storage 