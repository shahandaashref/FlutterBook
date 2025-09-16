import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/advaneddrawer.dart';
import 'package:flutterlearniti/custom/customnavbar.dart';
import 'package:flutterlearniti/model/books.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';
import 'package:flutterlearniti/allapppages/appscreans/bookdetials.dart';
import 'package:provider/provider.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
    // تحميل المفضلة عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BooksProvider>().loadFavoriteBooks();
    });
  }
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
            child: Image.asset(
              'assets/pig/unsplash_QS9ZX5UnS14.png',
              width: Helper.getResponsiveWidth(context, width: 30),
              height: Helper.getResponsiveHeight(context, height: 30),
            ),
          ),
        ],
      ),

      drawer: AdvancedDrawer(),


      body: Padding(
        padding: EdgeInsets.symmetric(
        horizontal: Helper.getResponsiveWidth(context, width: 20),
        vertical:   Helper.getResponsiveHeight(context, height: 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Consumer<BooksProvider>(
              builder: (context, provider, child) {
                if (provider.favoriteBooks.isEmpty) {
                  return Center(child: Text('No saved books yet'));
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('All items(${provider.favoriteBooks.length})'),
                    if (provider.favoriteBooks.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {}, //_showClearAllDialog(context, provider),
                      icon: Icon(Icons.clear_all, size: 18),
                      label: Text('remove all'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red[600],
                      ),
                    ),
            
                  ],
                );
              },
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height:20 ),),
            Expanded(
              child: Consumer<BooksProvider>(
                builder: (context, provider, child) {
                  // حالة التحميل
                  if (provider.isLoading) {
                    return _buildLoadingState();
                  }

                  // رسالة خطأ
                  if (provider.errorMessage != null) {
                    return _buildErrorState(provider.errorMessage!, provider);
                  }

                  // لا توجد مفضلة
                  if (provider.favoriteBooks.isEmpty) {
                    return _buildEmptyState();
                  }

                  // عرض المفضلة
                  return _buildFavoritesList(provider.favoriteBooks, provider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
          ),
          SizedBox(height: 16),
          Text(
            'Loading favorite books...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildErrorState(String error, BooksProvider provider) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            SizedBox(height: 16),
            Text(
              'Error loading favorites',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => provider.loadFavoriteBooks(),
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20),
            Text(
              'No favorite books yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            // Text(
            //   'ابدأ بإضافة كتبك المفضلة\nمن صفحة البحث أو الاستكشاف',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.grey[600],
            //     height: 1.5,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(Icons.search),
              label: Text('Search Books'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFavoritesList(List<Book> favoriteBooks, BooksProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadFavoriteBooks(),
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(), // للـ RefreshIndicator
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return _buildFavoriteBookCard(book, provider, index);
        },
      ),
    );
  }


  Widget _buildFavoriteBookCard(Book book, BooksProvider provider, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // اختيار الكتاب والذهاب للتفاصيل
          provider.selectBook(book.id);
          Navigator.push(context,
          MaterialPageRoute(builder:(context)=>BookDetailsPage(book: book) ) );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الكتاب
              Hero(
                tag: 'book-${book.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: book.imageUrl.isNotEmpty
                      ? Image.network(
                          book.imageUrl,
                          width: Helper.getResponsiveWidth(context, width: 60),
                          height: Helper.getResponsiveHeight(context, height: 90),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              width: Helper.getResponsiveWidth(context, width: 60),
                              height: Helper.getResponsiveHeight(context, height: 90),
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildBookPlaceholder();
                          },
                        )
                      : _buildBookPlaceholder(),
                ),
              ),
              
              SizedBox(width: 12),
              
              // تفاصيل الكتاب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (book.authors.isNotEmpty) ...[
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: Colors.blue[600]),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              book.authors.join(', '),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[600],
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    if (book.publishedDate!.isNotEmpty) ...[
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                          SizedBox(width: 4),
                          Text(
                            book.publishedDate!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    // وقت الإضافة (اختياري)
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.favorite, size: 14, color: Colors.red[400]),
                        SizedBox(width: 4),
                        Text(
                          'Added to favorites',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // أزرار الإجراءات
              Column(
                children: [
                  // زر القراءة
                  IconButton(
                    onPressed: () {
                      provider.selectBook(book.id);
                      Navigator.pushNamed(context, '/book-reader');
                    },
                    icon: Icon(Icons.menu_book),
                    color: Colors.green[600],
                    tooltip: 'Read',
                  ),
                  
                  // زر الحذف من المفضلة
                  IconButton(
                    onPressed: () => _showRemoveDialog(book, provider),
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    tooltip: 'remove',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookPlaceholder() {
    return Container(
      width: Helper.getResponsiveWidth(context, width: 60),
      height: Helper.getResponsiveHeight(context, height: 90),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.book,
        size: 30,
        color: Colors.grey[600],
      ),
    );
  }

void _showRemoveDialog(Book book, BooksProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.red),
              SizedBox(width: 8),
              Text('Remove from favorites'),
            ],
          ),
        ),
        content: Text(
          'Are you sure you want to remove "${book.title}" from your favorites?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // إزالة من المفضلة
              provider.toggleFavorite(book.id);
              Navigator.pop(context);
              
              // رسالة تأكيد
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${book.title} removed from favorites',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green[600],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  action: SnackBarAction(
                    label: 'Cancel',
                    textColor: Colors.white,
                    onPressed: () {
                      // إعادة إضافة للمفضلة
                      provider.toggleFavorite(book.id);
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('remove'),
          ),
        ],
      ),
    );
  }



}











