import 'dart:developer';

import 'package:ahbas/controller/getx/follow_controller.dart';
import 'package:ahbas/provider/folllow_following/follow_following_provider.dart';
import 'package:ahbas/provider/search/search_provider.dart';
import 'package:ahbas/view/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  // late List<UserDTO> _searchResults;
  List<UserDTO> displayedUsers = [];
  // getallUsers() async {
  //   await Provider.of<SearchPrvider>(context, listen: false).getAllUsers();
  // }

  void _performSearch(String query, List<UserDTO> allUserData) {
    List<UserDTO> results = [];
    for (UserDTO user in allUserData) {
      if (user.userName.toLowerCase().contains(query.toLowerCase())) {
        results.add(user);
      }
    }
    setState(() {
      displayedUsers = results;
    });
  }

  final FolloControlller controller = Get.put(FolloControlller());

  // @override
  // void initState() {
  //   super.initState();
  //   getallUsers();
  //   _searchController = TextEditingController();
  //   _searchResults = Provider.of<SearchPrvider>(context, listen: false)
  //       .resultData
  //       .allUsersList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  SizedBox(
                    height: 50.h,
                    width: 280.w,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (query) {
                        _performSearch(
                            query,
                            Provider.of<SearchPrvider>(context, listen: false)
                                .resultData
                                .allUsersList);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    //  _searchResults.isNotEmpty
                    //     ? ListView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: _searchResults.length,
                    //         itemBuilder: (context, index) {
                    //           void checkFollowStatus1() async {
                    //             var followProvider =
                    //                 Provider.of<FollowFollowingProvider>(context,
                    //                     listen: false);

                    //             await followProvider.checkFollowStatus(
                    //                 visitingUserId: _searchResults[index].userId);
                    //             if (controller.isNeither.value == true) {
                    //               log('hai');
                    //               controller.isFollow.value = true;
                    //             } else if (controller.isFollowing.value == true) {
                    //               log('hallo');
                    //               controller.isFollow.value = false;
                    //             }
                    //           }

                    //           return Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: InkWell(
                    //               onTap: () {
                    //                 checkFollowStatus1();
                    //                 Navigator.of(context).push(MaterialPageRoute(
                    //                   builder: (context) => UserProfile(
                    //                       userData: _searchResults[index]),
                    //                 ));
                    //               },
                    //               child: Container(
                    //                 width: 326.w,
                    //                 height: 70.h,
                    //                 color: Colors.blue,
                    //                 child: Center(
                    //                     child:
                    //                         Text(_searchResults[index].userName)),
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       )
                    //     :
                    Consumer<SearchPrvider>(
                  builder: (context, value, child) {
                    // Initialize the displayedUsers list with all users
                    // displayedUsers = value.resultData.allUsersList;

                    log(displayedUsers.toString());
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: displayedUsers.length,
                        itemBuilder: (context, index) {
                          void checkFollowStatus() async {
                            var followProvider =
                                Provider.of<FollowFollowingProvider>(context,
                                    listen: false);

                            await followProvider.checkFollowStatus(
                                visitingUserId: displayedUsers[index].userId);
                            if (controller.isNeither.value == true) {
                              log('hai');
                              controller.isFollow.value = true;
                            } else if (controller.isFollowing.value == true) {
                              log('hallo');
                              controller.isFollow.value = false;
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                checkFollowStatus();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserProfile(
                                      userData: displayedUsers[index]),
                                ));
                              },
                              child: Container(
                                width: 326.w,
                                height: 70.h,
                                color: Colors.blue,
                                child: Center(
                                    child:
                                        Text(displayedUsers[index].userName)),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
