// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/models/product_model.dart';
import 'package:shoping/modules/Screens/home_screen/productdetail.dart';
import 'package:shoping/style/Style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../layout/cubit/layout_cubit.dart';

import '../../widgets/components/toast.dart';

class HomeScreen extends StatelessWidget {
  final pageController = PageController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritsDataState) {
          if (state.model!.status == false) {
            defaultToast(
                message: state.model!.message, state: ToastState.ERROR);
          } else {
            defaultToast(
                message: state.model!.message, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        if (cubit.userModel == null) cubit.getUserData();
        return Scaffold(
            body: cubit.userModel != null
                ? ListView(shrinkWrap: true, children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Welcome, ',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Text(
                                        cubit.userModel!.name!,
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'in',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const Text(
                                    'VODAI',
                                    style: TextStyle(
                                        fontSize: 38.0,
                                        fontWeight: FontWeight.w900,
                                        color: mainColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          onChanged: (input) {
                            cubit.filterProducts(input: input);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            suffixIcon: const Icon(Icons.clear),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    cubit.banners.isEmpty
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : SizedBox(
                            height: 125,
                            width: double.infinity,
                            child: PageView.builder(
                                controller: pageController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: Image.network(
                                      cubit.banners[index].url!,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        axisDirection: Axis.horizontal,
                        effect: const SlideEffect(
                            spacing: 8.0,
                            radius: 20,
                            dotWidth: 10,
                            dotHeight: 10.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: secondColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "View all",
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    cubit.categories.isEmpty
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.categories.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 15,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      cubit.categories[index].url!,
                                    ),
                                  );
                                }),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "View all",
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    cubit.products.isEmpty
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : GridView.builder(
                            itemCount: cubit.filteredProducts.isEmpty
                                ? cubit.products.length
                                : cubit.filteredProducts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, index) {
                              return _productItem(
                                  //  model: Cubit.filteredProducts.isEmpty
                                  //           ? Cubit.products[index]
                                  //           : Cubit.productsfilter[index],
                                  //       cubit: Cubit,
                                  //       context: context);
                                  model: cubit.filteredProducts.isEmpty
                                      ? cubit.products[index]
                                      : cubit.filteredProducts[index],
                                  cubit: cubit,
                                  context: context);
                            })
                  ])
                : const Center());
      },
    );
  }
}

Widget _productItem(
    {required productModel model,
    required LayoutCubit cubit,
    required BuildContext context}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailes(product: model)));
        },
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  model.image!,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                model.name!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "${model.price!} \$",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${model.oldPrice!} \$",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13.5,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: cubit.favoritesID.contains(model.id.toString())
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onTap: () {
                      cubit.addOrRemoveFromFavorites(
                          productID: model.id.toString());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      CircleAvatar(
        backgroundColor: Colors.black,
        child: GestureDetector(
          onTap: () {
            cubit.addOrRemoveProductFromCart(id: model.id.toString());
          },
          child: Icon(
            Icons.shopping_cart,
            color: cubit.cartsID.contains(model.id.toString())
                ? Colors.red
                : Colors.white,
          ),
        ),
      )
    ],
  );
}
