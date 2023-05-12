import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_music/common/ui/button/button.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/feauteres/navigation/navigation.dart';
import 'package:top_music/resources/constants.dart';
import 'package:top_music/resources/fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.sessionStore});

  final SessionStore sessionStore;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      final String token = uri.toString().substring(17);
      widget.sessionStore.setSession(token);
      context.go(AppRouteNames.main);
    }, onError: (Object err) {
      if (!mounted) return;
      print('got err: $err');
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  _launchUrl(String uriString) {
    launchUrl(Uri.parse(uriString), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/images/logo/logo.png', width: 160),
            const Spacer(),
            const Text(
              "Le meilleur de la musique Chrétienne",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: Fonts.sen,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AppButton(
                child: Text(
                  'S’inscrire gratuitement'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: Fonts.sen,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                onPress: () => _launchUrl(Constants.loginLink),
              ),
            ),
            AppButton(
              type: AppButtonType.outlined,
              child: Text(
                'S’inscrire gratuitement'.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xffF27046),
                  fontFamily: Fonts.sen,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              onPress: () => _launchUrl(Constants.registerLink),
            ),
          ],
        ),
      ),
    );
  }
}
