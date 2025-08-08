import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteEarnScreen extends StatelessWidget {
  const InviteEarnScreen({super.key});

  // App theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
               color: primaryColor,
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
          'Invite & Earn',
          style: TextStyle(
            color: primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: primaryColor, size: 20),
            onPressed: () {
              // TODO: Show info dialog
            },
          ),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.18),
            width: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Header Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Share & Earn Rewards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Invite fellow business owners and both of you benefit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Referral Code Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Your Referral Code',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: primaryColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'XXQUGB',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                                                         Container(
                               padding: const EdgeInsets.symmetric(
                                 horizontal: 16,
                                 vertical: 10,
                               ),
                               decoration: BoxDecoration(
                                 color: primaryColor,
                                 borderRadius: BorderRadius.circular(6),
                               ),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Icon(
                                     Icons.copy,
                                     color: Colors.white,
                                     size: 16,
                                   ),
                                   const SizedBox(width: 6),
                                   const Text(
                                     'Copy',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement share functionality
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 16,
                            ),
                            label: const Text(
                              'Share Referral Code',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.monetization_on,
                    title: 'You Earn',
                    value: '₹501',
                    color: Colors.green[700]!,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_offer,
                    title: 'They Get',
                    value: '15% Off',
                    color: Colors.orange[700]!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
                         // How it works Section
             Container(
               width: double.infinity,
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(
                   color: Colors.grey.withOpacity(0.15),
                   width: 1,
                 ),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.04),
                     blurRadius: 8,
                     offset: const Offset(0, 2),
                   ),
                 ],
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Container(
                         padding: const EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           color: primaryColor.withOpacity(0.1),
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Icon(
                           Icons.help_outline_rounded,
                           color: primaryColor,
                           size: 20,
                         ),
                       ),
                       const SizedBox(width: 12),
                       const Text(
                         'How it works',
                         style: TextStyle(
                           color: Colors.black87,
                           fontSize: 18,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 20),
                                                                                                                                                                                                                                               _buildStep(
                         stepIcon: Icons.share_rounded,
                         title: '',
                         description: 'Share the referral code with other businessman',
                       ),
                       const SizedBox(height: 16),
                       _buildStep(
                         stepIcon: Icons.download_rounded,
                         title: '',
                         description: 'They download the app and buy the plan',
                       ),
                       const SizedBox(height: 16),
                       _buildStep(
                         stepIcon: Icons.card_giftcard_rounded,
                         title: '',
                         description: 'You earn ₹501, they get 15% off',
                       ),
                 ],
               ),
             ),
       
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            // TODO: Implement invite functionality
          },
          icon: const Icon(
            Icons.person_add,
            color: Colors.white,
            size: 18,
          ),
          label: const Text(
            'Invite Friends',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

     Widget _buildStep({
     required IconData stepIcon,
     required String title,
     required String description,
   }) {
           return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
           width: 28,
           height: 28,
           decoration: BoxDecoration(
             gradient: LinearGradient(
               colors: [primaryColor, secondaryColor],
             ),
             borderRadius: BorderRadius.circular(14),
             boxShadow: [
               BoxShadow(
                 color: primaryColor.withOpacity(0.3),
                 blurRadius: 4,
                 offset: const Offset(0, 2),
               ),
             ],
           ),
           child: Center(
             child: Icon(
               stepIcon,
               color: Colors.white,
               size: 16,
             ),
           ),
         ),
         const SizedBox(width: 16),
                  Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
                ],
       );
     }
   }        