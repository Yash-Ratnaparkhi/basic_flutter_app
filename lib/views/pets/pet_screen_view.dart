import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/utils/constants.dart';
import 'pet_screen_viewmodel.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PetScreenViewModel>.reactive(
      viewModelBuilder: () => PetScreenViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Your Favourite Breed',
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  Constants.pressRefreshText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              model.isBusy
                  ? const SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Image.network(
                      model.imageUrls,
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const AlertDialog(
                          title: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  color: Colors.amber,
                                  size: 36,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  Constants.errorImageMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => model.fetchImages(),
                child: const Text(Constants.refresh),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
