import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/views/pets/pet_screen_view.dart';
import 'package:test_project/views/pets/pet_screen_viewmodel.dart';

void main() {
  final client = MockClient((request) async {
    return Response(
      '{"message": "https://images.dog.ceo/breeds/keeshond/n02112350_8341.jpg","status": "success"}',
      200,
    );
  });
  group('PetScreen', () {
    testWidgets('renders loading indicator when isLoading is true',
        (WidgetTester tester) async {
      final viewModel = PetScreenViewModel(httpClient: client);
      viewModel.setBusy(true);
      await tester.pumpWidget(
        MaterialApp(
          home: ViewModelBuilder<PetScreenViewModel>.reactive(
            viewModelBuilder: () => viewModel,
            builder: (context, model, child) => const PetScreen(),
          ),
        ),
      );
      expect(
          find.text("Press the Refresh button to generate random dog images"),
          findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });
    testWidgets('pet screen view ...', (tester) async {
      final viewModel = PetScreenViewModel(httpClient: client);
      viewModel.setBusy(false);
      await tester.pumpWidget(
        MaterialApp(
          home: ViewModelBuilder<PetScreenViewModel>.reactive(
            viewModelBuilder: () => viewModel,
            builder: (context, model, child) => const PetScreen(),
          ),
        ),
      );

      expect(find.byWidget(const CircularProgressIndicator()), findsNothing);
      expect(find.byType(Image), findsNothing);
    });
  });
}
