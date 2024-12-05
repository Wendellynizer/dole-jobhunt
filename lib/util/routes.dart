import 'package:go_router/go_router.dart';

import '../pages/admin/admin_page.dart';
import '../pages/admin/create_job.dart';
import '../pages/admin/job_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),

      GoRoute(
          path: '/admin_page',
          builder: (context, state) => const AdminPage(),

          routes: [
            GoRoute(
              path: 'create_job',
              builder: (context, state) => const CreateJobPage(),
            ),

            GoRoute(
              path: 'job_details/:jobID',
              builder: (context, state) {
                return JobDetails(jobID: state.pathParameters['jobID']!);
              },
            ),
          ]
      ),
    ]
);