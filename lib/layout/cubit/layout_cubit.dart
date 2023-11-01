// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/diohelper.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/modules/Screens/Categories_Screen/categories_screen.dart';
import 'package:shoping/modules/Screens/authinticationScreen/login_screen.dart';
import 'package:shoping/modules/Screens/profile_screen/profile_screen.dart';
import 'package:shoping/modules/Screens/snackbar.dart';
import '../../models/banner_model.dart';
import '../../models/changecartmodel.dart';
import '../../models/changefavouritemodel.dart';
import '../../models/favouritemodel.dart';
import '../../models/product_model.dart';

import 'package:flutter/material.dart';

import '../../models/productdetailesmodels.dart';
import '../../models/usermodel.dart';
import '../../modules/Screens/Cart_screen/cart_screen.dart';
import '../../modules/Screens/favorites_screen/favorites_screen.dart';
import '../../modules/Screens/home_screen/home_screen.dart';
import '../../shared/constants/constant.dart';
import '../../shared/network/local_network.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  ProductDetailsModel? productDetailsModel;
  ChangeCartModel? changeCartModel;
  FavoritesModel? favoritesModel;

  Map<int, bool?> cart = {};
  // Map<int, bool?> favorites = {};

  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    // Emit state
    emit(ChangeBottomNavIndexState());
  }

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/profile"),
        headers: {'Authorization': userToken!, "lang": "en"});
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);
      // debugPrint("response is : $responseData");
      emit(GetUserDataSuccessState());
    } else {
      // print("response is : $responseData");
      emit(FailedToGetUserDataState(error: responseData['message']));
    }
  }

  List<BannerModel> banners = [];
  void getBannersData() async {
    Response response =
        await http.get(Uri.parse("https://student.valuxapps.com/api/banners"));
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannersSuccessState());
    } else {
      emit(FailedToGetBannersState());
    }
  }

  // List<CategoryModel> categories = [];
  // void getCategoriesData() async {
  //   Response response = await http.get(
  //       Uri.parse("https://student.valuxapps.com/api/categories"),
  //       headers: {'lang': "en"});
  //   final responseBody = jsonDecode(response.body);
  //   if (responseBody['status'] == true) {
  //     for (var item in responseBody['data']['data']) {
  //       categories.add(CategoryModel.fromJson(data: item));
  //     }
  //     emit(GetCategoriesSuccessState());
  //   } else {
  //     emit(FailedToGetCategoriesState());
  //   }
  // }
  List<CategoriesModel> categories = [];
  void getCategoriesData() async {
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories"),
        headers: {'lang': "en"});
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        categories.add(CategoriesModel.fromJson(data: item));
      }
      emit(GetCategoriesSuccessState());
    } else {
      emit(FailedToGetCategoriesState());
    }
  }

  List<productModel> products = [];
  void getProducts() async {
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/home"),
        headers: {'Authorization': userToken!, 'lang': "en"});
    var responseBody = jsonDecode(response.body);

    /// print("Products Data is : $responseBody");
    // loop list
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(productModel.fromJson(data: item));
      }
      emit(GetProductsSuccessState());
    } else {
      emit(FailedToGetProductsState());
    }
  }

  // filtered products
  List<productModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProductsSuccessState());
  }

  List<productModel> favorites = [];
  // set مفيش تكرار
  Set<String> favoritesID = {};
  Future<void> getFavorites() async {
    favorites.clear();
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {"lang": "en", "Authorization": userToken!});
    // http
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      // loop list
      for (var item in responseBody['data']['data']) {
        // Refactoring
        favorites.add(productModel.fromJson(data: item['product']));
        favoritesID.add(item['product']['id'].toString());
      }
      print("Favorites number is : ${favorites.length}");
      emit(GetFavoritesSuccessState());
    } else {
      emit(FailedToGetFavoritesState());
    }
  }

  ChangeFavoritsModel? changeFavoritsModel;
  void changeFavorits(int productId) async {
    Map<int, bool?> favorites = {};
    favorites[productId] = !favorites[productId]!;
    emit(ShopInitialChangeFavoritsDataState());
    await DioHelper.postData(
      url: baseUrl + FAVORITES,
      data: {
        'product_id': productId,
      },
      token: userToken,
    ).then((value) {
      changeFavoritsModel = ChangeFavoritsModel.fromJson(value.data);
      if (changeFavoritsModel?.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
        emit(ShopLoadingGetFavoritsDataState());
      }
      print(value.data);
      emit(ShopSuccessChangeFavoritsDataState(changeFavoritsModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      print(error.toString());
      emit(ShopErrorChangeFavoritsDataState());
    });
  }

  void addOrRemoveFromFavorites({required String productID}) async {
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {"lang": "en", "Authorization": userToken!},
        body: {"product_id": productID});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoritesID.contains(productID) == true) {
        // delete
        favoritesID.remove(productID);
      } else {
        // add
        favoritesID.add(productID);
      }
      await getFavorites();
      emit(AddOrRemoveItemFromFavoritesSuccessState());
    } else {
      emit(FailedToAddOrRemoveItemFromFavoritesState());
    }
  }

  // List<ProductModel> carts = [];
  // int totalPrice = 0;
  // void getCarts() async {
  //   carts.clear();
  //   Response response = await http.get(
  //       Uri.parse("https://student.valuxapps.com/api/carts"),
  //       headers: {"Authorization": userToken!, "lang": "en"});
  //   var responseBody = jsonDecode(response.body);
  //   if (responseBody['status'] == true) {
  //     // success
  //     for (var item in responseBody['data']['cart_items']) {
  //       carts.add(ProductModel.fromJson(data: item['product']));
  //     }
  //     totalPrice = responseBody['data']['total'];
  //     debugPrint("Carts length is : ${carts.length}");
  //     emit(GetCartsSuccessState());
  //   } else {
  //     // failed
  //     emit(FailedToGetCartsState());
  //   }
  // }
  List<productModel> carts = [];
  Set<String> cartsID = {};
  int totalPrice = 0;
  Future<void> getCarts() async {
    carts.clear();

    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers: {"Authorization": userToken!, "lang": "en"});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      // success
      for (var item in responseBody['data']['cart_items']) {
        carts.add(productModel.fromJson(data: item['product']));
        cartsID.add(item['product']['id'].toString());
      }
      totalPrice = responseBody['data']['total'];
      debugPrint("Carts length is : ${carts.length}");
      emit(GetCartsSuccessState());
    } else {
      // failed
      emit(FailedToGetCartsState());
    }
  }

  void changeCart(int productId) async {
    print(cart[55]);
    cart[productId] = !cart[productId]!;
    emit(ShopLoadingChangeCartDataState());
    await DioHelper.postData(
      url: baseUrl + CART,
      data: {
        'product_id': productId,
      },
      token: userToken,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if (changeCartModel?.status == false) {
        cart[productId] = !cart[productId]!;
      } else {
        emit(ShopLoadingChangeCartDataState());

        getCarts();
        emit(ShopLoadingGetCartDataState());
      }
      print('value.data ${value.data}');
      emit(ShopSuccessChangeCartDataState(changeCartModel));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      print(error.toString());
      emit(ShopErrorChangeCartDataState());
    });
  }

  void addOrRemoveProductFromCart({required String id}) async {
    // Response response = await http.post(
    //     Uri.parse("https://student.valuxapps.com/api/carts"),
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers: {"lang": "en", "Authorization": userToken!},
        body: {"product_id": id});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      // if (cartsID.contains(id) == true) {
      //   cartsID.remove(id);
      // } else {
      //   cartsID.add(id);
      // }
      cartsID.contains(id) == true ? cartsID.remove(id) : cartsID.add(id);

      getCarts();
      emit(AddToCartSuccessState());
    } else {
      emit(FailedToAddToCartState());
    }
  }

  void changePassword(
      {required String userCurrentPassword,
      required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        headers: {
          'lang': 'en',
          'Authorization': userToken!
        },
        body: {
          'current_password': userCurrentPassword,
          'new_password': newPassword,
        });
    var responseDecoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseDecoded['status'] == true) {
        await CacheNetwork.insertToCache(key: 'password', value: newPassword);
        currentPassword = await CacheNetwork.getCacheData(key: "password");
        emit(ChangePasswordSuccessState());
      } else {
        emit(ChangePasswordWithFailureState(responseDecoded['message']));
      }
    } else {
      emit(ChangePasswordWithFailureState(
          "something went wrong, try again later"));
    }
  }

  void updateUserData(
      {required String name,
      required String phone,
      required String email}) async {
    emit(UpdateUserDataLoadingState());
    try {
      Response response = await http.put(
          Uri.parse("https://student.valuxapps.com/api/update-profile"),
          headers: {'lang': 'en', 'Authorization': userToken!},
          body: {'name': name, 'email': email, 'phone': phone});
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        await getUserData();
        emit(UpdateUserDataSuccessState());
      } else {
        emit(UpdateUserDataWithFailureState(responseBody['message']));
      }
    } catch (e) {
      emit(UpdateUserDataWithFailureState(e.toString()));
    }
  }

  Future<void> getProductDetailsData(int id) async {
    if (id == null) return;
    emit(ProductLoadingDataState());
    await DioHelper.getData(
      url: baseUrl + PRODUCTS + '$id',
      token: userToken,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ProductSuccessDataState());
    }).catchError((error) {
      print('error in product details is: ');
      print(error.toString());
      emit(ProductErrorDataState());
    });
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userToken', '');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
