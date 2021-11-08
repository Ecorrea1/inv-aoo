import 'package:flutter/material.dart';
import 'package:invapp/screen/category/category_list_screen.dart';
import 'package:invapp/screen/category/category_screen.dart';
import 'package:invapp/screen/historic/historic_list.screen.dart';
import 'package:invapp/screen/historic/historic_screen.dart';
// import 'package:invapp/screen/home/home_screen.dart';
import 'package:invapp/screen/loading/loading_screen.dart';
import 'package:invapp/screen/login/login_screen.dart';
import 'package:invapp/screen/menu/menu_screen.dart';
import 'package:invapp/screen/product/addProduct/add_product_screen.dart';
import 'package:invapp/screen/product/menu/product_group_page.dart';
import 'package:invapp/screen/product/menu/product_group_page_admin.dart';
import 'package:invapp/screen/product/product_list_screen.dart';
import 'package:invapp/screen/product/product_screem.dart';
import 'package:invapp/screen/product/updateProduct/update_product_screen.dart';
import 'package:invapp/screen/register/register_screen.dart';
// import 'package:invapp/screen/roles/roles_screen.dart';
import 'package:invapp/screen/status/status_screen.dart';
import 'package:invapp/screen/ubication/addUbication/add_ubication_screen.dart';
import 'package:invapp/screen/ubication/ubication_list_screen.dart';
import 'package:invapp/screen/ubication/ubication_screen.dart';
import 'package:invapp/screen/user/user_list_screen.dart';
import 'package:invapp/screen/user/user_screen.dart';

final Map<String, Widget Function(BuildContext)>appRoutes  = {
  // 'home'            :(_) => HomeScreen(),
  'menu'            :(_) => MainMenuScreen(),
  'product'         :(_) => ProductListScreen(),
  'add-product'     :(_) => AddProductScreen(),
  'update-product'  :(_) => UpdateProductScreen(),
  'product-detail'  :(_) => ProductScreen(),
  'product-group'   :(_) => ProductGroupScreen(),
  'group-admin'     :(_) => ProductGroupAdminScreen(),
  'status'          :(_) => StatusScreen(),
  'login'           :(_) => LoginScreen(),
  'register'        :(_) => RegisterScreen(),
  'loading'         :(_) => LoadingScreen(),
  'historic'        :(_) => HistoricListScreen(),
  'historic-detail' :(_) => HistoricScreen(),
  'category'        :(_) => CategoryListScreen(),
  'category-detail' :(_) => CategoryScreen(),
  'add-category'    :(_) => CategoryScreen(),
  'ubication'       :(_) => UbicationListScreen(),
  'ubication-detail':(_) => UbicationScreen(),
  'add-ubication'   :(_) => AddUbicationScreen(),
  'update-ubication':(_) => AddUbicationScreen(),
  'user'            :(_) => UserListScreen(),
  'user-detail'     :(_) => UserScreen(),
  // 'roles'           :(_) => RoleScreen(),
  // 'role-detail'     :(_) => RoleScreen()
};