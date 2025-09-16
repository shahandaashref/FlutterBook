
import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';
import 'package:flutterlearniti/custom/advaneddrawer.dart';
import 'package:flutterlearniti/custom/customnavbar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  List<Map> books = [
    
        {
    'image': 'assets/hello/Rectangle4.png',
    'title': 'The Keeper of Lost Things',
    'byname': 'by Ruth Hogan',
  },
  {
    'image': 'assets/hello/Rectangle11.png',
    'title': 'The Eye of the World',
    'byname': 'by Robert Jordan',
  },
  {
    'image': 'assets/hello/1.jpg',
    'title': 'Financial success: through the power of creative thought',
    'byname': 'Wallace D. Wattles',
  },
  {
    'image': 'assets/hello/2.jpg',
    'title': 'Guess how much I love you',
    'byname': 'Sam McBratney',
  },
  {
    'image': 'assets/hello/3.jpg',
    'title': 'En llamas',
    'byname': 'Suzanne Collins',
  },
  {
    'image': 'assets/hello/4.jpg',
    'title': 'L\'Idiot Tome Premier',
    'byname': 'Фёдор Михайлович Достоевский',
  },
  {
    'image': 'assets/hello/5.jpg',
    'title': 'Ugly Duckling (Enchanted Tales)',
    'byname': 'Hans Christian Andersen',
  },
  {
    'image': 'assets/hello/6.jpg',
    'title': 'The Voyage of The Dawn Treader',
    'byname': 'C.S. Lewis',
  },
  {
    'image': 'assets/hello/7.jpg',
    'title': 'The Thirty-Nine Steps',
    'byname': 'John Buchan',
  },
  {
    'image': 'assets/hello/8.jpg',
    'title': 'Mr. Macready produces As you like it: a prompt-book study',
    'byname': 'William Shakespeare',
  },
  {
    'image': 'assets/hello/9.jpg',
    'title': 'Great Expectations: And Some Account of an Extraordinary Traveller',
    'byname': 'Charles Dickens',
  },
  {
    'image': 'assets/hello/10.jpg',
    'title': 'Arsène Lupin: Gentleman-Cambrioleur',
    'byname': 'Maurice Leblanc',
  },
  
  ];
  List<Map> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks=books;
  }

  searchfunc(String searchWord) {
      setState(() {
        filteredBooks =  books
            .where(
              (book) {
              
              final title=book['title'].toString().toLowerCase();
              final input=searchWord.toLowerCase();
              return title.startsWith(input);
              } 
            )
            .toList();

            
      });
  }

  void removesearchago(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure delete this tap'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancle'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  //searchago.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Search.', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: ClipOval(
              child: Image.asset(
                'assets/pig/unsplash_QS9ZX5UnS14.png',
                width: Helper.getResponsiveWidth(context, width: 50),
                height: Helper.getResponsiveHeight(context, height: 50),
              ),
            ),
          ),
          //IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),

      drawer: AdvancedDrawer(),


      bottomNavigationBar: Customnavbar(),

      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Helper.getResponsiveWidth(context, width: 30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Helper.getResponsiveHeight(context, height: 80)),
          //   Padding(
          //   padding: EdgeInsets.all(16),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       border: OutlineInputBorder(),
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.search),
          //         onPressed: () {
          //           context.read<BooksProvider>()
          //               .searchBooks(_searchController.text);
          //         },
          //       ),
          //     ),
          //     onSubmitted: (query) {
          //       context.read<BooksProvider>().searchBooks(query);
          //     },
          //   ),
          // ),
            TextFormField(
              controller: _controller,
              
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                focusColor: Color(0xff452345),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    
                    _controller.clear();
                    searchfunc('');
                  });
                }, icon: Icon(Icons.clear)),
                filled: true,
                
              ),
              
              onChanged:searchfunc,
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height: 30)),
            Expanded(
              child: ListView.builder(
                
                shrinkWrap: true,
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final  filteredBook=filteredBooks[index];
                  return ListTile(
                    
                    leading: SizedBox(
                      width: Helper.getResponsiveWidth(context, width: 80),
                      height: Helper.getResponsiveHeight(context, height: 300),
                      child: Image.asset(filteredBook['image'],fit: BoxFit.cover,)),
                    title: Text(filteredBook['title']),
                    subtitle: Text(filteredBook['byname']),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.clear)),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


