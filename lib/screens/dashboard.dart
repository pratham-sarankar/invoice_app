import 'package:flutter/material.dart';

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
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: primaryColor,
                  size: 20,
                ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.today,
                    color: primaryColor,
                    size: isTablet ? 20 : 16, // Smaller icon
                  ),
                  SizedBox(width: 6), // Less spacing
                  Text(
                    'Daily Overview',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // --- Dashboard Cards Section (like screenshot) ---
              GridView.count(
                crossAxisCount: isTablet ? 3 : 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.3,
                children: [
                  // To Collect Card (no icon, price first, then label)
                  _CompactDashboardCard(
                    icon: null, // No icon
                    title: '', // No title at top
                    value: '₹ 0',
                    color: Colors.green[100]!,
                    subtitle: 'To Collect',
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.green[900],
                  ),
                  // To Pay Card (no icon, price first, then label)
                  _CompactDashboardCard(
                    icon: null, // No icon
                    title: '', // No title at top
                    value: '₹ 0',
                    color: Colors.red[100]!,
                    subtitle: 'To Pay',
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.red[900],
                  ),
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: '₹ 0',
                    color: Colors.blue[100]!,
                    subtitle: "This week's sale",
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.blue[900],
                  ),
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: 'Total Balance',
                    color: Colors.blueGrey[100]!,
                    subtitle: 'Cash + Bank',
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.blueGrey[900],
                  ),
                  _CompactDashboardCard(
                    icon: null,
                    title: '',
                    value: 'Reports',
                    color: Colors.blueGrey[100]!,
                    subtitle: 'Sales, Party, GST',
                    small: true,
                    rightArrow: true,
                    valueColor: Colors.blueGrey[900],
                  ),
                ],
              ),
              SizedBox(height: 18),
              // Transactions Section Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: primaryColor,
                    size: isTablet ? 20 : 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to transactions list
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Transactions List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Sample Transaction Items
                    _TransactionItem(
                      title: 'Table 4',
                      amount: '₹ 450',
                      time: '2:30 PM',
                      isCredit: true,
                      isTablet: isTablet,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    _TransactionItem(
                      title: 'Table 2',
                      amount: '₹ 850',
                      time: '1:45 PM',
                      isCredit: true,
                      isTablet: isTablet,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    _TransactionItem(
                      title: 'Vendor Payment',
                      amount: '₹ 2,000',
                      time: '11:20 AM',
                      isCredit: false,
                      isTablet: isTablet,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 18),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ElevatedButton.icon(
              //         onPressed:
              //             () => Navigator.pushNamed(context, '/create-invoice'),
              //         icon: Icon(
              //           Icons.add,
              //           size: isTablet ? 22 : 18,
              //           color: Colors.white,
              //         ),
              //         label: Text(
              //           'New Invoice',
              //           style: TextStyle(
              //             fontSize: isTablet ? 18 : 16,
              //             fontWeight: FontWeight.bold,
              //             letterSpacing: 0.1,
              //             color: Colors.white,
              //           ),
              //         ),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.deepOrange,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(6),
              //           ),
              //           elevation: 0,
              //           padding: EdgeInsets.symmetric(
              //             vertical: isTablet ? 16 : 12,
              //           ),
              //           textStyle: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 14),
              // Section for Menu and Sales
              // Container(
              //   width: double.infinity,
              //   child: Column(
              //     children: [
              //       InkWell(
              //         borderRadius: BorderRadius.circular(14),
              //         onTap:
              //             () =>
              //                 Navigator.pushNamed(context, '/menu-management'),
              //         child: Container(
              //           width: double.infinity,
              //           margin: EdgeInsets.only(bottom: 14),
              //           padding: EdgeInsets.symmetric(
              //             vertical: isTablet ? 18 : 14,
              //             horizontal: isTablet ? 18 : 12,
              //           ),
              //           decoration: BoxDecoration(
              //             color: Colors.white, // Simple white background
              //             borderRadius: BorderRadius.circular(14),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.deepOrange.withOpacity(0.07),
              //                 blurRadius: 8,
              //                 offset: Offset(0, 2),
              //               ),
              //             ],
              //             border: Border.all(
              //               color: Colors.deepOrange.withOpacity(0.15),
              //               width: 1.2,
              //             ),
              //           ),
              //           child: Row(
              //             children: [
              //               Container(
              //                 width: isTablet ? 38 : 32,
              //                 height: isTablet ? 38 : 32,
              //                 decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.deepOrange.withOpacity(0.10),
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.fastfood,
              //                     color: Colors.deepOrange,
              //                     size: isTablet ? 22 : 18,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(width: 12),
              //               Expanded(
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'Menu',
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: isTablet ? 18 : 15,
              //                         color: Colors.black87,
              //                       ),
              //                     ),
              //                     SizedBox(height: 2),
              //                     Text(
              //                       'Edit menu',
              //                       style: TextStyle(
              //                         fontSize: isTablet ? 13 : 11,
              //                         color: Colors.grey[700],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               Icon(
              //                 Icons.arrow_forward_ios,
              //                 size: isTablet ? 18 : 14,
              //                 color: Colors.deepOrange,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         borderRadius: BorderRadius.circular(14),
              //         onTap:
              //             () => Navigator.pushNamed(context, '/sales-report'),
              //         child: Container(
              //           width: double.infinity,
              //           padding: EdgeInsets.symmetric(
              //             vertical: isTablet ? 18 : 14,
              //             horizontal: isTablet ? 18 : 12,
              //           ),
              //           decoration: BoxDecoration(
              //             color: Colors.white, // Simple white background
              //             borderRadius: BorderRadius.circular(14),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.blue.withOpacity(0.07),
              //                 blurRadius: 8,
              //                 offset: Offset(0, 2),
              //               ),
              //             ],
              //             border: Border.all(
              //               color: Colors.blue.withOpacity(0.15),
              //               width: 1.2,
              //             ),
              //           ),
              //           child: Row(
              //             children: [
              //               Container(
              //                 width: isTablet ? 38 : 32,
              //                 height: isTablet ? 38 : 32,
              //                 decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.blue.withOpacity(0.10),
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.bar_chart,
              //                     color: Colors.blue[700],
              //                     size: isTablet ? 22 : 18,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(width: 12),
              //               Expanded(
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'Sales',
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: isTablet ? 18 : 15,
              //                         color: Colors.black87,
              //                       ),
              //                     ),
              //                     SizedBox(height: 2),
              //                     Text(
              //                       'Analytics',
              //                       style: TextStyle(
              //                         fontSize: isTablet ? 13 : 11,
              //                         color: Colors.grey[700],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               Icon(
              //                 Icons.arrow_forward_ios,
              //                 size: isTablet ? 18 : 14,
              //                 color: Colors.blue[700],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
      backgroundColor: Colors.transparent,
      builder: (context) => _BusinessBottomSheet(),
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

// Update _CompactDashboardCard to allow icon to be nullable and render cards without icon or title for To Collect and To Pay
class _CompactDashboardCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String value;
  final Color color;
  final String? subtitle;
  final bool small;
  final bool rightArrow;
  final Color? valueColor;

  const _CompactDashboardCard({
    this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.subtitle,
    this.small = false,
    this.rightArrow = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = small ? 16 : 22;
    final double titleSize = small ? 13 : 15;
    final double valueSize = small ? 15 : 18;
    final double subtitleSize = small ? 10 : 12;
    final double paddingV = small ? 10 : 16;
    final double paddingH = small ? 10 : 16;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.18), width: 1.2),
      ),
      padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
      constraints: BoxConstraints(minHeight: 72),
      child:
          title.isEmpty
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                      (subtitle == 'To Collect' ||
                                              subtitle == 'To Pay')
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                  color:
                                      subtitle == 'To Collect'
                                          ? Colors.green[700]
                                          : subtitle == 'To Pay'
                                          ? Colors.red[700]
                                          : Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (subtitle == 'To Collect')
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    size: 12,
                                    color: Colors.green[700],
                                  ),
                                )
                              else if (subtitle == 'To Pay')
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    size: 12,
                                    color: Colors.red[700],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (rightArrow)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                ],
              )
              : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null || title.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (icon != null)
                          Container(
                            width: small ? 32 : 38,
                            height: small ? 32 : 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withOpacity(0.10),
                            ),
                            child: Center(
                              child: Icon(icon, color: color, size: iconSize),
                            ),
                          ),
                        if (icon != null) SizedBox(width: 8),
                        if (title.isNotEmpty)
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: titleSize,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  if (icon != null || title.isNotEmpty) SizedBox(height: 8),
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
                      children: [
                        Expanded(
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                              fontSize: subtitleSize,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (rightArrow)
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                      ],
                    ),
                  ] else if (rightArrow)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                ],
                     ),
     );
   }

   void _showBusinessBottomSheet(BuildContext context) {
     showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (context) => _BusinessBottomSheet(),
     );
   }
}

