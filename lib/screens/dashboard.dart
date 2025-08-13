import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Placeholder for other screens
class HomeDashboard extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomeDashboard({super.key, required this.onThemeToggle});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  // Theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: GestureDetector(
            onTap: () => _showBusinessBottomSheet(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BusinessName',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.1,
                    color: primaryColor,
                    fontFamily:
                        GoogleFonts.openSansTextTheme(
                          Theme.of(context).textTheme,
                        ).bodyMedium?.fontFamily,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 20),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.card_giftcard, color: primaryColor, size: 22),
              onPressed: () => Navigator.pushNamed(context, '/invite-earn'),
              tooltip: 'Invite & Earn',
            ),
            IconButton(
              icon: Icon(Icons.contact_support, color: primaryColor, size: 22),
              onPressed: () => _showContactUsDialog(context),
              tooltip: 'Contact Us',
            ),
          ],
          shape: null,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.18),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Top Row Cards Section (Invoices, Purchase) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TopRowCard(
                    icon: Icons.receipt_long,
                    title: 'Invoices',
                    color: Color(0xFFFF6B35), // Vibrant orange background
                    onTap:
                        () => Navigator.pushNamed(context, '/create-invoice'),
                  ),
                  SizedBox(width: 16), // Consistent spacing
                  _TopRowCard(
                    icon: Icons.shopping_cart,
                    title: 'Purchase',
                    color: Color(0xFF4CAF50), // Vibrant green background
                    onTap: () => Navigator.pushNamed(context, '/purchase'),
                  ),
                ],
              ),
              SizedBox(height: 18),

              // --- Dashboard Cards Section (2x2 grid) ---
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.3,
                children: [
                  // To Collect Card (Green)
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: '₹ 440',
                    color: Colors.green[100]!,
                    subtitle: 'To Collect',
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.green[900],
                    showArrow: true,
                    arrowDirection: 'down',
                    primaryColor: primaryColor,
                  ),
                  // This week's sale Card (Blue Theme)
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: '₹ 440',
                    color: Color(0xFFE3F2FD), // Light blue background
                    subtitle: "This week's sale",
                    small: true,
                    rightArrow: true,
                    valueColor: Color(0xFF1565C0), // Dark blue text
                    primaryColor: Color(0xFF1565C0),
                  ),
                  // Total Balance Card (Purple Theme)
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: 'Total Balance',
                    color: Color(0xFFF3E5F5), // Light purple background
                    subtitle: 'Cash + Bank Balance',
                    small: true,
                    rightArrow: true,
                    valueColor: Color(0xFF7B1FA2), // Dark purple text
                    primaryColor: Color(0xFF7B1FA2),
                  ),
                  // Reports Card (Teal Theme)
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: 'Reports',
                    color: Color(0xFFE0F2F1), // Light teal background
                    subtitle: 'Sales, Party, GST...',
                    small: true,
                    rightArrow: true,
                    valueColor: Color(0xFF00695C), // Dark teal text
                    primaryColor: Color(0xFF00695C),
                  ),
                ],
              ),
              SizedBox(height: 18),

              // Transactions Section Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'LAST 365 DAYS',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Transactions List
              Column(
                children: [
                  _InvoiceTransactionItem(
                    customerName: 'Priya Sharma 💫',
                    invoiceNumber: 'Invoice #5',
                    dueDate: '06 Aug • 6 day(s) to due',
                    amount: '₹ 1,250',
                    status: 'Unpaid',
                    isTablet: isTablet,
                  ),
                  SizedBox(height: 8),
                  _InvoiceTransactionItem(
                    customerName: 'Rajesh Kumar 🏢',
                    invoiceNumber: 'Invoice #4',
                    dueDate: '05 Aug • 5 day(s) to due',
                    amount: '₹ 3,450',
                    status: 'Paid',
                    isTablet: isTablet,
                  ),
                  SizedBox(height: 8),
                  _InvoiceTransactionItem(
                    customerName: 'Anita Patel 🌟',
                    invoiceNumber: 'Invoice #6',
                    dueDate: '07 Aug • 7 day(s) to due',
                    amount: '₹ 890',
                    status: 'Unpaid',
                    isTablet: isTablet,
                  ),
                  SizedBox(height: 8),
                  _InvoiceTransactionItem(
                    customerName: 'Vikram Singh 💼',
                    invoiceNumber: 'Invoice #7',
                    dueDate: '08 Aug • 8 day(s) to due',
                    amount: '₹ 2,100',
                    status: 'Overdue',
                    isTablet: isTablet,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBusinessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom,
          ),
          child: _BusinessBottomSheet(),
        );
      },
    );
  }

  void _showContactUsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Talk To Our Expert',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Description text
                Text(
                  'Need help getting started or have questions about features, setup, or business support?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 20),
                // Speak With Expert option
                _ContactOption(
                  icon: Icons.phone,
                  title: 'Speak With Expert',
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: Implement phone call functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Calling expert...')),
                    );
                  },
                ),
                SizedBox(height: 12),
                // Chat With Expert option
                _ContactOption(
                  icon: Icons.chat,
                  title: 'Chat With Expert',
                  isWhatsApp: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: Implement WhatsApp chat functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening WhatsApp chat...')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Update _CompactDashboardCard to support arrow indicators
class _TopRowCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _TopRowCard({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  State<_TopRowCard> createState() => _TopRowCardState();
}

class _TopRowCardState extends State<_TopRowCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width:
                  MediaQuery.of(context).size.width *
                  0.44, // Slightly wider for better proportions
              height: 110, // Slightly shorter for better proportions
              decoration: BoxDecoration(
                color: Colors.white, // Clean white background
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isPressed ? 0.12 : 0.08),
                    blurRadius: _isPressed ? 24 : 20,
                    offset: Offset(0, _isPressed ? 6 : 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(_isPressed ? 0.06 : 0.04),
                    blurRadius: _isPressed ? 10 : 8,
                    offset: Offset(0, _isPressed ? 3 : 2),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(_isPressed ? 0.18 : 0.12),
                  width: _isPressed ? 1.2 : 1,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular icon container with professional styling
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [widget.color, widget.color.withOpacity(0.8)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(
                            _isPressed ? 0.35 : 0.25,
                          ),
                          blurRadius: _isPressed ? 10 : 8,
                          offset: Offset(0, _isPressed ? 3 : 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 20),
                  ),

                  // Title and arrow in same row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title text with professional styling
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            letterSpacing: 0.2,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Professional arrow indicator
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[_isPressed ? 150 : 100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey[_isPressed ? 700 : 600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CompactDashboardCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String value;
  final Color color;
  final String? subtitle;
  final bool small;
  final bool rightArrow;
  final Color? valueColor;
  final bool showArrow;
  final String arrowDirection;
  final Color primaryColor;
  final bool showIcon;

  const _CompactDashboardCard({
    this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.subtitle,
    this.small = false,
    this.rightArrow = false,
    this.valueColor,
    this.showArrow = false,
    this.arrowDirection = 'down',
    required this.primaryColor,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final double valueSize = small ? 15 : 18;
    final double subtitleSize = small ? 10 : 12;
    final double paddingV = small ? 10 : 16;
    final double paddingH = small ? 10 : 16;

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2), width: 1.2),
      ),
      padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
      constraints: BoxConstraints(minHeight: 72),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showIcon && icon != null) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 20),
            ),
            SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? color,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: subtitleSize,
                          fontWeight:
                              (subtitle == 'To Collect' || subtitle == 'To Pay')
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                          color:
                              subtitle == 'To Collect'
                                  ? Colors.green[700]
                                  : subtitle == 'To Pay'
                                  ? Colors.red[700]
                                  : valueColor?.withOpacity(0.8) ??
                                      primaryColor.withOpacity(0.8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (showArrow) ...[
                        SizedBox(width: 4),
                        Icon(
                          arrowDirection == 'down'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 12,
                          color:
                              subtitle == 'To Collect'
                                  ? Colors.green[700]
                                  : Colors.red[700],
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (rightArrow)
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
        ],
      ),
    );
  }
}

