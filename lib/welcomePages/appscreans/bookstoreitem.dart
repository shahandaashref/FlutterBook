import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/customcolumnrow.dart';
import 'package:flutterlearniti/model/bookmodel.dart';
import 'package:flutterlearniti/provider/savedprovider.dart';
import 'package:provider/provider.dart';

class Bookstoreitem extends StatefulWidget {
  const Bookstoreitem({super.key});

  @override
  State<Bookstoreitem> createState() => _BookstoreitemState();
}

class _BookstoreitemState extends State<Bookstoreitem> {
  @override
  Widget build(BuildContext context) {
      print('Arguments type: ${ModalRoute.of(context)?.settings.arguments.runtimeType}');
  
  final arguments = ModalRoute.of(context)?.settings.arguments;
  if (arguments is! Bookmodel) {
    return Scaffold(
      body: Center(
        child: Text('Error: Expected Bookmodel, got ${arguments.runtimeType}'),
      ),
    );
  }
  
  final Bookmodel book = arguments;
    // final Bookmodel book =
    //     ModalRoute.of(context)!.settings.arguments as Bookmodel;
    // Bookmodel;
    List<String> items = [
      book.author,
    ];
    List<String> images = [
      'assets/hello/Avatar.png',
    ];
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHieght = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.west_rounded),
        ),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(book.title, style: theme.textTheme.titleLarge)),
            Text(book.author, style: theme.textTheme.bodySmall),
            //SvgPicture.asset('assets/pig/Main Image.svg',width: sizeWidth,)
            SizedBox(
              width: sizeWidth,
              height: Helper.getResponsiveHeight(context, height: 300),
              child: Image.asset(
                book.image,
                width: sizeWidth,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height: 20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('OUR RATING', style: theme.textTheme.headlineMedium),
                      SizedBox(height: sizeHieght * 0.01),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: index < 4 ? Colors.yellow : Colors.grey,
                            size: 18, //
                          );
                        }),
                      ),
                    ],
                  ),
                  Customcolumnrow(text1: 'RUNTIME', text2: '3 hours 42m'),
                  Customcolumnrow(text1: 'GENRE', text2: 'Fiction'),
                ],
              ),
            ),
            SizedBox(height: sizeHieght * 0.01),
            Text('SYNOPSIS'),
            SizedBox(height: sizeHieght * 0.01),

            Text(book.description!, style: theme.textTheme.bodySmall),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  var image = images[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Helper.getResponsiveWidth(context, width: 50),
                          height: Helper.getResponsiveHeight(context, height: 50),
                          child: Image.asset(image)),
                        Text(item)],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final savedProvider = context.read<Savedprovider>();
                  if (savedProvider.addBook(book)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book saved successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book already saved!')),
                    );
                  }
                },
                child: Text('Save book'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
