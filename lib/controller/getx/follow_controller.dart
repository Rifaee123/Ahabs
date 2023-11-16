import 'package:ahbas/model/follow_following/followers_list/follower.dart';
import 'package:ahbas/model/follow_following/following_list/following.dart';
import 'package:get/get.dart';

class FolloControlller extends GetxController {
  RxString currentusername = ''.obs;
  
  RxBool isFollow = false.obs;
  RxBool isUnFollow = true.obs;
  RxString checkresult = ''.obs;
  RxString dropdownvalue = 'Following'.obs;
  RxBool isNeither = false.obs;
  RxBool isFollowing = false.obs;
  RxBool isFollowback = false.obs;
  RxBool isFollower = false.obs;
  RxBool isBothfollowed = false.obs;
  RxBool isBoth = false.obs;
  final RxList<Follower> followerList = <Follower>[].obs;
  final RxList<Following> followingList = <Following>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  RxString currentuserid = ''.obs;
  RxString authToken = ''.obs;
}
