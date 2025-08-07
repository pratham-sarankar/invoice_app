import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManageCompaniesScreen extends StatefulWidget {
  const ManageCompaniesScreen({super.key});

  @override
  State<ManageCompaniesScreen> createState() => _ManageCompaniesScreenState();
}

class _ManageCompaniesScreenState extends State<ManageCompaniesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // Sample company data
  final List<Map<String, dynamic>> myCompanies = [
    {
      'name': 'Act t Connect',
      'id': '1234567890',
      'status': 'active',
    },
  ];

  final List<Map<String, dynamic>> sharedCompanies = [
    // Add shared companies here when needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: theme.scaffoldBackgroundColor,
        statusBarIconBrightness: theme.brightness == Brightness.light 
            ? Brightness.dark 
            : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: _buildAppBar(theme),
        body: Column(
          children: [
            _buildTabBar(theme),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMyCompaniesTab(theme),
                  _buildSharedWithMeTab(theme),
                ],
              ),
            ),
            _buildBottomActionButtons(theme),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onSurface,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.all(8),
        ),
      ),
      title: Text(
        'Manage Companies',
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Refresh functionality
            setState(() {});
          },
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.refresh,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.7),
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: theme.textTheme.labelMedium?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: theme.textTheme.labelMedium?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        dividerColor: Colors.transparent,
                 tabs: const [
           Tab(text: 'My Companies'),
           Tab(text: 'Shared With Me'),
         ],
      ),
    );
  }

  Widget _buildMyCompaniesTab(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: myCompanies.length,
      itemBuilder: (context, index) {
        final company = myCompanies[index];
        return _buildCompanyCard(company, theme);
      },
    );
  }

  Widget _buildSharedWithMeTab(ThemeData theme) {
    if (sharedCompanies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_center_outlined,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No shared companies',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sharedCompanies.length,
      itemBuilder: (context, index) {
        final company = sharedCompanies[index];
        return _buildCompanyCard(company, theme);
      },
    );
  }

  Widget _buildCompanyCard(Map<String, dynamic> company, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          company['name'],
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: company['status'] == 'active' 
                                ? Colors.green 
                                : theme.colorScheme.onSurface.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company['id'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _showCompanyOptions(company, theme);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              text: 'Restore backup',
              icon: Icons.restore,
              isPrimary: false,
              onTap: () {
                _restoreBackup();
              },
              theme: theme,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              text: 'Add Company',
              icon: Icons.add,
              isPrimary: true,
              onTap: () {
                _addCompany();
              },
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isPrimary ? theme.colorScheme.surface : theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.surface,
                size: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPrimary ? theme.colorScheme.surface : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions(ThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.settings, color: theme.colorScheme.onSurface),
              title: Text('Settings', style: theme.textTheme.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline, color: theme.colorScheme.onSurface),
              title: Text('Help & Support', style: theme.textTheme.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                // Navigate to help
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCompanyOptions(Map<String, dynamic> company, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: theme.colorScheme.onSurface),
              title: Text('Rename Company', style: theme.textTheme.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                _renameCompany(company);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: theme.colorScheme.error),
              title: Text('Delete Company', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                _deleteCompany(company);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _restoreBackup() {
    // Implement restore backup functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Restore backup functionality will be implemented'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _addCompany() {
    // Navigate to add company screen
    Navigator.pushNamed(context, '/add-company');
  }

  void _renameCompany(Map<String, dynamic> company) {
    final TextEditingController nameController = TextEditingController(text: company['name']);
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rename Company',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  hintText: 'Enter new company name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Company renamed successfully'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Rename',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.surface,
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

  void _editCompany(Map<String, dynamic> company) {
    // Navigate to edit company screen
    Navigator.pushNamed(context, '/edit-company', arguments: company);
  }

  void _syncCompany(Map<String, dynamic> company) {
    // Implement sync functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Syncing ${company['name']}...'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _deleteCompany(Map<String, dynamic> company) {
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delete Company',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: theme.colorScheme.error,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Are you sure you want to delete "${company['name']}"? This action cannot be undone.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        myCompanies.remove(company);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${company['name']} deleted successfully'),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.surface,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 