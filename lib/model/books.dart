// models/book.dart
class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingsCount;
  final String category;
  final int pageCount;
  String? thumbnail;
  String? publishedDate;
  bool isFavorite;
  String webReaderLink;

  Book({
    required this.webReaderLink,
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.ratingsCount,
    required this.category,
    required this.pageCount,
    this.publishedDate='',
    this.thumbnail='',
    this.isFavorite = false,
  }){
      webReaderLink=_ensureHttps(webReaderLink);
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};
    final accessInfo=json['accessInfo']??{};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Unknown Title',
      authors: (volumeInfo['authors'] as List?)?.map((e) => e.toString()).toList() ?? [],
      description: volumeInfo['description'] ?? 'No description available.',
      imageUrl: imageLinks['thumbnail'] ?? imageLinks['smallThumbnail'] ?? '',
      rating: (volumeInfo['averageRating'] ?? 0.0).toDouble(),
      ratingsCount: volumeInfo['ratingsCount'] ?? 0,
      category:
          (volumeInfo['categories'] as List<dynamic>?)?.first ?? 'General',
      pageCount: volumeInfo['pageCount'] ?? 0,
      publishedDate: volumeInfo['publishedDate']??' ',
      webReaderLink:accessInfo['webReaderLink']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': authors,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'ratingsCount': ratingsCount,
      'category': category,
      'pageCount': pageCount,
      'isFavorite': isFavorite,
      'publishedDate': publishedDate,
      'webReaderLink':webReaderLink,

    };
  }

  Book copyWith({bool? isFavorite}) {
    return Book(
      id: id,
      title: title,
      authors: authors,
      description: description,
      imageUrl: imageUrl,
      rating: rating,
      ratingsCount: ratingsCount,
      category: category,
      pageCount: pageCount,
      publishedDate: publishedDate,
      isFavorite: isFavorite ?? this.isFavorite,
      webReaderLink:webReaderLink,
    );
  }

  static String _ensureHttps(String url) {
    if (url.isEmpty) return url;
    
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    
    return url;
  }
}