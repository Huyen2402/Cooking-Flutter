
import 'package:flutter/material.dart';

import 'auth_card.dart';
import 'app_banner.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body:   AuthCard(),
      // resizeToAvoidBottomInset: false,
      // body: Stack(
      //   children: [
      //     Container(
      //       margin:const EdgeInsets.only(top: 400),
      //       width: double.infinity,
      //       height: 450,
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
      //       ),
      //     ),
      //     Container(
      //       padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //        margin:const EdgeInsets.only(top: 200, left: 50, right: 50),
            
      //       width: double.infinity,
      //       height: 400,
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(12),
      //         boxShadow: const [
      //           BoxShadow(
      //             color: Colors.black38,
      //             spreadRadius: 0.1,
      //             blurRadius: 5
      //           )
      //         ]
      //       ),
      //       child: Column(children: [
      //         TextFormField(
      //           decoration: InputDecoration(
      //             hintText: "Email",
      //             prefixIcon:const Icon(Icons.email),
      //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      //           ),
      //         ),
      //         const SizedBox(height: 20,),
      //         TextField(
      //           decoration: InputDecoration(
      //             hintText: "Password",
      //             prefixIcon:const Icon(Icons.key),
      //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.centerRight,
      //           child: TextButton(onPressed: () {
                  
      //           },
      //           child:const Text("Quên Mật Khẩu"),
                
      //           ),
      //         ),
      //         ElevatedButton(
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.deepPurple,
      //             padding: EdgeInsets.symmetric(horizontal: 50)
      //           ),
      //           onPressed: (){},
              
      //          child:const Text("Đăng Nhập")
      //          ),
      //          Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children:  [
      //             Text("Bạn chưa có tài khoản??"),
      //             TextButton(onPressed: (){}, 
      //             child: Text("Đăng Ký"))
      //           ],
      //          )

      //       ]),
      //     ),
      //     Positioned(
      //       top: 70, left: 35,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //       children: const [
      //         Text("Xin chào", 
      //          style:  TextStyle(color: Colors.white,
      //         fontWeight: FontWeight.bold, fontSize: 40),
              
      //         ),
      //         Text("Chào mừng bạn đến với Cooking with me", 
      //         style: TextStyle(color: Colors.white,
      //         fontWeight: FontWeight.w300, fontSize: 17),
              
      //         ),
              
      //       ],
      //     ))
          
      //     // Container(
      //     //   decoration: BoxDecoration(
      //     //     gradient: LinearGradient(
      //     //       colors: [
      //     //         Color.fromARGB(255, 236, 231, 238).withOpacity(0.5),
      //     //         Color.fromARGB(255, 70, 148, 153).withOpacity(0.9),
      //     //       ],
      //     //       begin: Alignment.topLeft,
      //     //       end: Alignment.bottomRight,
      //     //       stops: const [0, 1],
      //     //     ),
      //     //   ),
      //     // ),
      //     // SingleChildScrollView(
      //     //   child: SizedBox(
      //     //     height: deviceSize.height,
      //     //     width: deviceSize.width,
      //     //     child: Column(
      //     //       mainAxisAlignment: MainAxisAlignment.center,
      //     //       crossAxisAlignment: CrossAxisAlignment.center,
      //     //       children: <Widget>[
      //     //         const Flexible(
      //     //           child: AppBanner(),
      //     //         ),
      //     //         Flexible(
      //     //           flex: deviceSize.width > 600 ? 2 : 1,
      //     //           child: const AuthCard(),
      //     //         ),
      //     //       ],
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
