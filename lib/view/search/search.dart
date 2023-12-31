import 'dart:developer';
// import 'dart:ffi';

import 'package:comic_hub/controller/comic_controller.dart';
import 'package:comic_hub/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:get/get.dart';

import '../Home/components/card.dart';
import 'package:comic_hub/controller/comic_controller.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final SearchControllerX searchController = Get.put(SearchControllerX());

  final ComicController comicController = Get.put(ComicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => Column(
          children: [
            AnimSearchBar(
              width: MediaQuery.of(context).size.width - 20,
              animationDurationInMilli: 1000,
              helpText: 'Search for a character',
              textController: searchController.textController.value,
              onSuffixTap: () {
                print('Search suffix tapped');
                log('Search suffix tapped');
              },
              rtl: true,
              suffixIcon: const Icon(Icons.search),
              prefixIcon: const Icon(Icons.arrow_back),
              onSubmitted: (String s) {
                // SearchComic();
                searchController.searchCharacter();
              },
            ),
            searchController.searchCharacters.length==0 ?
            Image.network('https://thumbs.gfycat.com/DirtyShimmeringHusky-size_restricted.gif'):Container(),

            searchController.isLoading.value == false
                ? Expanded(
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  mainAxisSpacing:
                  10, // Vertical spacing between grid items
                  crossAxisSpacing:
                  10, // Horizontal spacing between grid items
                ),
                itemCount: searchController.searchCharacters.length,
                itemBuilder: (BuildContext context, int index) {
                  var character =
                  searchController.searchCharacters[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to character details screen
                      comicController.setCharacter(character);
                      Get.toNamed('/details');
                    },
                    child: MyHomeCard(character: character),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
