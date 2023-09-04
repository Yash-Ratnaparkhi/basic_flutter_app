import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/modals/user_profile.dart';
import 'dart:convert';
import 'package:test_project/utils/constants.dart';

class ProfileViewModel extends BaseViewModel {
  final http.Client? httpClient;

  ProfileViewModel({this.httpClient}) {
    fetchUserData();
  }

  String? _username = "";
  String? get username => _username;
  String? _location = "";
  String? get location => _location;
  String? _email = "";
  String? get email => _email;
  String? _dateOfBirth = "";
  String? get dateOfBirth => _dateOfBirth;
  String? _dateOfJoining = "";
  String? get dateOfJoining => _dateOfJoining;
  String? _userImage = "";
  String? get userImage => _userImage;

  String getName(Name name) {
    return '${name.title} ${name.first} ${name.last}';
  }

  String getLocation(Location data) {
    return '${data.city}, ${data.state}';
  }

  String getDob(Dob dob) {
    DateTime dateTime = DateTime.parse(dob.date);
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}";
    return formattedDate;
  }

  String daysSinceRegistration(String dateOfJoining) {
    final currentDate = DateTime.now();
    final DateTime doj = DateTime.parse(dateOfJoining);
    return currentDate.difference(doj).inDays.toString();
  }

  void handleErrrorData() {
    _userImage = "no data found";
    _username = "no data found";
    _email = "no data found";
    _dateOfBirth = "no data found";
    _dateOfJoining = "no data found";
    _location = "no data found";
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    setBusy(true);
    try {
      final response = await http.get(Uri.parse(Constants.userProfileApiKey));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserProfileModel data = UserProfileModel.fromJson(responseData);
        final result = data.results[0];
        _userImage = result.picture.large;
        _username = getName(result.name);
        _email = result.email;
        _dateOfBirth = getDob(result.dob);
        _dateOfJoining = daysSinceRegistration(result.registered.date);
        _location = getLocation(result.location);
        notifyListeners();
        setBusy(false);
      } else {
        setBusy(false);
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      setBusy(false);
    }
  }
}
