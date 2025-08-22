import 'package:flutter/foundation.dart';
import 'package:flutterlearniti/model/books.dart';
import 'package:flutterlearniti/services/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> _favoriteBooks = [];
  Book? _selectedBook;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Book> get books => _books;
  List<Book> get favoriteBooks => _favoriteBooks;
  Book? get selectedBook => _selectedBook;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Search books - for home page display
  Future<void> fetchBooks(String query) async {
    if (query.trim().isEmpty) return;
    try {
      final result = await BooksApiService.searchBooks(query);
      if (result.isSuccess) {
        _books = await _applyFavoriteStatus(result.data!);
        _errorMessage = null;
      }
    } catch (e) {
      _errorMessage = 'Error searching books: $e';
      _books = [];
    }
    _setLoading(false);
  }

  // Load trending books - for home page display
  Future<void> loadTrendingBooks() async {
    _setLoading(true);

    try {
      final result = await BooksApiService.getTrendingBooks();

      if (result.isSuccess) {
        _books = await _applyFavoriteStatus(result.data!);
        _errorMessage = null;
      } else {
        _errorMessage = result.error ?? 'Failed to load trending books';
        _books = [];
      }
    } catch (e) {
      _errorMessage = 'Error loading trending books: $e';
      _books = [];
    }

    _setLoading(false);
  }

  // Load books by category - for home page display
  Future<void> loadBooksByCategory(String category) async {
    _setLoading(true);

    try {
      final result = await BooksApiService.getBooksByCategory(category);

      if (result.isSuccess) {
        _books = await _applyFavoriteStatus(result.data!);
        _errorMessage = null;
      } else {
        _errorMessage = result.error ?? 'Failed to load books by category';
        _books = [];
      }
    } catch (e) {
      _errorMessage = 'Error loading books by category: $e';
      _books = [];
    }

    _setLoading(false);
  }

  // Select book for reading
  Future<void> selectBook(String bookId) async {
    _setLoading(true);

    try {
      final result = await BooksApiService.getBookById(bookId);

      if (result.isSuccess) {
        _selectedBook = result.data!;
        // Check if it's in favorites
        _selectedBook!.isFavorite = await _isBookFavorite(bookId);
        _errorMessage = null;
      } else {
        _errorMessage = result.error ?? 'Book not found';
      }
    } catch (e) {
      _errorMessage = 'Error loading book details: $e';
    }

    _setLoading(false);
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String bookId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorite_books') ?? [];

      bool wasInFavorites = favorites.contains(bookId);

      if (wasInFavorites) {
        favorites.remove(bookId);
      } else {
        favorites.add(bookId);
      }

      await prefs.setStringList('favorite_books', favorites);

      // Update books in current list
      for (int i = 0; i < _books.length; i++) {
        if (_books[i].id == bookId) {
          _books[i] = _books[i].copyWith(isFavorite: !_books[i].isFavorite);
          break;
        }
      }

      // Update selected book if it matches
      if (_selectedBook?.id == bookId) {
        _selectedBook = _selectedBook!.copyWith(
          isFavorite: !_selectedBook!.isFavorite,
        );
      }

      // If removing from favorites, update the favorites list immediately
      if (wasInFavorites) {
        _favoriteBooks.removeWhere((book) => book.id == bookId);
      } else {
        // If adding to favorites, try to get the book from current books list
        final bookToAdd = _books.where((book) => book.id == bookId).firstOrNull;
        if (bookToAdd != null) {
          bookToAdd.isFavorite = true;
          _favoriteBooks.add(bookToAdd);
        } else {
          // Load the book from API if not in current list
          await _loadSingleFavoriteBook(bookId);
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  // Load favorite books from storage - this loads the actual favorite books for saved items page
  Future<void> loadFavoriteBooks() async {
    _setLoading(true);

    try {
      final favoriteIds = await _getFavoriteBookIds();

      if (favoriteIds.isEmpty) {
        _favoriteBooks = [];
        _setLoading(false);
        return;
      }

      // Load favorite books from API
      List<Book> loadedFavorites = [];

      for (String bookId in favoriteIds) {
        try {
          final result = await BooksApiService.getBookById(bookId);
          if (result.isSuccess && result.data != null) {
            final book = result.data!;
            book.isFavorite = true;
            loadedFavorites.add(book);
          }
        } catch (e) {
          print('Error loading favorite book $bookId: $e');
        }
      }

      _favoriteBooks = loadedFavorites;
    } catch (e) {
      print('Error loading favorite books: $e');
      _favoriteBooks = [];
    }

    _setLoading(false);
  }

  // Load a single favorite book (helper method)
  Future<void> _loadSingleFavoriteBook(String bookId) async {
    try {
      final result = await BooksApiService.getBookById(bookId);
      if (result.isSuccess && result.data != null) {
        final book = result.data!;
        book.isFavorite = true;
        _favoriteBooks.add(book);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading single favorite book $bookId: $e');
    }
  }

  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<List<Book>> _applyFavoriteStatus(List<Book> books) async {
    final favoriteIds = await _getFavoriteBookIds();

    return books.map((book) {
      book.isFavorite = favoriteIds.contains(book.id);
      return book;
    }).toList();
  }

  Future<List<String>> _getFavoriteBookIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      return prefs.getStringList('favorite_books') ?? [];
    } catch (e) {
      print('Error getting favorite book IDs: $e');
      return [];
    }
  }

  Future<bool> _isBookFavorite(String bookId) async {
    final favoriteIds = await _getFavoriteBookIds();
    return favoriteIds.contains(bookId);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Get a specific book by ID from current books
  Book? getBookById(String bookId) {
    try {
      return _books.firstWhere((book) => book.id == bookId);
    } catch (e) {
      return null;
    }
  }

  // Clear books list (useful for home page when switching categories)
  void clearBooks() {
    _books = [];
    notifyListeners();
  }
}