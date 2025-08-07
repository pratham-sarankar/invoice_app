import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  // Theme colors matching the app
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);
  static const Color backgroundColor = Color(0xFFFAFBFC);
  static const Color cardColor = Colors.white;

  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPhoneValid = false;

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
    
    // Listen to phone number changes
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    setState(() {
      _isPhoneValid = phone.length == 10;
    });
    
    // Auto unfocus when 10 digits are entered
    if (phone.length == 10) {
      phoneFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  void _handleSendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate OTP sending process
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to OTP verification screen with +91 prefix
    Navigator.pushNamed(context, '/otp-verification', arguments: '+91${phoneController.text}');
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
                height: size.height * 0.28,
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
                          Icons.restaurant_menu,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Act T Connect GST Invoice',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Professional Invoice Management',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Login Form Section
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
                              Text(
                                'Welcome Back',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Enter your phone number to continue',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 20),
                              
                                                             // Phone Number Field
                               TextFormField(
                                 controller: phoneController,
                                 focusNode: phoneFocusNode,
                                 keyboardType: TextInputType.number,
                                 textInputAction: TextInputAction.done,
                                 inputFormatters: [
                                   FilteringTextInputFormatter.digitsOnly,
                                   LengthLimitingTextInputFormatter(10),
                                 ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (value.length != 10) {
                                    return 'Please enter a valid 10-digit phone number';
                                  }
                                  return null;
                                },
                                                                                                   decoration: InputDecoration(
                                   labelText: 'Phone Number',
                                   hintText: 'Enter your 10-digit phone number',
                                   hintStyle: TextStyle(
                                     fontSize: 14,
                                     color: Colors.grey[500],
                                   ),
                                                                       prefixIcon: Icon(
                                      Icons.phone_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    prefixText: '+91 ',
                                    prefixStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                      height: 1.0,
                                    ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[300]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor, width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red[300]!),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                                                     contentPadding: EdgeInsets.symmetric(
                                     horizontal: 14,
                                     vertical: 16,
                                   ),
                                ),
                              ),
                              SizedBox(height: 20),
                              
                              // Send OTP Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading || !_isPhoneValid ? null : _handleSendOTP,
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
                                          'Send OTP',
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 16),
                              
                              // Divider
                              Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.grey[300])),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'or',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider(color: Colors.grey[300])),
                                ],
                              ),
                              SizedBox(height: 20),
                              
                              // Demo Login Button
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: OutlinedButton.icon(
                                  onPressed: _isLoading ? null : () {
                                    Navigator.pushReplacementNamed(context, '/main');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    side: BorderSide(color: primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  icon: Icon(Icons.play_arrow, size: 18),
                                  label: Text(
                                    'Demo Login',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
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
