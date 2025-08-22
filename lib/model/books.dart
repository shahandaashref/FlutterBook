// models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingsCount;
  final String category;
  final int pageCount;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.ratingsCount,
    required this.category,
    required this.pageCount,
    this.isFavorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Unknown Title',
      author:
          (volumeInfo['authors'] as List<dynamic>?)?.join(', ') ??
          'Unknown Author',
      description: volumeInfo['description'] ?? 'No description available.',
      imageUrl: imageLinks['thumbnail'] ?? imageLinks['smallThumbnail'] ?? '',
      rating: (volumeInfo['averageRating'] ?? 0.0).toDouble(),
      ratingsCount: volumeInfo['ratingsCount'] ?? 0,
      category:
          (volumeInfo['categories'] as List<dynamic>?)?.first ?? 'General',
      pageCount: volumeInfo['pageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'ratingsCount': ratingsCount,
      'category': category,
      'pageCount': pageCount,
      'isFavorite': isFavorite,
    };
  }

  Book copyWith({bool? isFavorite}) {
    return Book(
      id: id,
      title: title,
      author: author,
      description: description,
      imageUrl: imageUrl,
      rating: rating,
      ratingsCount: ratingsCount,
      category: category,
      pageCount: pageCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}