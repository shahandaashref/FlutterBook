// // screens/chapter_reading_page.dart
// import 'package:day2_course/model/chapter_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/book_model.dart';
// import '../providers/reading_provider.dart';
// import '../providers/books_provider.dart';

// class ChapterReadingPage extends StatefulWidget {
//   final Book book;
//   final List<Chapter> chapters;
//   final int initialChapterIndex;

//   const ChapterReadingPage({
//     Key? key,
//     required this.book,
//     required this.chapters,
//     this.initialChapterIndex = 0,
//   }) : super(key: key);

//   @override
//   _ChapterReadingPageState createState() => _ChapterReadingPageState();
// }

// class _ChapterReadingPageState extends State<ChapterReadingPage> {
//   late int currentChapterIndex;
//   bool isReading = false;
//   double currentProgress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     currentChapterIndex = widget.initialChapterIndex;

//     // Initialize TTS service
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ReadingProvider>().initialize();
//     });
//   }

//   Chapter get currentChapter => widget.chapters[currentChapterIndex];

//   void _navigateToChapter(int newIndex) {
//     if (newIndex >= 0 && newIndex < widget.chapters.length) {
//       setState(() {
//         currentChapterIndex = newIndex;
//         currentProgress = 0.0;
//       });
//       // Stop current reading and start new chapter
//       context.read<ReadingProvider>().stopReading();
//     }
//   }

//   void _previousChapter() {
//     if (currentChapterIndex > 0) {
//       _navigateToChapter(currentChapterIndex - 1);
//     }
//   }

//   void _nextChapter() {
//     if (currentChapterIndex < widget.chapters.length - 1) {
//       _navigateToChapter(currentChapterIndex + 1);
//     }
//   }

//   String _formatDuration(String duration) {
//     // Mock current time based on progress
//     List<String> parts = duration.split(':');
//     if (parts.length == 2) {
//       int totalMinutes = int.tryParse(parts[0]) ?? 0;
//       int totalSeconds = int.tryParse(parts[1]) ?? 0;
//       int totalTime = (totalMinutes * 60) + totalSeconds;
//       int currentTime = (totalTime * currentProgress).round();

//       int currentMinutes = currentTime ~/ 60;
//       int remainingSeconds = currentTime % 60;