class _BusinessBottomSheet extends StatelessWidget {
  // App theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Change Business',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                context,
                'Edit Business',
                Icons.edit,
                primaryColor,
                () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to edit business
                },
              ),
              _buildActionButton(
                context,
                'Add New Business',
                Icons.add_business,
                secondaryColor,
                () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to add new business
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          label: Text(label, style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isWhatsApp;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isWhatsApp = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child:
                  isWhatsApp
                      ? Icon(Icons.message, color: Colors.green[600], size: 20)
                      : Icon(icon, color: Colors.black87, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New widget for invoice transaction items
class _InvoiceTransactionItem extends StatelessWidget {
  final String customerName;
  final String invoiceNumber;
  final String dueDate;
  final String amount;
  final String status;
  final bool isTablet;

  const _InvoiceTransactionItem({
    required this.customerName,
    required this.invoiceNumber,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.isTablet,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green[700]!;
      case 'unpaid':
        return Colors.red[700]!;
      case 'overdue':
        return Colors.orange[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer name
          Text(
            customerName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          // Invoice details and amount/status row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoiceNumber,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 2),
                    Text(
                      dueDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Handle Record Manually action
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 14,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Record Manually',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Handle Share Payment Link action
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message, size: 14, color: Colors.green[600]),
                        SizedBox(width: 4),
                        Text(
                          'Share Payment Link',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
