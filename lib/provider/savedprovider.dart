import 'package:flutter/material.dart';
import 'package:flutterlearniti/model/bookmodel.dart';

class Savedprovider extends ChangeNotifier{

    List<Bookmodel> savedBook=[];
    List<Bookmodel> get savedBooks => savedBook;

    
    bool isBookSaved(String bookId) {
    return savedBooks.any((book) => book.id == bookId);
  }
    bool addBook(Bookmodel book) {
  if (!isBookSaved(book.id)) {
    savedBooks.add(book);
    return true;
  }
  return false; 
}

    bool removeBookByIndex(int index) {
    if (index >= 0 && index < savedBooks.length) {
      savedBooks.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

}