//       return '${currentMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//     }
//     return '00:00';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF2D2D2D),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             context.read<ReadingProvider>().stopReading();
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Consumer<BooksProvider>(
//             builder: (context, provider, child) {
//               return IconButton(
//                 icon: Icon(
//                   widget.book.isFavorite
//                       ? Icons.bookmark
//                       : Icons.bookmark_border,
//                   color: widget.book.isFavorite
//                       ? Color(0xFFFF6B6B)
//                       : Colors.white,
//                 ),
//                 onPressed: () {
//                   provider.toggleFavorite(widget.book.id);
//                   widget.book.isFavorite = !widget.book.isFavorite;
//                   setState(() {});

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         widget.book.isFavorite
//                             ? 'Book added to favorites!'
//                             : 'Book removed from favorites!',
//                       ),
//                       backgroundColor: Color(0xFFFF6B6B),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Book info header
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               children: [
//                 Text(
//                   widget.book.title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'by ${widget.book.author}',
//                   style: TextStyle(color: Colors.grey[400], fontSize: 14),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),

//           // Book cover (smaller)
//           Container(
//             width: 120,
//             height: 160,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: widget.book.imageUrl.isNotEmpty
//                   ? Image.network(
//                       widget.book.imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey[700],
//                           child: Icon(
//                             Icons.book,
//                             size: 40,
//                             color: Colors.grey[500],
//                           ),
//                         );
//                       },
//                     )
//                   : Container(
//                       color: Colors.grey[700],
//                       child: Icon(
//                         Icons.book,
//                         size: 40,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//             ),
//           ),

//           SizedBox(height: 30),

//           // Current chapter content
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[850],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Chapter title
//                       Text(
//                         'Chapter ${currentChapterIndex + 1}',
//                         style: TextStyle(
//                           color: Color(0xFFFF6B6B),
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         currentChapter.title,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),

//                       // Chapter content
//                       Text(
//                         currentChapter.content,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           height: 1.8,
//                           letterSpacing: 0.3,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(height: 20),

//           // Audio controls
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Column(
//               children: [
//                 // Progress bar
//                 Row(
//                   children: [
//                     Text(
//                       _formatDuration(currentChapter.duration),
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                     Expanded(
//                       child: SliderTheme(
//                         data: SliderThemeData(
//                           thumbShape: RoundSliderThumbShape(
//                             enabledThumbRadius: 6,
//                           ),
//                           trackShape: RectangularSliderTrackShape(),
//                           trackHeight: 3,
//                           activeTrackColor: Color(0xFFFF6B6B),
//                           inactiveTrackColor: Colors.grey[700],
//                           thumbColor: Color(0xFFFF6B6B),
//                         ),
//                         child: Slider(
//                           value: currentProgress,
//                           onChanged: (value) {
//                             setState(() {
//                               currentProgress = value;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     Text(
//                       currentChapter.duration,
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 10),

//                 // Chapter info
//                 Text(
//                   'Chapter ${currentChapterIndex + 1} of ${widget.chapters.length}',
//                   style: TextStyle(color: Colors.grey[400], fontSize: 14),
//                 ),

//                 SizedBox(height: 20),

//                 // Control buttons
//                 Consumer<ReadingProvider>(
//                   builder: (context, readingProvider, child) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // Previous button
//                         IconButton(
//                           onPressed: currentChapterIndex > 0
//                               ? _previousChapter
//                               : null,
//                           icon: Icon(
//                             Icons.skip_previous,
//                             color: currentChapterIndex > 0
//                                 ? Colors.white
//                                 : Colors.grey[600],
//                             size: 28,
//                           ),
//                         ),

//                         // Rewind 10s
//                         IconButton(
//                           onPressed: () {
//                             if (currentProgress > 0.1) {
//                               setState(() {
//                                 currentProgress = (currentProgress - 0.1).clamp(
//                                   0.0,
//                                   1.0,
//                                 );
//                               });
//                             }
//                           },
//                           icon: Icon(
//                             Icons.replay_10,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),

//                         // Play/Pause button
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFFFF6B6B),
//                             shape: BoxShape.circle,
//                           ),
//                           child: IconButton(
//                             onPressed: () async {
//                               if (readingProvider.isPlaying) {
//                                 await readingProvider.stopReading();
//                                 setState(() {
//                                   isReading = false;
//                                 });
//                               } else {
//                                 // Create a temporary book with current chapter content
//                                 Book chapterBook = Book(
//                                   id: widget.book.id,
//                                   title: widget.book.title,
//                                   author: widget.book.author,
//                                   description: currentChapter.content,
//                                   imageUrl: widget.book.imageUrl,
//                                   rating: widget.book.rating,
//                                   ratingsCount: widget.book.ratingsCount,
//                                   category: widget.book.category,
//                                   pageCount: widget.book.pageCount,
//                                   isFavorite: widget.book.isFavorite,
//                                 );

//                                 await readingProvider.startReading(chapterBook);
//                                 setState(() {
//                                   isReading = true;
//                                 });

//                                 // Simulate progress update
//                                 _startProgressSimulation();
//                               }
//                             },
//                             icon: Icon(
//                               readingProvider.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: Colors.white,
//                               size: 32,
//                             ),
//                           ),
//                         ),

//                         // Forward 10s
//                         IconButton(
//                           onPressed: () {
//                             if (currentProgress < 0.9) {
//                               setState(() {
//                                 currentProgress = (currentProgress + 0.1).clamp(
//                                   0.0,
//                                   1.0,
//                                 );
//                               });
//                             }
//                           },
//                           icon: Icon(
//                             Icons.forward_10,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),

//                         // Next button
//                         IconButton(
//                           onPressed:
//                               currentChapterIndex < widget.chapters.length - 1
//                               ? _nextChapter
//                               : null,
//                           icon: Icon(
//                             Icons.skip_next,
//                             color:
//                                 currentChapterIndex < widget.chapters.length - 1
//                                 ? Colors.white
//                                 : Colors.grey[600],
//                             size: 28,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   void _startProgressSimulation() {
//     // Simulate progress update while reading
//     // In a real app, this would be handled by the TTS service
//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 1));
//       if (mounted && isReading && currentProgress < 1.0) {
//         setState(() {
//           currentProgress += 0.01; // Increase by 1% every second
//         });

//         // Auto-navigate to next chapter when current one finishes
//         if (currentProgress >= 1.0) {
//           if (currentChapterIndex < widget.chapters.length - 1) {
//             _nextChapter();
//           } else {
//             // Book finished
//             context.read<ReadingProvider>().stopReading();
//             setState(() {
//               isReading = false;
//             });
//           }
//         }
//         return true;
//       }
//       return false;
//     });
//   }

//   @override
//   void dispose() {
//     context.read<ReadingProvider>().stopReading();
//     super.dispose();
//   }
// }