import 'dart:developer';

import 'package:ahbas/model/search/all_users/datum.dart';
import 'package:ahbas/provider/search/search_provider.dart';
import 'package:ahbas/view/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late List<UserDTO> _searchResults;
  List<UserDTO> displayedUsers = [];

  void _performSearch(String query, List<UserDTO> allUserData) {
    List<UserDTO> results = [];
    for (UserDTO user in allUserData) {
      if (user.userName.toLowerCase().contains(query.toLowerCase())) {
        results.add(user);
      }
    }
    setState(() {
      _searchResults = results;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = Provider.of<SearchPrvider>(context, listen: false)
        .resultData
        .allUsersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 70,
                width: 300,
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (query) {
                    _performSearch(
                        query,
                        Provider.of<SearchPrvider>(context, listen: false)
                            .resultData
                            .allUsersList);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: _searchResults.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserProfile(
                                      userData: _searchResults[index]),
                                ));
                              },
                              child: Container(
                                width: 326.w,
                                height: 70.h,
                                color: Colors.blue,
                                child: Center(
                                    child:
                                        Text(_searchResults[index].userName)),
                              ),
                            ),
                          );
                        },
                      )
                    : Consumer<SearchPrvider>(
                        builder: (context, value, child) {
                          // Initialize the displayedUsers list with all users
                          displayedUsers = value.resultData.allUsersList;

                          log(displayedUsers.toString());
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: displayedUsers.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
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
                            ),
                          );
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
