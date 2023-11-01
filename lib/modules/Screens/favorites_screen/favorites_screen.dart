import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/style/Style.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12.5),
              child: Expanded(
                child: cubit.carts.isNotEmpty
                    ? Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: const Icon(Icons.clear),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: cubit.favorites.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 12.5),
                                      color: Colors.white70,
                                      child: Row(
                                        children: [
                                          Image.network(
                                            cubit.favorites[index].image!,
                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                cubit.favorites[index].name!,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: mainColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${cubit.favorites[index].price!}\$"),
                                              MaterialButton(
                                                onPressed: () {
                                                  cubit
                                                      .addOrRemoveFromFavorites(
                                                          productID: cubit
                                                              .favorites[index]
                                                              .id
                                                              .toString());
                                                },
                                                // ignore: sort_child_properties_last
                                                child: const Text("Remove"),
                                                textColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                color: mainColor,
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                    );
                                  }))
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: Center(
                            child: Column(
                          children: [
                            Image.asset("assets/surprised.png"),
                            const Text(
                              "your Favorite is empty",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                      ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
