import 'package:flutter/material.dart';

class AdvancedDrawerExample extends StatefulWidget {
  const AdvancedDrawerExample({super.key});

  @override
  _AdvancedDrawerExampleState createState() => _AdvancedDrawerExampleState();
}

class _AdvancedDrawerExampleState extends State<AdvancedDrawerExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      icon: Icons.dashboard,
      title: 'Dashboard',
      route: '/dashboard',
    ),
    DrawerItem(
      icon: Icons.person,
      title: 'Profile',
      route: '/profile',
    ),
    DrawerItem(
      icon: Icons.shopping_cart,
      title: 'Orders',
      route: '/orders',
      badge: '3', // Example badge
    ),
    DrawerItem(
      icon: Icons.analytics,
      title: 'Analytics',
      route: '/analytics',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_drawerItems[_selectedIndex].title),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: _buildAdvancedDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildAdvancedDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Custom header with user info
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo, Colors.indigo.shade300],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/150'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Sarah Johnson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '4.8 Rating',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Navigation items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _drawerItems.length,
              itemBuilder: (context, index) {
                final item = _drawerItems[index];
                final isSelected = _selectedIndex == index;
                
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: ListTile(
                    selected: isSelected,
                    selectedTileColor: Colors.indigo.withOpacity(0.1),
                    leading: Icon(
                      item.icon,
                      color: isSelected ? Colors.indigo : Colors.grey[600],
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: isSelected ? Colors.indigo : Colors.grey[800],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    trailing: item.badge != null
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.badge!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () => _selectItem(index),
                  ),
                );
              },
            ),
          ),
          
          // Footer section
          Divider(),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey[600]),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              _showSettingsDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.grey[600]),
            title: Text('Logout'),
            onTap: () => _showLogoutDialog(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _drawerItems[_selectedIndex].icon,
            size: 64,
            color: Colors.indigo,
          ),
          SizedBox(height: 16),
          Text(
            '${_drawerItems[_selectedIndex].title} Screen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            child: Text('Open Drawer'),
          ),
        ],
      ),
    );
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
    
    // Here you would typically handle navigation
    // Navigator.pushNamed(context, _drawerItems[index].route);
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Settings'),
        content: Text('Settings screen would open here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // Handle logout logic
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;
  final String? badge;

  DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
    this.badge,
  });
}