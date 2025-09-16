import 'package:flutter/material.dart';
import 'dart:math';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final double radius;
  
  const ProfileAvatar({
    super.key,
    required this.name,
    this.radius = 30,
  });

  // دالة لتوليد لون عشوائي بناءً على الاسم
  Color _generateColorFromName(String name) {
    if (name.isEmpty) return Colors.grey;
    
    // استخدام hash code للاسم لضمان نفس اللون لنفس الاسم
    final hash = name.hashCode;
    final random = Random(hash);
    
    // ألوان جميلة ومتنوعة
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
      Colors.deepPurple,
    ];
    
    return colors[random.nextInt(colors.length)];
  }

  // دالة للحصول على الحرف الأول
  String _getInitial(String name) {
    if (name.isEmpty) return '?';
    return name.trim().substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initial = _getInitial(name);
    final backgroundColor = _generateColorFromName(name);
    
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.6, // حجم النص متناسب مع حجم الدائرة
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// مثال على الاستخدام
