// ignore_for_file: override_on_non_overriding_member, unused_local_variable, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/models/product_model.dart';
import 'package:shoping/modules/widgets/components/button.dart';

import 'package:shoping/style/Style.dart';

import '../../../models/productdetailesmodels.dart';

import '../../widgets/components/toast.dart';

class detailes extends StatefulWidget {
  final productModel product;
  const detailes({required this.product});

  @override
  State<detailes> createState() => _detailesState();
}

class _detailesState extends State<detailes> {
  @override
  int quantity = 1; // Initial quantity is 1

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    final ProductDetailsModel? productModel =
        LayoutCubit.get(context).productDetailsModel;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeCartDataState) {
          if (state.model!.status == true) {
            defaultToast(
                message: state.model!.message!, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: KPromary9color,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: mainColor,
              ),
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Image.network(
                                  widget.product.image!,
                                  height: 400,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.product.name!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          const Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.product.description!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Price : ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            ' \$${widget.product.price}',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      ' \$${widget.product.oldPrice}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: defaultButton(
                                      color: mainColor,
                                      onPressed: () {
                                        // LayoutCubit.get(context)
                                        //             .cart[productModel.data!.id] ==
                                        //         true
                                        //     ? navigateTo(context, CartScreen())
                                        //     : LayoutCubit.get(context)
                                        //         .changeCart(productModel.data!.id);
                                      },
                                      text: 'Add To Cart',
                                      // LayoutCubit.get(context)
                                      //             .cart[productModel!.data!.id] ==
                                      //         true
                                      //     ? 'Go To Cart '
                                      //     : 'Add To Cart',
                                      textColor: Colors.white,
                                      // color: LayoutCubit.get(context)
                                      //             .cart[productModel.data!.id] ==
                                      //         true
                                      //     ? Colors.black
                                      //     : mainColor,
                                      isUpperCase: false,
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget cartItem(
  productModel model,
  LayoutCubit cubit,
) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: mainColor,
            boxShadow: CustomTheme.buttonShadow),
        child: MaterialButton(
          onPressed: () {
            cubit.addOrRemoveProductFromCart(id: model.id.toString());
          },
        ),
      ),
    ],
  );
}
