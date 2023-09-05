import 'package:flutter/material.dart';
import 'package:test_project/components/build_text.dart';
import 'package:test_project/utils/constants.dart';
import 'profile_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Profile')),
          ),
          body: Center(
            child: model.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          model.userImage ?? "",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            Future.delayed(Duration.zero, () {
                              model.handleErrorState();
                            });
                            return AlertDialog(
                              shadowColor: Colors.white,
                              insetPadding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.warning_rounded,
                                color: Colors.amber,
                                size: 40,
                              ),
                              title: const Text(
                                Constants.noImageMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () => model.fetchUserData(),
                                    child: const Text(Constants.refresh),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        if (model.showUserData) ...{
                          buildText('Name', model.username ?? ""),
                          buildText('Location', model.location ?? ""),
                          buildText('Email', model.email ?? ""),
                          buildText('Date of Birth', model.dateOfBirth ?? ""),
                          buildText('Days Since Registration',
                              model.dateOfJoining ?? ""),
                        }
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
