// services/Book_api_service.dart
import 'dart:convert';
import 'package:flutterlearniti/model/books.dart';
import 'package:http/http.dart' as http;

class BooksApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  // Search books with query
  static Future<ApiResult<List<Book>>> searchBooks(String query) async {
    try {
      final encodedQuery = Uri.encodeComponent(query);
      final url = '$_baseUrl?q=$encodedQuery&maxResults=20&printType=books';
      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'})
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        if (items.isEmpty) {
          return ApiResult.success(<Book>[]);
        }
        final books = items
            .map((item) {
              try {
                return Book.fromJson(item);
              } catch (e) {
                print('Error parsing book item: $e');
                return null;
              }
            })
            .where((book) => book != null)
            .cast<Book>()
            .toList();

        print('API Response Items Count: ${items.length}'); // Debug log

        if (items.isEmpty) {
          return ApiResult.success(<Book>[]);
        }
        return ApiResult.success(books);
      } else {
        final errorMsg =
            'HTTP ${response.statusCode}: ${response.reasonPhrase}';
        print('API Error: $errorMsg'); // Debug log
        return ApiResult.failure(errorMsg);
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  // Get book details by ID
  static Future<ApiResult<Book>> getBookById(String id) async {
    try {
      if (id.isEmpty) {
        return ApiResult.failure('Book ID cannot be empty');
      }

      final url = '$_baseUrl/$id';

      print('Get Book by ID URL: $url'); // Debug log

      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'})
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final book = Book.fromJson(data);
        return ApiResult.success(book);
      } else if (response.statusCode == 404) {
        return ApiResult.failure('Book not found');
      } else {
        return ApiResult.failure(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Get Book by ID Exception: $e'); // Debug log
      return ApiResult.failure('Network error: $e');
    }
  }

  // Get popular books by category
  static Future<ApiResult<List<Book>>> getBooksByCategory(
    String category,
  ) async {
    if (category.isEmpty) {
      return ApiResult.failure('Category cannot be empty');
    }
    return searchBooks('subject:$category');
  }

  // Get trending books (popular fiction books)
  static Future<ApiResult<List<Book>>> getTrendingBooks() async {
    // Try multiple queries to ensure we get results
    const queries = [
      'bestsellers',
      'popular fiction',
      'subject:fiction',
      'fiction bestsellers',
      'recent fiction',
    ];

    for (String query in queries) {
      try {
        print('Trying trending query: $query'); // Debug log
        final result = await searchBooks(query);

        if (result.isSuccess &&
            result.data != null &&
            result.data!.isNotEmpty) {
          print(
            'Success with query: $query, found ${result.data!.length} books',
          ); // Debug log
          return result;
        }
      } catch (e) {
        print('Error with query "$query": $e');
        continue;
      }
    }

    // If all queries fail, try a simple search
    print('All trending queries failed, trying simple search'); // Debug log
    return searchBooks('books');
  }

  // Test API connectivity
  static Future<bool> testConnection() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl?q=test&maxResults=1'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}

// Simple result wrapper
class ApiResult<T> {
  final bool isSuccess;
  final T? data;
  final String? error;

  ApiResult._(this.isSuccess, this.data, this.error);

  factory ApiResult.success(T data) => ApiResult._(true, data, null);

  factory ApiResult.failure(String error) => ApiResult._(false, null, error);

  @override
  String toString() {
    if (isSuccess) {
      return 'ApiResult.success($data)';
    } else {
      return 'ApiResult.failure($error)';
    }
  }
}