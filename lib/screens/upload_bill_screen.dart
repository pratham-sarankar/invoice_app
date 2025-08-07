import 'package:flutter/material.dart';

class UploadBillScreen extends StatefulWidget {
  const UploadBillScreen({super.key});

  @override
  State<UploadBillScreen> createState() => _UploadBillScreenState();
}

class _UploadBillScreenState extends State<UploadBillScreen> {
  final TextEditingController _invoiceNoController = TextEditingController(text: '1');
  final TextEditingController _purchaseDateController = TextEditingController(text: '7-8-2025');
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _sellerNameController = TextEditingController();

  @override
  void dispose() {
    _invoiceNoController.dispose();
    _purchaseDateController.dispose();
    _amountController.dispose();
    _sellerNameController.dispose();
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
          'Upload Bill',
          style: TextStyle(
            color: Colors.black,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Purchase Invoice No. Field
            _buildInputField(
              label: 'Purchase Invoice No.',
              controller: _invoiceNoController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Purchase Date Field
            _buildInputField(
              label: 'Purchase Date',
              controller: _purchaseDateController,
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),

            // Seller Details Section
            Text(
              'Seller Details',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Add Seller Button
            InkWell(
              onTap: () => _showSellerDialog(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: colorScheme.primary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _sellerNameController.text.isEmpty ? 'Add Seller' : _sellerNameController.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _sellerNameController.text.isEmpty 
                              ? colorScheme.onSurface.withOpacity(0.6) 
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Amount Field
            _buildInputField(
              label: 'Amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefix: '₹',
            ),
            const SizedBox(height: 16),

            // Upload Bills Section
            Text(
              'Upload Bills',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Upload Area
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.3),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () => _uploadFile(),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload bill',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'PDF, JPG, PNG (Max 10MB)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.4),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitBill(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Submit Bill',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
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
    String? prefix,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              prefixText: prefix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.4),
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

  void _showSellerDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Seller',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter seller name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
            ),
            onSubmitted: (value) {
              setState(() {
                _sellerNameController.text = value;
              });
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _sellerNameController.text = 'Sample Seller';
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _uploadFile() {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Show file picker options
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select File Source',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _selectFromGallery();
                      },
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
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
                        Navigator.of(context).pop();
                        _selectFromCamera();
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
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
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _selectFromDocuments();
                  },
                  icon: const Icon(Icons.folder),
                  label: const Text('Documents'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectFromGallery() {
    // TODO: Implement gallery file picker
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Gallery file picker will be implemented'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _selectFromCamera() {
    // TODO: Implement camera capture
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Camera capture will be implemented'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _selectFromDocuments() {
    // TODO: Implement document picker
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Document picker will be implemented'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  void _submitBill() {
    // TODO: Implement bill submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bill submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }
} 