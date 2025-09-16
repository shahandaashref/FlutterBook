import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdvancedDrawer extends StatelessWidget {
  const AdvancedDrawer({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          User? user = snapshot.data;
          
          return Column(
            children: [
              // Custom header
              _buildDrawerHeader(context, user),
              
              // Menu items
              Expanded(
                child: _buildDrawerItems(context, user),
              ),
              
              // Footer with logout
              _buildDrawerFooter(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, User? user) {
    final theme =Theme.of(context);

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary,theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight, 
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: user?.photoURL != null 
                        ? NetworkImage(user!.photoURL!) 
                        : null,
                    child: user?.photoURL == null 
                        ? Icon(Icons.person, size: 40, color: Colors.blue)
                        : null,
                  ),
                ),
                
                SizedBox(height: 12),
                
                // User name
                Text(
                  _getDisplayName(user),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 4),
                
                // Email
                Text(
                  user?.email ?? 'No email',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 8),
                
                // Verification status
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: user?.emailVerified == true ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user?.emailVerified == true ? 'Verified' : 'Not Verified',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context, User? user) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildDrawerItem(
          icon: Icons.home,
          title: 'Home',
          onTap: () =>  Navigator.pushNamedAndRemoveUntil(context, '/home',
                            (Route<dynamic> route) => false,
                            //arguments: Userdata(_emailController.text,_userController.text),
          ),
        ),
        
        _buildDrawerItem(
          icon: Icons.person,
          title: 'Profile',
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/profile',
                            (Route<dynamic> route) => false,
                            //arguments: Userdata(_emailController.text,_userController.text),
          );
            _navigateToProfile(context);
          },
        ),
        
        _buildDrawerItem(
          icon: Icons.favorite,
          title: 'Favorites',
          onTap: () =>  Navigator.pushNamedAndRemoveUntil(context, '/saved',
                            (Route<dynamic> route) => false,
                            //arguments: Userdata(_emailController.text,_userController.text),
          )
        ),
        
        _buildDrawerItem(
          icon: Icons.history,
          title: 'History',
          onTap: () => Navigator.pop(context),
        ),
        
        Divider(color: Colors.grey.shade300),
        
        _buildDrawerItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => Navigator.pop(context),
        ),
        
        _buildDrawerItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () => Navigator.pop(context),
        ),
        
        _buildDrawerItem(
          icon: Icons.info_outline,
          title: 'About',
          onTap: () => _showAboutDialog(context),
        ),
        
        // Special item for completing profile
        // if (user?.displayName == null || user?.displayName?.isEmpty == true)
        //   Container(
        //     margin: EdgeInsets.all(8),
        //     child: Card(
        //       color: Colors.orange.shade50,
        //       child: ListTile(
        //         leading: Icon(Icons.edit, color: Colors.orange),
        //         title: Text(
        //           'Complete Your Profile',
        //           style: TextStyle(color: Colors.orange.shade800),
        //         ),
        //         subtitle: Text('Add your name for better experience'),
        //         onTap: () {
        //           Navigator.pop(context);
        //           _navigateToProfile(context);
        //         },
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(title),
      onTap: onTap,
      dense: true,
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ListTile(
        leading: Icon(Icons.exit_to_app, color: Colors.red),
        title: Text(
          'Logout',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        onTap: () => _showLogoutDialog(context),
      ),
    );
  }

  String _getDisplayName(User? user) {
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      return user.displayName!;
    } else if (user?.email != null) {
      // Extract name from email (part before @)
      return user!.email!.split('@')[0];
    }
    return 'New User';
  }

  void _navigateToProfile(BuildContext context) {
    // Navigate to profile page
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile page will be added soon')),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'PaperBack',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 All Rights Reserved',
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Amazing app built with Flutter & Firebase'),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.red),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
          content: Text('Are you sure you want to logout from the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(context, 'login',
                            (Route<dynamic> route) => false,
                            );
              await FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login page
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred during logout: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}