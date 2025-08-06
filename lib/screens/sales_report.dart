import 'package:flutter/material.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> invoices = [
    {'date': '01/08/2025', 'total': 1200.0, 'payment': 'Cash'},
    {'date': '01/08/2025', 'total': 800.0, 'payment': 'Card'},
    {'date': '31/07/2025', 'total': 1500.0, 'payment': 'UPI'},
  ];
  String filterDate = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.bar_chart, color: Colors.deepOrange),
            SizedBox(width: 8),
            Text(
              'Sales Report',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepOrange,
          tabs: [Tab(text: 'Daily'), Tab(text: 'Weekly'), Tab(text: 'Monthly')],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card(
            //   color: Colors.white,
            //   elevation: 1,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 12,
            //       vertical: 8,
            //     ),
            //     child: TextField(
            //       decoration: InputDecoration(
            //         labelText: 'Filter by date',
            //         prefixIcon: Icon(
            //           Icons.calendar_today,
            //           color: Colors.deepOrange,
            //         ),
            //         border: InputBorder.none,
            //       ),
            //       onChanged: (val) => setState(() => filterDate = val),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Export feature coming soon')),
                  );
                },
                icon: Icon(Icons.download, color: Colors.deepOrange),
                label: Text(
                  'Export',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.deepOrange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildInvoiceList('Daily'),
                      _buildInvoiceList('Weekly'),
                      _buildInvoiceList('Monthly'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceList(String period) {
    final theme = Theme.of(context);
    final filtered =
        filterDate.isEmpty
            ? invoices
            : invoices
                .where((inv) => inv['date'].toString().contains(filterDate))
                .toList();
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final inv = filtered[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange[50],
              child: Icon(Icons.receipt_long, color: Colors.deepOrange),
            ),
            title: Text(
              '₹${inv['total']}',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${inv['date']} • ${inv['payment']}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.deepOrange,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
