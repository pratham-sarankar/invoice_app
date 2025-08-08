import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReminderSettingsScreen extends StatefulWidget {
  const ReminderSettingsScreen({super.key});

  @override
  State<ReminderSettingsScreen> createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  // Theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);
  static const Color borderColor = Color(0xFFE9ECEF);
  static const Color whatsappGreen = Color(0xFF25D366);

  // Toggle states
  bool _sendSmsToParty = true;
  bool _paymentReminderDueDate = true;
  bool _yourPaymentReminder = true;
  bool _dailyOutstandingPayments = true;
  bool _dailySalesSummary = true;
  bool _lowStockAlert = true;
  bool _serviceReminder = false;
  bool _birthdayReminders = false;
  bool _whatsappAlert = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: primaryColor,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(8),
                minimumSize: const Size(32, 32),
              ),
            ),
          ),
          title: Text(
            'Reminder Settings',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: borderColor,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildPartyRemindersSection(),
                  const SizedBox(height: 12),
                  _buildYourRemindersSection(),
                  const SizedBox(height: 12),
                  _buildWhatsappReminderSection(),
                  const SizedBox(height: 80), // Space for bottom navigation
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartyRemindersSection() {
    return _buildSection(
      'Party Reminders',
      [
        _buildReminderTile(
          icon: Icons.sms,
          iconColor: primaryColor,
          title: 'Send SMS to party on creating transactions',
          value: _sendSmsToParty,
          onChanged: (value) => setState(() => _sendSmsToParty = value),
        ),
        _buildReminderTile(
          icon: Icons.payment,
          iconColor: primaryColor,
          title: 'Payment Reminder on due date',
          value: _paymentReminderDueDate,
          onChanged: (value) => setState(() => _paymentReminderDueDate = value),
        ),
      ],
    );
  }

  Widget _buildYourRemindersSection() {
    return _buildSection(
      'Your Reminders',
      [
        _buildReminderTile(
          icon: Icons.notifications,
          iconColor: primaryColor,
          title: 'Payment Reminder on due date',
          value: _yourPaymentReminder,
          onChanged: (value) => setState(() => _yourPaymentReminder = value),
        ),
        _buildReminderTile(
          icon: Icons.account_balance_wallet,
          iconColor: primaryColor,
          title: 'Daily Outstanding Payments',
          value: _dailyOutstandingPayments,
          onChanged: (value) => setState(() => _dailyOutstandingPayments = value),
        ),
        _buildReminderTile(
          icon: Icons.assessment,
          iconColor: primaryColor,
          title: 'Daily Sales Summary',
          value: _dailySalesSummary,
          onChanged: (value) => setState(() => _dailySalesSummary = value),
        ),
        _buildReminderTile(
          icon: Icons.inventory,
          iconColor: primaryColor,
          title: 'Low stock alert',
          value: _lowStockAlert,
          onChanged: (value) => setState(() => _lowStockAlert = value),
        ),
      ],
    );
  }

  Widget _buildWhatsappReminderSection() {
    return _buildSection(
      'Whatsapp Reminder',
      [
        _buildReminderTile(
          icon: Icons.build,
          iconColor: primaryColor,
          title: 'Reminder for service on due date',
          subtitle: 'Reminder will be sent to you & your party 3 days before servicing date',
          value: _serviceReminder,
          onChanged: (value) => setState(() => _serviceReminder = value),
        ),
        _buildReminderTile(
          icon: Icons.cake,
          iconColor: primaryColor,
          title: 'Birthday reminders',
          value: _birthdayReminders,
          onChanged: (value) => setState(() => _birthdayReminders = value),
        ),
        _buildReminderTile(
          icon: Icons.chat,
          iconColor: whatsappGreen,
          title: 'WhatsApp Alert',
          subtitle: 'Get reminders for collecting payments',
          value: _whatsappAlert,
          onChanged: (value) => setState(() => _whatsappAlert = value),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              final index = entry.key;
              final child = entry.value;
              return Column(
                children: [
                  child,
                  if (index < children.length - 1)
                    const Divider(height: 1, color: borderColor),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: primaryColor,
                activeTrackColor: primaryColor.withOpacity(0.2),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFFE0E0E0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return primaryColor.withOpacity(0.1);
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 