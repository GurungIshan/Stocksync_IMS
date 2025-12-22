import 'package:flutter/material.dart';
import 'core/session/session_manager.dart';
import 'features/auth/presentation/pages/landing_page.dart';
import 'features/dashboard/pages/home_page.dart';

class AppStartup extends StatelessWidget {
  final SessionManager sessionManager;

  const AppStartup({super.key, required this.sessionManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: sessionManager.getSession().catchError((error) {
        print('Error getting session: $error');
        return null; // Return null on error
      }),
      builder: (context, snapshot) {
        print('FutureBuilder state: ${snapshot.connectionState}');
        print('Has data: ${snapshot.hasData}');
        print('Has error: ${snapshot.hasError}');
        
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('Error loading session: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data;
        print('Session data: $session');

        // FIX: Use try-catch to handle widget building errors
        try {
          if (session != null && session.isNotEmpty) {
            return HomePage();
          } else {
            return const LandingPage();
          }
        } catch (e, stackTrace) {
          print('⚠️ ERROR building HomePage/LandingPage: $e');
          print('Stack trace: $stackTrace');
          
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'App Startup Error',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Error: ${e.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Try to reload
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => AppStartup(sessionManager: sessionManager),
                        ),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}