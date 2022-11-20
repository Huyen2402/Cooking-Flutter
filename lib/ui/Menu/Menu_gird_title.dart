import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import '../../model/Menu.dart';
import 'Menu_Detail_Screen.dart';

class ProductGirdTitle extends StatelessWidget {
  const ProductGirdTitle(this.product, {super.key});
  final Menu product;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,

            ),
            blurRadius: 10.0,
            spreadRadius: -6.0
          )
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
            
            ),
            image: NetworkImage(product.imageUrl),
             fit: BoxFit.cover,
          )
      ),
      child: Stack(
       
        children: [
          GestureDetector(
            
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          
          ),
          buildGiaoDienItems(),
          buildGirdFooterBar(),
          
        ],
      ),
    
    );
  }

  Widget buildGiaoDienItems(){
    return Align(
            
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          
          );
  }

  Widget buildGirdFooterBar() {
    return  Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 62, 62).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children:[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 10,
                      ),
                      SizedBox(width: 7,),
                      Text(product.rating),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 172, 62, 62).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15)
                
                  ),
                  child: Row(children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.yellow,
                      size: 18,
                    ),
                    SizedBox(width: 7,),
                   Text(product.time),
                  ]),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          );
  }
}
