import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> with TickerProviderStateMixin {
  // Theme colors matching the app
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);
  static const Color backgroundColor = Color(0xFFFAFBFC);
  static const Color cardColor = Colors.white;

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  
  bool _isLoading = false;
  bool _isResendEnabled = true;
  int _resendTimer = 30;
  Timer? _timer;
  String _enteredOTP = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
    _startResendTimer();
    
    // Add listener to OTP controller
    otpController.addListener(_onOTPChanged);
  }

  void _onOTPChanged() {
    _enteredOTP = otpController.text;
    
    // Auto-verify when all 4 digits are entered
    if (_enteredOTP.length == 4) {
      _verifyOTP();
    }
  }

  void _startResendTimer() {
    setState(() {
      _isResendEnabled = false;
      _resendTimer = 30;
    });
    
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOTP() async {
    if (!_isResendEnabled) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate resending OTP
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _startResendTimer();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP resent successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _verifyOTP() async {
    if (_enteredOTP.length != 4) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate OTP verification
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // For demo purposes, accept any 4-digit OTP
    if (_enteredOTP.length == 4) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  ),
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.verified_user_outlined,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'OTP Verification',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Enter the 4-digit code sent to',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                                             Text(
                         widget.phoneNumber,
                         style: theme.textTheme.bodyMedium?.copyWith(
                           color: Colors.white,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                    ],
                  ),
                ),
              ),
              
              // OTP Form Section
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              
                                                             // OTP Input Field using Pinput
                               Center(
                                 child: Pinput(
                                   controller: otpController,
                                   focusNode: otpFocusNode,
                                   length: 4,
                                   defaultPinTheme: PinTheme(
                                     width: 60,
                                     height: 60,
                                     textStyle: theme.textTheme.titleLarge?.copyWith(
                                       fontWeight: FontWeight.w700,
                                       color: Colors.black87,
                                     ),
                                     decoration: BoxDecoration(
                                       border: Border.all(color: Colors.grey[300]!),
                                       borderRadius: BorderRadius.circular(12),
                                       color: Colors.grey[50],
                                     ),
                                   ),
                                   focusedPinTheme: PinTheme(
                                     width: 60,
                                     height: 60,
                                     textStyle: theme.textTheme.titleLarge?.copyWith(
                                       fontWeight: FontWeight.w700,
                                       color: Colors.black87,
                                     ),
                                     decoration: BoxDecoration(
                                       border: Border.all(color: primaryColor, width: 2),
                                       borderRadius: BorderRadius.circular(12),
                                       color: Colors.white,
                                     ),
                                   ),
                                   submittedPinTheme: PinTheme(
                                     width: 60,
                                     height: 60,
                                     textStyle: theme.textTheme.titleLarge?.copyWith(
                                       fontWeight: FontWeight.w700,
                                       color: Colors.black87,
                                     ),
                                     decoration: BoxDecoration(
                                       border: Border.all(color: primaryColor),
                                       borderRadius: BorderRadius.circular(12),
                                       color: Colors.white,
                                     ),
                                   ),
                                   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                   showCursor: true,
                                   onCompleted: (pin) {
                                     _enteredOTP = pin;
                                     _verifyOTP();
                                   },
                                 ),
                               ),
                              SizedBox(height: 30),
                              
                              // Verify Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading || _enteredOTP.length != 4 ? null : _verifyOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadowColor: primaryColor.withOpacity(0.3),
                                  ),
                                  child: _isLoading
                                      ? SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : Text(
                                          'Verify OTP',
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 20),
                              
                              // Resend OTP Section
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Didn't receive the code?",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Resend in ',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        if (!_isResendEnabled)
                                          Text(
                                            '$_resendTimer s',
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        if (_isResendEnabled)
                                          TextButton(
                                            onPressed: _resendOTP,
                                            child: Text(
                                              'Resend OTP',
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              
                              // Demo Login Option
                              Center(
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/main');
                                  },
                                  icon: Icon(Icons.play_arrow, size: 16),
                                  label: Text(
                                    'Demo Login',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 