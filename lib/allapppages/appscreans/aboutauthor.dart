import 'package:flutter/material.dart';
import 'package:flutterlearniti/provider/bookprovider.dart';
import 'package:provider/provider.dart';

class AboutAuthor extends StatelessWidget {
  const AboutAuthor({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<BooksProvider>(
          builder: (context, value, child) {
          return Column(
            children: [
              Text(''),
              Text(''),
              Row(
                children: [
                  Image.asset(''),
                  Column(
                    children: [
                      Text(''),
                      Text(''),
                    ],
                  ),
                  Text(''),
                  ListView.builder(itemBuilder: (context,index){
                    return ListTile(
                      
                      title: Text(''),
                      subtitle: Text(''),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_outward)),
                      
                    );
                  })
          
                ],
              )
            ],
          ); 
          },
          
        ),
        
      ),
    );
  }
}