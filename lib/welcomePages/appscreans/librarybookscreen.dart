import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/mytheme.dart';
import 'package:flutterlearniti/core/widget/helper.dart';

class Librarybookscreen extends StatefulWidget {
  const Librarybookscreen({super.key});

  @override
  State<Librarybookscreen> createState() => _LibrarybookscreenState();
}

class _LibrarybookscreenState extends State<Librarybookscreen> {
  void showErrorDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('An error occurred, please try again later'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق حوار الخطأ
              showConfirmDialog(); // عرض حوار التأكيد
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }

  void showConfirmDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text(
          'Are you sure you want to return? The updates have not been saved yet.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //int _currentIndex = 0;
    List<String> imagePaths = [
      'assets/hello/Rectangle4.png',
      'assets/hello/Rectangle11.png',
      'assets/hello/Rectangle11.png',
    ];
    return Scaffold(
      // bottomNavigationBar:BottomNavigationBar(
      //     currentIndex: _currentIndex ,
      //     onTap: (int index){
      //       setState(() {
      //         _currentIndex=index;
      //       });
      //     },
      //     type:BottomNavigationBarType.fixed ,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: IconButton(onPressed: (){}, icon: Icon(Icons.add_ic_call_outlined))
      //       ),
      //   ],
      //   ) ,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.west_rounded)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(imagePaths.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        imagePaths[index],
                        width: 200,
                        height: 300,
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Helper.getResponsiveHeight(context, height: 50),
              ),
              child: Column(
                children: [
                  Text(
                    'The Keeper of Lost Things',
                    style: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: Helper.getResponsiveHeight(context, height: 16),
                  ),
                  Text('by Ruth Hogan', style: theme.textTheme.bodySmall),
                  SizedBox(
                    height: Helper.getResponsiveHeight(context, height: 30),
                  ),

                  Text(
                    'The chime of the clock in the hall said time for gin and lime. He took ice cubes and lime juice from the refrigerator and carried them through to the garden room on a silver drinks tray with a green cocktail glass and a small dish...',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: Helper.getResponsiveWidth(context, width: 300),
              padding: EdgeInsets.all(
                Helper.getResponsiveHeight(context, height: 8),
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 1, 0, 4),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.replay_10)),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context);
                    },
                    icon: Icon(Icons.pause),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.forward_10)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,

              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: Helper.getResponsiveHeight(context, height: 80),
                decoration: BoxDecoration(color: MyPaperbackTheme.bgDarker),
                child: Column(
                  children: [
                    //
                    TextButton(
                      onPressed: showErrorDialog,
                      child: const Text('Show error'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
