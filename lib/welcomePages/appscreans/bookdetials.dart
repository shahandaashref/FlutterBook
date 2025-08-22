
import 'package:flutter/material.dart';
import 'package:flutterlearniti/model/books.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';
import 'package:provider/provider.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
//  List<Chapter> chapters = [];
  String authorBio = '';

  @override
  void initState() {
    super.initState();
    //_initializeChapters();
    _loadAuthorInfo();
  }

  // void _initializeChapters() {
  //   // Create mock chapters from book description
  //   // In a real app, you'd fetch this from your API
  //   List<String> textParts = _splitTextIntoParts(widget.book.description);

  //   chapters = List.generate(14, (index) {
  //     return Chapter(
  //       id: 'chapter_${index + 1}',
  //       title: index == 0 ? 'Introduction' : 'Chapter ${index + 1}',
  //       content: index < textParts.length
  //           ? textParts[index]
  //           : 'This is chapter ${index + 1} content. ${widget.book.description}',
  //       duration:
  //           '${(index + 3).toString().padLeft(2, '0')}:${((index * 2 + 15) % 60).toString().padLeft(2, '0')}',
  //     );
  //   });
  // }

  void _loadAuthorInfo() {
    // In a real app, you would fetch author bio from API
    // For now, we'll use mock data
    setState(() {
      authorBio =
          '${widget.book.author} is a renowned author in the ${widget.book.category.toLowerCase()} genre. '
          'With ${widget.book.pageCount > 0 ? "over ${(widget.book.pageCount / 100).round() * 100}" : "many"} pages of engaging content, '
          'this author has captivated readers worldwide with their unique storytelling approach.';
    });
  }

  List<String> _splitTextIntoParts(String text) {
    List<String> sentences = text.split('. ');
    List<String> parts = [];

    String currentPart = '';
    for (String sentence in sentences) {
      if (currentPart.length + sentence.length < 200) {
        currentPart += sentence + '. ';
      } else {
        if (currentPart.isNotEmpty) {
          parts.add(currentPart.trim());
        }
        currentPart = sentence + '. ';
      }
    }
    if (currentPart.isNotEmpty) {
      parts.add(currentPart.trim());
    }

    return parts.isNotEmpty ? parts : [text];
  }

  // void _navigateToChapter(int chapterIndex) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChapterReadingPage(
  //         book: widget.book,
  //         chapters: chapters,
  //         initialChapterIndex: chapterIndex,
  //       ),
  //     ),
  //   );
  // }

  void _startReading() {
    // Start reading from first chapter
   // _navigateToChapter(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Consumer<BooksProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: Icon(
                  widget.book.isFavorite
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: widget.book.isFavorite
                      ? Color(0xFFFF6B6B)
                      : Colors.white,
                ),
                onPressed: () {
                  provider.toggleFavorite(widget.book.id);
                  widget.book.isFavorite = !widget.book.isFavorite;
                  setState(() {});

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.book.isFavorite
                            ? 'Book added to favorites!'
                            : 'Book removed from favorites!',
                      ),
                      backgroundColor: Color(0xFFFF6B6B),
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover and Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.book.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'by ${widget.book.author}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                  SizedBox(height: 30),

                  // Book Cover
                  Container(
                    width: 200,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.book.imageUrl.isNotEmpty
                          ? Image.network(
                              widget.book.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[700],
                                  child: Icon(
                                    Icons.book,
                                    size: 60,
                                    color: Colors.grey[500],
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey[700],
                              child: Icon(
                                Icons.book,
                                size: 60,
                                color: Colors.grey[500],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Rating and Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoColumn(
                        'OUR RATING',
                        _buildStarRating(),
                        context,
                      ),
                      _buildInfoColumn(
                        'PAGES',
                        '${widget.book.pageCount > 0 ? widget.book.pageCount : "N/A"}',
                        context,
                      ),
                      _buildInfoColumn('GENRE', widget.book.category, context),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Synopsis Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SYNOPSIS',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.6,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // About the Author Section (with API data)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT THE AUTHOR',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[700],
                        child: Text(
                          widget.book.author.isNotEmpty
                              ? widget.book.author[0].toUpperCase()
                              : 'A',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.author,
                              style: TextStyle(
                                color: Color(0xFFFF6B6B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              authorBio,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Chapters Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Chapters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Chapters List
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   itemCount: chapters.length,
            //   itemBuilder: (context, index) {
            //     final chapter = chapters[index];
            //     return Container(
            //       margin: EdgeInsets.only(bottom: 12),
            //       child: Material(
            //         color: Colors.transparent,
            //         child: InkWell(
            //           onTap: () => _navigateToChapter(index),
            //           borderRadius: BorderRadius.circular(12),
            //           child: Container(
            //             padding: EdgeInsets.all(16),
            //             decoration: BoxDecoration(
            //               color: Colors.grey[850],
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'Chapter ${index + 1}',
            //                         style: TextStyle(
            //                           color: Color(0xFFFF6B6B),
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                       SizedBox(height: 4),
            //                       Text(
            //                         chapter.title,
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w500,
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Row(
            //                   children: [
            //                     Text(
            //                       chapter.duration,
            //                       style: TextStyle(
            //                         color: Colors.grey[400],
            //                         fontSize: 12,
            //                       ),
            //                     ),
            //                     SizedBox(width: 8),
            //                     Icon(
            //                       Icons.arrow_forward_ios,
            //                       color: Colors.grey[400],
            //                       size: 16,
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),

            // SizedBox(height: 40),

            // Save Book Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Consumer<BooksProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.toggleFavorite(widget.book.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              widget.book.isFavorite
                                  ? 'Book removed from favorites!'
                                  : 'Book added to favorites!',
                            ),
                            backgroundColor: Color(0xFFFF6B6B),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B6B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        widget.book.isFavorite
                            ? 'Remove from Favorites'
                            : 'Save Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      // Start Reading FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startReading,
        backgroundColor: Color(0xFFFF6B6B),
        icon: Icon(Icons.play_arrow, color: Colors.white),
        label: Text(
          'Start Reading',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, dynamic content, BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        content is Widget
            ? content
            : Text(
                content.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < widget.book.rating ? Icons.star : Icons.star_border,
          color: Color(0xFFFFB800),
          size: 16,
        );
      }),
    );
  }
}