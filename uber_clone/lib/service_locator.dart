import 'package:get_it/get_it.dart';
import 'package:uber_clone/services/firebase/authentication/authentication_client.dart';

import 'services/firebase/firestore/chat_client/chat_client.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton<AuthenticationClient>(() => AuthenticationClient());
  locator.registerLazySingleton<ChatClient>(() => ChatClient());
}
