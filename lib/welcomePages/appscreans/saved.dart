import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/customnavbar.dart';
import 'package:flutterlearniti/provider/savedprovider.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Customnavbar(),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('saved.', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: ClipOval(
              child: Image.asset(
                'assets/pig/unsplash_QS9ZX5UnS14.png',
                width: Helper.getResponsiveWidth(context, width: 30),
                height: Helper.getResponsiveHeight(context, height: 30),
              ),
            ),
          ),
          //IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
        horizontal: Helper.getResponsiveWidth(context, width: 20),
        vertical:   Helper.getResponsiveHeight(context, height: 20),
        ),
        child: Column(
          children: [
            Text('All items'),
            Expanded(
              child: Consumer<Savedprovider>(
                builder: (context, value, child) {
                  if (value.savedBooks.isEmpty) {
                    return Center(child: Text('No saved books yet'));
                  }
                  return ListView.builder(
                    itemCount: value.savedBooks.length,
                    itemBuilder: (context, index) {
                      final book = value.savedBooks[index];
                      return Card(
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            // Helper.getResponsiveWidth(
                            //   context,
                            //   width: 80,
                            // ),
                            height: 50,
                            // Helper.getResponsiveHeight(
                            //   context,
                            //   height: 100,
                            // ),
                            child: Image.asset(
                              book.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.book,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          title: Text(book.title),
                          subtitle: Text('${book.author} - ⭐ ${book.rate}'),
                              trailing:
                              IconButton(
                                onPressed: () {
                                  // Confirmation dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Remove Book'),
                                      content: Text(
                                        'Are you sure you want to remove "${book.title}"?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            value.removeBookByIndex(index);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${book.title} removed',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Remove',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
