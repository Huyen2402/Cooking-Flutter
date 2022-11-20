import 'package:flutter/material.dart';
import '../../model/Menu.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(this.product, {super.key});

  final Menu product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
      
        child: Column(
          
          children: <Widget>[
          
            Container(
              
              width: MediaQuery.of(context).size.width,
              
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Text.rich(
              TextSpan(
                children: [
                  
                  TextSpan(
                      text: "Chi tiết món ăn",
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.deepPurple,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                     margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                    width: MediaQuery.of(context).size.width / 3.6,
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        
                       const  Text(
                          "Đánh giá: " ,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                       const SizedBox(
                          height: 4.0,
                        ),
                         
                        Row(
                          children: [
                            Text(
                       product.rating,
                       style:const  TextStyle(
                            fontSize: 20.0
                       ),
                      
                            ),
                           const  Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                          ],
                        ),
                        
                      const  SizedBox(
                          height: 36.0,
                        ),
                      const  Text(
                          "Time: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                     const   SizedBox(
                          height: 4.0,
                        ),
                        Text(product.time,
                          
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      const  SizedBox(
                          height: 36.0,
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    product.imageUrl,
                    height: 250.0,
                    fit: BoxFit.contain,
                    
                  ),
                  
                ],
              ),
            ),
            
         buildTextCachNau(),
            
          ],
        ),
      ),
    );
  }
  Widget buildTextCachNau(){
        return Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
              child: Column(
                children: [
              const SizedBox(
                    height: 24.0,
                  ),
                  const Text(
                    "Cách nấu:",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  
              Text(product.description,)
                ]),
            );
  }

 
}
