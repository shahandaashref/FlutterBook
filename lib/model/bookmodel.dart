class Bookmodel {
  String title;
  String author;
  String image;
  String id;
  String? description;
  double rate;
  String? category;
  Bookmodel({
    required this.title,
    required this.author,
    required this.image,
    required this.id,
    this.description,
    required this.rate,
    this.category,
  });

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, author: $author)';
  }
}
