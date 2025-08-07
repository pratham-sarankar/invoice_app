import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class CreatePurchaseScreen extends StatefulWidget {
  const CreatePurchaseScreen({super.key});

  @override
  State<CreatePurchaseScreen> createState() => _CreatePurchaseScreenState();
}

class _CreatePurchaseScreenState extends State<CreatePurchaseScreen> {
  final TextEditingController _purchaseDateController = TextEditingController(text: '7-8-2025');
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _purchaseNumberController = TextEditingController(text: '1');
  
  // Radio button values
  String _selectedInvoiceType = 'Tax Invoice';
  String _selectedConsigneeOption = 'Show Consignee (Same as above)';
  
  // Signature controller
  late SignatureController _signatureController;
  bool _hasSignature = false;
  String? _signaturePath;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: const Color(0xFF2E3085),
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _purchaseDateController.dispose();
    _prefixController.dispose();
    _purchaseNumberController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme.primary,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ),
        title: Text(
          'Create Purchase',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.18),
            width: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Purchase Details Section
            _buildSectionHeader('Purchase Details'),
            const SizedBox(height: 6),
            
            // Invoice Type Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Tax Invoice',
                  groupValue: _selectedInvoiceType,
                  onChanged: (value) {
                    setState(() {
                      _selectedInvoiceType = value!;
                    });
                  },
                  activeColor: colorScheme.primary,
                ),
                Text('Tax Invoice', style: theme.textTheme.bodyMedium),
                const SizedBox(width: 24),
                Radio<String>(
                  value: 'Bill of Supply',
                  groupValue: _selectedInvoiceType,
                  onChanged: (value) {
                    setState(() {
                      _selectedInvoiceType = value!;
                    });
                  },
                  activeColor: colorScheme.primary,
                ),
                Text('Bill of Supply', style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 8),
            
            // Purchase Date, Prefix, and Purchase Number in a row
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Purchase Date',
                    controller: _purchaseDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildInputField(
                    label: 'Prefix',
                    controller: _prefixController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildInputField(
                    label: 'Purchase',
                    controller: _purchaseNumberController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Firm Details Section
            _buildSectionHeader('Firm Details'),
            const SizedBox(height: 6),
            Row(
              children: [
                Text('My Company', style: theme.textTheme.bodyMedium),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: colorScheme.onPrimary,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Seller Details Section
            _buildSectionHeader('Seller Details'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.person_add, color: colorScheme.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Add Seller',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.menu, color: colorScheme.primary, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Consignee Details Section
            _buildSectionHeader('Consignee Details'),
            const SizedBox(height: 6),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('Show Consignee (Same as above)', style: theme.textTheme.bodyMedium),
                  value: 'Show Consignee (Same as above)',
                  groupValue: _selectedConsigneeOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedConsigneeOption = value!;
                    });
                  },
                  activeColor: colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  title: Text('Consignee Not Required', style: theme.textTheme.bodyMedium),
                  value: 'Consignee Not Required',
                  groupValue: _selectedConsigneeOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedConsigneeOption = value!;
                    });
                  },
                  activeColor: colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  title: Text('Add Consignee (If different from above)', style: theme.textTheme.bodyMedium),
                  value: 'Add Consignee (If different from above)',
                  groupValue: _selectedConsigneeOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedConsigneeOption = value!;
                    });
                  },
                  activeColor: colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Product Details Section
            _buildSectionHeader('Product Details'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: colorScheme.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Add Product',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Transportation Details Section
            _buildSectionHeader('Transportation Details (Optional)'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: colorScheme.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Add Transportation details',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Other Details Section
            _buildSectionHeader('Other Details (Optional)'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: colorScheme.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Add Other Details',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Bank Details Section
            _buildSectionHeader('Bank Details (Optional)'),
            const SizedBox(height: 6),
            _buildInputField(
              label: 'Account Holder Name',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 8),
            _buildInputField(
              label: 'Bank Account Number',
              controller: TextEditingController(),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            _buildInputField(
              label: 'Bank IFSC',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 8),
            _buildInputField(
              label: 'Branch Name',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 8),
            _buildInputField(
              label: 'Bank Name',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 12),
            
            // Terms and Conditions Section
            _buildSectionHeader('Terms and Conditions'),
            const SizedBox(height: 6),
            Text(
              'This is an electronically generated document',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 12),
            
            // Add Signature Section
            _buildSectionHeader('Add Signature (Optional)'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _hasSignature
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Signature added successfully',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.draw,
                          color: colorScheme.onSurface.withOpacity(0.4),
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create or upload your signature',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.4),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            _hasSignature
                ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showSignatureDialog();
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit Signature'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _removeSignature();
                          },
                          icon: const Icon(Icons.delete, size: 18),
                          label: const Text('Remove'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[50],
                            foregroundColor: Colors.red[700],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showSignatureDialog();
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Create Signature'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _uploadSignature();
                          },
                          icon: const Icon(Icons.upload, size: 18),
                          label: const Text('Upload Signature'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitPurchase(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Create Purchase',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
      ),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              readOnly: readOnly,
              onTap: onTap,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
                  fontSize: 12,
                ),
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _purchaseDateController.text = '${picked.day}-${picked.month}-${picked.year}';
      });
    }
  }

  void _submitPurchase() {
    // TODO: Implement purchase creation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Purchase created successfully!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
    Navigator.of(context).pop();
  }

  void _showSignatureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.maxFinite,
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create Signature',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Signature(
                      controller: _signatureController,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _signatureController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.grey[700],
                        ),
                        child: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final signature = await _signatureController.toPngBytes();
                            if (signature != null) {
                              setState(() {
                                _hasSignature = true;
                              });
                              
                              if (mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Signature created successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to create signature'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E3085),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _uploadSignature() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Opening gallery...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      
      // Simulate file picker
      await Future.delayed(const Duration(seconds: 1));
      
      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      setState(() {
        _hasSignature = true;
        _signaturePath = 'uploaded_signature.png';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signature uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if still open
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload signature'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeSignature() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Signature'),
          content: const Text('Are you sure you want to remove your signature? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _hasSignature = false;
                  _signaturePath = null;
                });
                
                Navigator.of(context).pop();
                
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signature removed successfully'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
} 