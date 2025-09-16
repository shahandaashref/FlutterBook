// ignore_for_file: public_member_api_docs, sort_constructors_first





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutterlearniti/model/books.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';

class BookReaderPage extends StatefulWidget {
  final Book book;
  const BookReaderPage({
    super.key,
    required this.book,
  });

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  late WebViewController _controller;
  bool _isLoading = true;

  


  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;

            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Reader'),
        backgroundColor:theme.colorScheme.primary ,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<BooksProvider>(
        builder: (context, provider, child) {
          final book = provider.selectedBook;

          // No book selected
          if (book == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No book selected',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          // Book has preview link - show WebView
          if (book.webReaderLink.isNotEmpty) {
            if (_isLoading) {
              _controller.loadRequest(Uri.parse(book.webReaderLink));
            }
            
            return Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading book...'),
                      ],
                    ),
                  ),
              ],
            );
          }

          // Book not available for reading - show info
          return _buildBookInfo(book);
        },
      ),
    );
  }

  Widget _buildBookInfo(Book book) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book image and info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover
              Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: book.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.book, size: 50, color: Colors.grey);
                          },
                        ),
                      )
                    : Icon(Icons.book, size: 50, color: Colors.grey),
              ),
              
              SizedBox(width: 16),
              
              // Book details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (book.authors.isNotEmpty) ...[
                      SizedBox(height: 8),
                      Text(
                        'By: ${book.authors.join(', ')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                    
                    if (book.publishedDate!.isNotEmpty) ...[
                      SizedBox(height: 8),
                      Text(
                        'Published: ${book.publishedDate}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Not available message
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              border: Border.all(color: Colors.orange[200]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(Icons.info, size: 40, color: Colors.orange),
                SizedBox(height: 12),
                Text(
                  'Reading Not Available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'This book is not available for free reading through Google Books.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Book description
          if (book.description.isNotEmpty) ...[
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              book.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
          ],
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final provider = context.read<BooksProvider>();
                    provider.toggleFavorite(book.id);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          book.isFavorite 
                              ? 'Removed from favorites' 
                              : 'Added to favorites'
                        ),
                      ),
                    );
                  },
                  icon: Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: Text(book.isFavorite ? 'Unfavorite' : 'Favorite'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: book.isFavorite ? Colors.red : Colors.blue[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                  label: Text('Go Back'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




























// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class BookReaderPage extends StatelessWidget {
//   final String url;
//   const BookReaderPage({super.key, required this.url});

//   // void showErrorDialog() {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     //int _currentIndex = 0;
//     List<String> imagePaths = [
//       'assets/hello/Rectangle4.png',
//       'assets/hello/Rectangle11.png',
//       'assets/hello/Rectangle11.png',
//     ];
//     return Scaffold(
//       // bottomNavigationBar:BottomNavigationBar(
//       //     currentIndex: _currentIndex ,
//       //     onTap: (int index){
//       //       setState(() {
//       //         _currentIndex=index;
//       //       });
//       //     },
//       //     type:BottomNavigationBarType.fixed ,
//       //   items: [
//       //     BottomNavigationBarItem(
//       //       icon: IconButton(onPressed: (){}, icon: Icon(Icons.add_ic_call_outlined))
//       //       ),
//       //   ],
//       //   ) ,
//       appBar: AppBar(
//         leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.west_rounded)),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
//       ),

//       body: WebViewWidget(
//         controller:WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..loadRequest(Uri.parse(url))),
        
        


//       // body: Container(
//       //   child: Column(
//       //     children: [
//       //       SingleChildScrollView(
//       //         scrollDirection: Axis.horizontal,
//       //         child: Row(
//       //           children: [
//       //             ...List.generate(imagePaths.length, (index) {
//       //               return Padding(
//       //                 padding: const EdgeInsets.symmetric(horizontal: 8),
//       //                 child: Image.asset(
//       //                   imagePaths[index],
//       //                   width: 200,
//       //                   height: 300,
//       //                 ),
//       //               );
//       //             }),
//       //           ],
//       //         ),
//       //       ),
//       //       // Spacer(),
//       //       Padding(
//       //         padding: EdgeInsets.symmetric(
//       //           horizontal: Helper.getResponsiveHeight(context, height: 50),
//       //         ),
//       //         child: Column(
//       //           children: [
//       //             Text(
//       //               'The Keeper of Lost Things',
//       //               style: theme.textTheme.headlineLarge,
//       //             ),
//       //             SizedBox(
//       //               height: Helper.getResponsiveHeight(context, height: 16),
//       //             ),
//       //             Text('by Ruth Hogan', style: theme.textTheme.bodySmall),
//       //             SizedBox(
//       //               height: Helper.getResponsiveHeight(context, height: 30),
//       //             ),

//       //             Text(
//       //               'The chime of the clock in the hall said time for gin and lime. He took ice cubes and lime juice from the refrigerator and carried them through to the garden room on a silver drinks tray with a green cocktail glass and a small dish...',
//       //               style: theme.textTheme.bodySmall,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       Spacer(),
//       //       Container(
//       //         width: Helper.getResponsiveWidth(context, width: 300),
//       //         padding: EdgeInsets.all(
//       //           Helper.getResponsiveHeight(context, height: 8),
//       //         ),
//       //         decoration: BoxDecoration(
//       //           color: const Color.fromARGB(255, 1, 0, 4),
//       //           borderRadius: BorderRadius.circular(15),
//       //         ),

//       //         child: Row(
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           children: [
//       //             IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//       //             IconButton(onPressed: () {}, icon: Icon(Icons.replay_10)),
//       //             IconButton(
//       //               onPressed: () {
//       //                 Navigator.of(context);
//       //               },
//       //               icon: Icon(Icons.pause),
//       //             ),
//       //             IconButton(onPressed: () {}, icon: Icon(Icons.forward_10)),
//       //             IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
//       //           ],
//       //         ),
//       //       ),
//       //       Spacer(),
//       //       Align(
//       //         alignment: Alignment.bottomCenter,

//       //         child: Container(
//       //           width: MediaQuery.sizeOf(context).width,
//       //           height: Helper.getResponsiveHeight(context, height: 80),
//       //           decoration: BoxDecoration(color: MyPaperbackTheme.bgDarker),
//       //           child: Column(
//       //             children: [
//       //               //
//       //               TextButton(
//       //                 onPressed: showErrorDialog,
//       //                 child: const Text('Show error'),
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
// }}
