import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/screens/sign_up/register_description_screen.dart';

const pageParameterKey = "page";

const splashScreenName = "splash";
const loginScreenName = "login";
const registerScreenName = "register";
const registerBasicInfoScreenName = "register-basic-info";
const registerPhotoScreenName = "register-photo";
const registerDescriptionScreenName = "register-description";
const registerInterestsScreenName = "register-interests";
const verifyEmailScreenName = "verify-email";
const recoverPasswordScreenName = "recover-password";
const homeScreenName = "home";
const profileScreenName = "profile";
const matchProfileScreenName = "match-profile";
const feedScreenName = "feed";
const chatScreenName = "chat";
const editProfileScreenName = "edit-profile";
const editPreferencesScreenName = "edit-preferences";
const editPasswordScreenName = "edit-password";

const splashScreenPath = "/" + splashScreenName;
const loginScreenPath = "/" + loginScreenName;
const registerScreenPath = "/" + registerScreenName;
const registerBasicInfoScreenPath = registerBasicInfoScreenName;
const registerPhotoScreenPath = registerPhotoScreenName;
const registerDescriptionScreenPath = registerDescriptionScreenName;
const registerInterestsScreenPath = registerInterestsScreenName;
const verifyEmailScreenPath = "/" + verifyEmailScreenName;
const recoverPasswordScreenPath = "/" + recoverPasswordScreenName;
const homeScreenPath = "/:$pageParameterKey($profileScreenName|$feedScreenName|$chatScreenName)";
const editProfileScreenPath = editProfileScreenName;
const editPreferencesScreenPath = editPreferencesScreenName;
const editPasswordScreenPath = editPasswordScreenName;
const matchProfileScreenPath = matchProfileScreenName;
