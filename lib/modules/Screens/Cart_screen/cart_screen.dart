// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/style/Style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: thirdColor,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "VODAI",
                  style: TextStyle(
                      fontSize: 38.0,
                      fontWeight: FontWeight.w900,
                      color: mainColor),
                ),
              ),
              titleSpacing: -50,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: cubit.carts.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 12,
                              );
                            },
                            itemCount: cubit.carts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white70),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cubit.carts[index].image!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                        width: 12.5,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.carts[index].name!,
                                            style: const TextStyle(
                                                color: mainColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${cubit.carts[index].price!} \$"),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (cubit.carts[index].price !=
                                                  cubit.carts[index].oldPrice)
                                                Text(
                                                  "${cubit.carts[index].oldPrice!} \$",
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    cubit
                                                        .addOrRemoveFromFavorites(
                                                            productID: cubit
                                                                .carts[index].id
                                                                .toString());
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: cubit.favoritesID
                                                            .contains(cubit
                                                                .carts[index].id
                                                                .toString())
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit
                                                      .addOrRemoveProductFromCart(
                                                          id: cubit
                                                              .carts[index].id
                                                              .toString());
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: Center(
                                child: Column(
                              children: [
                                Image.asset("assets/surprised.png"),
                                const Text(
                                  "your Cart is empty",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                          ),
                  ),
                  Container(
                    child: Text(
                      "TotalPrice : ${cubit.totalPrice} \$",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: mainColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
