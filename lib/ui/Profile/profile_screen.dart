import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myshop/ui/Profile/body_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Column(
      children: <Widget>[
          SizedBox(
            height: 160,
            child: Stack(
              children: <Widget>
              [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                  height: 160,
                  color: Colors.deepPurple,
                ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: 120,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2
                            ),
                          image: const DecorationImage(image: AssetImage("assets/283244875_1337035116819947_326616987333753633_n.jpg"),
                          fit: BoxFit.cover)
                          
                        ),
                      ),
                      const Text("Ori Phan", style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 7,),
                       const Text("OriPhan@gmail.com", style: TextStyle(fontWeight: FontWeight.w300),)
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){},
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 45),
          child: Column(children: [
            SizedBox(
              height: 60,
              child: Row(
            
            children: const [
               Icon(Icons.pending_actions),
              // Text("Họ và tên:", style: TextStyle(fontSize: 16),),
              SizedBox(width: 10,),
              Text("Cập nhật thông tin", style: TextStyle(fontSize: 16),),
             
              Spacer(),
               Icon(Icons.arrow_forward_ios),
            ],
          ),
          
            ),
             SizedBox(
               height: 60,
              child: Row(
            
            children: const [
               Icon(Icons.key),
              // Text("Họ và tên:", style: TextStyle(fontSize: 16),),
              SizedBox(width: 10,),
              Text("Đổi mật khẩu", style: TextStyle(fontSize: 16),),
             
              Spacer(),
               Icon(Icons.arrow_forward_ios),
            ],
          ),
          
            ),
             SizedBox(
               height: 60,
              child: Row(
            
            children: const [
               Icon(Icons.remove_red_eye_outlined),
              // Text("Họ và tên:", style: TextStyle(fontSize: 16),),
              SizedBox(width: 10,),
              Text("Chỉnh sửa quyền xem", style: TextStyle(fontSize: 16),),
             
              Spacer(),
               Icon(Icons.arrow_forward_ios),
            ],
          ),
          
            ),
             SizedBox(
               height: 60,
              child: Row(
            
            children: const [
               Icon(Icons.private_connectivity),
              // Text("Họ và tên:", style: TextStyle(fontSize: 16),),
              SizedBox(width: 10,),
              Text("Cài đặt riêng tư", style: TextStyle(fontSize: 16),),
             
              Spacer(),
               Icon(Icons.arrow_forward_ios),
            ],
          ),
          
            ),
          ],)
          ,
          )
          
          )
      ],
    );
     
    
  }
}

class CustomShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width/2, height, width, height-100);
    path.lineTo(width, 0);
    path.close();
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClip){
    return true;
  }
}