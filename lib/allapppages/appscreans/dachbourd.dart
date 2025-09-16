import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterlearniti/core/mytheme.dart';
import 'package:flutterlearniti/custom/advaneddrawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }
  
  void _getCurrentUser() {
    setState(() {
      currentUser = _auth.currentUser;
    });
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          currentUser = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return _buildNotLoggedInView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: MyPaperbackTheme.white),
            onPressed: () {
              _refreshUserData();
            },
          ),
        ],
      ),
      drawer: AdvancedDrawer(),

      body: _buildProfileContent(),
    );
  }

  // Build content when not logged in
  Widget _buildNotLoggedInView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
              color: MyPaperbackTheme.textDark,
            ),
            SizedBox(height: 20),
            Text(
              'You are not logged in',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'Please login to view your profile',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyPaperbackTheme.textDark,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToLogin(),
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToRegister(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyPaperbackTheme.yellow,
                    foregroundColor: MyPaperbackTheme.bgDark,
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build main profile content
  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile header
          _buildProfileHeader(),
          
          SizedBox(height: 20),
          
          // Account information
          _buildAccountInfoSection(),
          
          SizedBox(height: 20),
          
          // Security section
          _buildSecuritySection(),
          
          SizedBox(height: 20),
          
          // Action buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  // Build profile header with Firebase Auth data
  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyPaperbackTheme.bgDarker,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile picture
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: MyPaperbackTheme.textDark,
                backgroundImage: currentUser!.photoURL != null
                    ? NetworkImage(currentUser!.photoURL!)
                    : null,
                child: currentUser!.photoURL == null
                    ? Icon(Icons.person, size: 60, color: MyPaperbackTheme.bgDark)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showUpdatePhotoDialog(),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: MyPaperbackTheme.primaryRed,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: MyPaperbackTheme.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 15),
          
          // Display Name
          Text(
            currentUser!.displayName ?? 'No Name Set',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          
          SizedBox(height: 5),
          
          // Email
          Text(
            currentUser!.email ?? 'No Email',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: MyPaperbackTheme.textDark,
            ),
          ),
          
          SizedBox(height: 10),
          
          // User ID (for developers)
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //   decoration: BoxDecoration(
          //     color: MyPaperbackTheme.bgDark,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Text(
          //     'ID: ${currentUser!.uid.substring(0, 8)}...',
          //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //       fontFamily: 'monospace',
          //     ),
          //   ),
          // ),
          
          // SizedBox(height: 10),
          
          // // Verification badges
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // Email verification badge
          //     _buildVerificationBadge(
          //       icon: Icons.email,
          //       label: currentUser!.emailVerified ? 'Email Verified' : 'Email Not Verified',
          //       isVerified: currentUser!.emailVerified,
          //       color: currentUser!.emailVerified ? MyPaperbackTheme.yellow : MyPaperbackTheme.primaryRed,
          //     ),
              
          //     if (currentUser!.phoneNumber != null) ...[
          //       SizedBox(width: 10),
          //       _buildVerificationBadge(
          //         icon: Icons.phone,
          //         label: 'Phone Verified',
          //         isVerified: true,
          //         color: MyPaperbackTheme.yellow,
          //       ),
          //     ],
          //   ],
          // ),
        ],
      ),
    );
  }

  // Build verification badge
  // Widget _buildVerificationBadge({
  //   required IconData icon,
  //   required String label,
  //   required bool isVerified,
  //   required Color color,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.2),
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: color.withOpacity(0.5)),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           isVerified ? Icons.verified : Icons.warning,
  //           color: color,
  //           size: 16,
  //         ),
  //         SizedBox(width: 4),
  //         Text(
  //           label,
  //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
  //             color: color,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Build account information section
  Widget _buildAccountInfoSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyPaperbackTheme.bgDarker,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          
          SizedBox(height: 15),
          
          _buildInfoRow(
            Icons.person,
            'Display Name',
            currentUser!.displayName ?? 'Not set',
            onEdit: () => _showUpdateDisplayNameDialog(),
          ),
          
          _buildInfoRow(
            Icons.email,
            'Email Address',
            currentUser!.email ?? 'Not available',
          ),
          
          _buildInfoRow(
            Icons.phone,
            'Phone Number',
            currentUser!.phoneNumber ?? 'Not provided',
            onEdit: () => _showUpdatePhoneDialog(),
          ),
          
          _buildInfoRow(
            Icons.calendar_today,
            'Account Created',
            _formatDate(currentUser!.metadata.creationTime),
          ),
          
          _buildInfoRow(
            Icons.access_time,
            'Last Sign In',
            _formatDate(currentUser!.metadata.lastSignInTime),
          ),
        ],
      ),
    );
  }

  // Build security section
  Widget _buildSecuritySection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyPaperbackTheme.bgDarker,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security & Privacy',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          
          SizedBox(height: 15),
          
          _buildSecurityOption(
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your account password',
            onTap: () => _showChangePasswordDialog(),
          ),
          
          if (!currentUser!.emailVerified)
            _buildSecurityOption(
              icon: Icons.mark_email_unread,
              title: 'Verify Email',
              subtitle: 'Verify your email address',
              onTap: () => _sendEmailVerification(),
            ),
          
          _buildSecurityOption(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            color: MyPaperbackTheme.primaryRed,
            onTap: () => _showDeleteAccountDialog(),
          ),
        ],
      ),
    );
  }

  // Build info row with optional edit button
  Widget _buildInfoRow(IconData icon, String label, String value, {VoidCallback? onEdit}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyPaperbackTheme.primaryRed.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: MyPaperbackTheme.primaryRed,
              size: 20,
            ),
          ),
          
          SizedBox(width: 15),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                
                SizedBox(height: 2),
                
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit, color: MyPaperbackTheme.yellow, size: 20),
              onPressed: onEdit,
              constraints: BoxConstraints(),
              padding: EdgeInsets.all(4),
            ),
        ],
      ),
    );
  }

  // Build security option
  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    color = color ?? MyPaperbackTheme.primaryRed;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                
                SizedBox(width: 15),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyPaperbackTheme.textDark,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build action buttons
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          icon: Icons.refresh,
          label: 'Refresh Profile',
          onTap: () => _refreshUserData(),
        ),
        
        SizedBox(height: 10),
        
        _buildActionButton(
          icon: Icons.help_outline,
          label: 'Help & Support',
          onTap: () => _navigateToHelp(),
        ),
        
        SizedBox(height: 10),
        
        _buildActionButton(
          icon: Icons.logout,
          label: 'Logout',
          color: MyPaperbackTheme.primaryRed,
          onTap: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  // Build action button
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    color = color ?? MyPaperbackTheme.yellow;
    
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: MyPaperbackTheme.bgDarker,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),
                
                SizedBox(width: 15),
                
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyPaperbackTheme.textDark,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Utility methods
  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Not available';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _refreshUserData() async {
    await currentUser?.reload();
    _getCurrentUser();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile refreshed'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  // Navigation methods
  void _navigateToLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to Login page'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  void _navigateToRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to Register page'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  void _navigateToHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Help & Support page'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  // Profile update methods
  void _showUpdateDisplayNameDialog() {
    final controller = TextEditingController(text: currentUser!.displayName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyPaperbackTheme.bgDarker,
        title: Text(
          'Update Display Name',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: TextField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: 'Display Name',
            labelStyle: TextStyle(color: MyPaperbackTheme.textDark),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: MyPaperbackTheme.textDark),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyPaperbackTheme.textDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyPaperbackTheme.primaryRed),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: MyPaperbackTheme.textDark)),
          ),
          TextButton(
            onPressed: () async {
              await _updateDisplayName(controller.text.trim());
              Navigator.pop(context);
            },
            child: Text('Update', style: TextStyle(color: MyPaperbackTheme.primaryRed)),
          ),
        ],
      ),
    );
  }

  void _showUpdatePhotoDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Photo update feature - implement image picker'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  void _showUpdatePhoneDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone update requires re-authentication'),
        backgroundColor: MyPaperbackTheme.primaryRed,
      ),
    );
  }

  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyPaperbackTheme.bgDarker,
        title: Text(
          'Change Password',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: TextStyle(color: MyPaperbackTheme.textDark),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.textDark),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.textDark),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.primaryRed),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: MyPaperbackTheme.textDark),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.textDark),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.textDark),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyPaperbackTheme.primaryRed),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: MyPaperbackTheme.textDark)),
          ),
          TextButton(
            onPressed: () async {
              await _changePassword(
                currentPasswordController.text,
                newPasswordController.text,
              );
              Navigator.pop(context);
            },
            child: Text('Change', style: TextStyle(color: MyPaperbackTheme.primaryRed)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyPaperbackTheme.bgDarker,
        title: Text(
          'Delete Account',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyPaperbackTheme.primaryRed,
          ),
        ),
        content: Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: MyPaperbackTheme.textDark)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount();
            },
            child: Text('Delete', style: TextStyle(color: MyPaperbackTheme.primaryRed)),
          ),
        ],
      ),
    );
  }

  // Firebase Auth operations
  Future<void> _updateDisplayName(String name) async {
    try {
      await currentUser!.updateDisplayName(name);
      await currentUser!.reload();
      _getCurrentUser();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Display name updated successfully'),
          backgroundColor: MyPaperbackTheme.yellow,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating display name: $e'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    }
  }

  Future<void> _sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email sent! Check your inbox.'),
          backgroundColor: MyPaperbackTheme.yellow,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending verification email: $e'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    }
  }

  Future<void> _changePassword(String currentPassword, String newPassword) async {
    try {
      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );
      
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(newPassword);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: MyPaperbackTheme.yellow,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error changing password: $e'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await currentUser!.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account deleted successfully'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting account: $e'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyPaperbackTheme.bgDarker,
        title: Text(
          'Logout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: MyPaperbackTheme.textDark)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushNamed(context, 'login');
              await _logout();
            },
            child: Text('Logout', style: TextStyle(color: MyPaperbackTheme.primaryRed)),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged out successfully'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $e'),
          backgroundColor: MyPaperbackTheme.primaryRed,
        ),
      );
    }
  }
}