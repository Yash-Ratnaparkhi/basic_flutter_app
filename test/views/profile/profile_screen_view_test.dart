import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/views/profile/profile_screen_viewmodel.dart';
import 'package:test_project/views/profile/profile_screen_view.dart';

void main() {
  group('ProfilePage Widget Tests', () {
    testWidgets('ProfilePage should render without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfilePage(),
        ),
      );
      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('ProfilePage should display user information when not busy',
        (WidgetTester tester) async {
      final viewModel = ProfileViewModelMock(isBusy: false);

      await tester.pumpWidget(
        MaterialApp(
          home: ViewModelBuilder<ProfileViewModel>.nonReactive(
            viewModelBuilder: () => viewModel,
            builder: (context, model, child) {
              return const ProfilePage();
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Date of Birth'), findsOneWidget);
      expect(find.text('Days Since Registration'), findsOneWidget);
    });
  });
}

class ProfileViewModelMock extends ProfileViewModel {
  ProfileViewModelMock({required bool isBusy})
      : super(httpClient: MockHttpClient());
}

class MockHttpClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return http.Response('{"key": "value"}', 200);
  }
}
