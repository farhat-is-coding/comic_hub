import 'dart:convert';
import 'dart:developer';

import 'package:comic_hub/model/character.dart';
import 'package:comic_hub/model/teams.dart';
import 'package:comic_hub/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicController extends GetxController {
  /// You do not need that. I recommend using it just for ease of syntax.
  /// with static method: Controller.to.increment();
  /// with no static method: Get.find<Controller>().increment();
  /// There is no difference in performance, nor any side effect of using either
  /// syntax. Only one does not need the type,
  /// and the other the IDE will autocomplete it.
  ///
  static ComicController get to => Get.find();

  var isLoading = false.obs;
  var characters = <Character>[].obs;
  var teams = <Character>[].obs;
  var character = Character(
          id: 0,
          image: {},
          name: '',
          origin: '',
          aliases: '',
          deck: '',
          realName: '')
      .obs;
  var team = Character(
          id: 0,
          image: {},
          name: '',
          origin: '',
          aliases: '',
          deck: '',
          realName: '')
      .obs;

  @override
  void onInit() {
    super.onInit();
    // call API
    getCharacters();
    getTeams();
  }

  void getCharacters() async {
    isLoading(true);
    try {
      var response = await ApiService().getCharacters();
      if (response.statusCode == 200) {
        ///data successfully
        List<dynamic> charactersJson = jsonDecode(response.body)['results'];
        // parsing to model
        characters.value =
            charactersJson.map((e) => Character.fromJson(e)).toList();

        Get.snackbar(
          'Data Fetched successfully',
          "${characters.value.length.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      } else {
        ///error
        Get.snackbar(
          'Error while Fetching',
          "${response.statusCode.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      log('Error while getting data is $e');
      Get.snackbar(
        'Error while Fetching',
        "${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading(false);
    }
  }

  void setCharacter(Character c){
    character(c);
  }



  //get teams

  void getTeams() async {
    isLoading(true);
    try {
      var response = await ApiService().getTeams();
      if (response.statusCode == 200) {
        ///data successfully
        List<dynamic> teamsJson = jsonDecode(response.body)['results'];
        print(teamsJson);
        print(teamsJson[0]);
        print(teamsJson[0]['name']);
        print(teamsJson[0]['deck']);
        print(teamsJson[0]['id']);
        // parsing to model
        //teams.value =
        teams.value =
            //teamsJson.map((e) => Teams.fromJson(e)).toList();
            teamsJson.map((e) => Character.fromJson(e)).toList();
            print(teams.value);
            print(teams.value.length);
        // Get.snackbar(
        //   'Data Fetched successfully',
        //   "${teams.value.length.toString()}",
        //   snackPosition: SnackPosition.BOTTOM,
        //   duration: const Duration(seconds: 1),
        // );
      } else {
        ///error
        Get.snackbar(
          'Error while Fetching',
          "${response.statusCode.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      log('Error while getting data is $e');
      Get.snackbar(
        'Error while Fetching',
        "${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  void setTeam(Character t){
    team(t);
  }



}
