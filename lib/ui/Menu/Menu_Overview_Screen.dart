
import 'package:flutter/material.dart';
import 'package:myshop/ui/ListMenu/ListMenu_manager.dart';
import 'package:myshop/ui/ListMenu/ListMenu_screen.dart';
import 'package:myshop/ui/Menu/Menu_manager.dart';
import 'package:myshop/ui/Menu/user_menu_screen.dart';
import 'package:myshop/ui/Profile/profile_screen.dart';
import 'package:myshop/ui/auth/auth_manager.dart';
import 'package:myshop/ui/share/app_drawer.dart';
import 'package:provider/provider.dart';
import 'Menu_grid.dart';
import 'top_right_badge.dart';


enum FilterOptions {favorites , all}

class ProductOverviewScreen extends StatefulWidget {
  
  const ProductOverviewScreen({super.key});
  Future<void> _logout (BuildContext context) async{
    await context.read<AuthManager>().logout();
  }

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreen();
}

class _ProductOverviewScreen extends State<ProductOverviewScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
  ListMenuScreen(),
    UserProductScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final _showOnlyFavorite = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState(){
    super.initState();
    _fetchProducts = context.read<MenuManager>().fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe app'),
       
      ),
      drawer:  const AppDrawer(
      
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
    
      // body: FutureBuilder(
      
        
      //   future: _fetchProducts,
      //   builder: ((context, snapshot) {
      //     if(snapshot.connectionState == ConnectionState.done){
      //       return ValueListenableBuilder<bool>(valueListenable: _showOnlyFavorite, 
      //       builder: (context, value, child) {
              
      //         return MenuGrid(value);
      //       });
      //     }
          
      //     return const Center(
      //       child: CircularProgressIndicator(),
            
      //     );
      //   }),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Account',
            
            
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildShoppingCartIcon(){
    return Consumer<ListMenuManager>(
     builder: (context, cartManager, child)  {
      return TopRightBadge(
      data: cartManager.productCount,
      child: IconButton(icon: const Icon(Icons.check),
      onPressed: () {
        Navigator.of(context).pushNamed(ListMenuScreen.routeName);
      },),
      
    );
     });
  }

   Widget _listViewBody() {
    return  FutureBuilder(
      
        
        future: _fetchProducts,
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ValueListenableBuilder<bool>(valueListenable: _showOnlyFavorite, 
            builder: (context, value, child) {
              
              return MenuGrid(value);
            });
          }
          
          return const Center(
            child: CircularProgressIndicator(),
            
          );
        }),
      );
  }

  


  Widget buildProductFilterMenu(){
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue){
     if(selectedValue == FilterOptions.favorites){
      _showOnlyFavorite.value =true;
     } else{
      _showOnlyFavorite.value = false;
     }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorite'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show all'),
        )
      ],
    );
  }
}