class _BusinessBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 8),
            width: 32,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
                     // Header
           Padding(
             padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
             child: Row(
               children: [
                 Expanded(
                   child: Text(
                     'Change Business',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                       color: Colors.black87,
                     ),
                     textAlign: TextAlign.left,
                   ),
                 ),
                 IconButton(
                   onPressed: () => Navigator.pop(context),
                   icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                   padding: EdgeInsets.zero,
                   constraints: BoxConstraints(),
                 ),
               ],
             ),
           ),
           // Instructional text
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 16),
             child: Text(
               'Choose the business you want to see the data',
               style: TextStyle(
                 fontSize: 13,
                 color: Colors.grey[600],
               ),
               textAlign: TextAlign.left,
             ),
           ),
          SizedBox(height: 12),
          // Business list
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'B',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Business Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to edit business
                    },
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E3085),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          // Add new business button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFF2E3085),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Add New Business',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
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
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: isWhatsApp
                  ? Icon(
                      Icons.message,
                      color: Colors.green[600],
                      size: 20,
                    )
                  : Icon(
                      icon,
                      color: Colors.black87,
                      size: 20,
                    ),
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

class _TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String time;
  final bool isCredit;
  final bool isTablet;

  const _TransactionItem({
    required this.title,
    required this.amount,
    required this.time,
    required this.isCredit,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 16 : 12,
        vertical: isTablet ? 14 : 10,
      ),
      child: Row(
        children: [
          Container(
            width: isTablet ? 38 : 32,
            height: isTablet ? 38 : 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCredit ? Colors.green[50] : Colors.red[50],
            ),
            child: Center(
              child: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? Colors.green[700] : Colors.red[700],
                size: isTablet ? 18 : 14,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isCredit ? Colors.green[700] : Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }
}
