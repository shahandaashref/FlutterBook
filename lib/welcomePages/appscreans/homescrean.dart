import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/theme.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/custombookcard.dart';
import 'package:flutterlearniti/custom/customdrawer.dart';
import 'package:flutterlearniti/custom/customnavbar.dart';
import 'package:flutterlearniti/model/books.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';
import 'package:flutterlearniti/welcomePages/appscreans/bookdetials.dart';
//import 'package:flutterlearniti/welcomePages/userdata.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Constants
  static const int _initialFavoritesDisplayCount = 2;
  static const String _appName = 'PaperBack.';
  static const String _defaultProfileImage = 'assets/pig/unsplash_QS9ZX5UnS14.png';

  // State variables
  late int _favoritesDisplayCount;

  @override
  void initState() {
    super.initState();
    _favoritesDisplayCount = _initialFavoritesDisplayCount;
    _loadInitialData();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<BooksProvider>();
      provider.loadTrendingBooks();
      provider.loadFavoriteBooks();
    });
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  void _navigateToSaved() {
    Navigator.pushNamed(context, '/saved');
  }

  // Extract user data safely
  Map<String, String> _getUserData() {
    try {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      return {
        'name': args?['name']?.toString() ?? 'User',
        'email': args?['email']?.toString() ?? 'user@example.com',
      };
    } catch (e) {
      return {
        'name': 'User',
        'email': 'user@example.com',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userData = _getUserData();

    return Scaffold(
      bottomNavigationBar: const Customnavbar(),
      appBar: _buildAppBar(theme),
      drawer: Customdrawer(
        name: userData['name']!,
        email: userData['email']!,
      ),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(_appName, style: theme.textTheme.titleLarge),
      actions: [
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(Icons.notifications_none),
          tooltip: 'Notifications',
        ),
        _buildProfileButton(),
        SizedBox(width: Helper.getResponsiveWidth(context, width: 8)),
      ],
    );
  }

  Widget _buildProfileButton() {
    return InkWell(
      onTap: _navigateToProfile,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          child: Image.asset(
            _defaultProfileImage,
            width: Helper.getResponsiveWidth(context, width: 40),
            height: Helper.getResponsiveHeight(context, height: 40),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: Helper.getResponsiveWidth(context, width: 40),
                height: Helper.getResponsiveHeight(context, height: 40),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.all(Helper.getResponsiveWidth(context, width: 16)),
      child: Consumer<BooksProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () => _handleRefresh(provider),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  SizedBox(height: Helper.getResponsiveHeight(context, height: 32)),
                  _buildTrendingSection(provider, context),
                  SizedBox(height: Helper.getResponsiveHeight(context, height: 32)),
                  _buildFavoritesSectionHeader(),
                  SizedBox(height: Helper.getResponsiveHeight(context, height: 16)),
                  _buildFavoritesList(provider, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final theme = Theme.of(context);
    return Text(
      'Discover your next favorite book',
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFavoritesSectionHeader() {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your favorites', style: theme.textTheme.titleMedium),
              Text(
                'Your saved list of favorites',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: _navigateToSaved,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'See more',
              style: TextStyle(
                color: PaperbackTheme.primaryRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRefresh(BooksProvider provider) async {
    await Future.wait([
      provider.loadTrendingBooks(),
      provider.loadFavoriteBooks(),
    ]);
  }

  Widget _buildTrendingSection(BooksProvider provider, BuildContext context) {
    if (provider.isLoading) {
      return _buildLoadingState(context);
    }

    if (provider.errorMessage != null) {
      return _buildErrorState(provider);
    }

    if (provider.books.isEmpty) {
      return _buildEmptyState('No trending books available');
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: Helper.getResponsiveHeight(context, height: 264),
      child: ListView.builder(
        itemExtent: Helper.getResponsiveWidth(context, width: 200),
        scrollDirection: Axis.horizontal,
        itemCount: provider.books.length,
        itemBuilder: (context, index) => _buildTrendingBookItem(
          provider.books[index],
          context,
        ),
      ),
    );
  }

  Widget _buildTrendingBookItem(Book book, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToBookDetails(book),
      child: Container(
        width: Helper.getResponsiveWidth(context, width: 181),
        height: Helper.getResponsiveHeight(context, height: 240),
        margin: EdgeInsets.only(
          right: Helper.getResponsiveWidth(context, width: 16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildBookImage(book),
        ),
      ),
    );
  }

  Widget _buildBookImage(Book book) {
    if (book.imageUrl.isEmpty) {
      return _buildPlaceholderImage(book.title);
    }

    return Image.network(
      book.imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey.shade300,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(book.title),
    );
  }

  Widget _buildPlaceholderImage(String title) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book,
            size: 48,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Container(
      height: Helper.getResponsiveHeight(context, height: 264),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(BooksProvider provider) {
    return Container(
      height: Helper.getResponsiveHeight(context, height: 264),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            const Text(
              'Error loading books',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => provider.loadTrendingBooks(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      height: Helper.getResponsiveHeight(context, height: 200),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(BooksProvider provider, BuildContext context) {
    if (provider.favoriteBooks.isEmpty) {
      return _buildEmptyFavoritesState();
    }

    final displayCount = _favoritesDisplayCount.clamp(0, provider.favoriteBooks.length);

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayCount,
          separatorBuilder: (context, index) => SizedBox(
            height: Helper.getResponsiveHeight(context, height: 8),
          ),
          itemBuilder: (context, index) {
            final book = provider.favoriteBooks[index];
            return GestureDetector(
              onTap: () => _navigateToBookDetails(book),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomBookCard(
                  bookInfo: book,
                  onFavoriteToggle: () => provider.toggleFavorite(book.id),
                ),
              ),
            );
          },
        ),
        if (provider.favoriteBooks.length > _favoritesDisplayCount)
          _buildShowMoreButton(provider),
      ],
    );
  }

  Widget _buildEmptyFavoritesState() {
    return Container(
      height: Helper.getResponsiveHeight(context, height: 200),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No favorite books yet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Tap on any book to add it to your favorites!',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMoreButton(BooksProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _favoritesDisplayCount = provider.favoriteBooks.length;
          });
        },
        child: Text(
          'Show ${provider.favoriteBooks.length - _favoritesDisplayCount} more',
        ),
      ),
    );
  }
}