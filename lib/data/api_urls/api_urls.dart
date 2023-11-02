const kBaseUrl = 'https://ahabs.cyenosure.in';

const twilioOtpSentingBaseUrl = 'https://verify.twilio.com/v2/Services/';
const loginEndPoint = '/api/auth/login';
const registrationEndpoint = '/api/auth/register';
const verifyEmailEndpoint = '/api/auth/verifyemail';
const verifyEmailCodeEndpoint = '/api/auth/verify';
const editProfileEndpoint = '/api/user/editprofile/';
const getAllUsersEndpoint = '/api/user/getallusers';
const getcurrentUserEndpoint = '/api/user/currentuser/';
const addProfilePicEndpoint = '/api/user/addprofilepicture/';

const followRequestEndPoint = '/api/user/follow/';
const unFollowRequestEndPoint = '/api/user/unfollow/';
const followStatusEndPoint = '/api/user/checkFollowStatus/';
const followerListEndPoint = '/api/user/listfollowers/';
const followingListEndPoint = '/api/user/listfollowing/';
const createChatRoomEndPoint = '/api/chat/createroom/';
const getPrimaryChatsEndPoint = '/api/chat/chattedrooms';
const getIndividualChatsEndPoint = '/api/chat/messages/';
const sendMessgeEndpoint = '/api/chat/addchat';
const deleteForMeEndPoint = '/api/chat/deleteforme/';
const deleteForEveryOneEndPoint = '/api/chat/deleteforeveryone/';
const clearChatEndPoint = '/api/chat/clearchat/';
