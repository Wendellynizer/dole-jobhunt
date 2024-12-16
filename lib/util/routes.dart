import 'package:dole_jobhunt/pages/admin/applicant_profile_view.dart';
import 'package:dole_jobhunt/pages/admin/edit_profile.dart';
import 'package:dole_jobhunt/pages/admin/view_applicants.dart';
import 'package:dole_jobhunt/pages/check_role.dart';
import 'package:dole_jobhunt/pages/user/applicant_page.dart';
import 'package:go_router/go_router.dart';

import '../pages/admin/admin_page.dart';
import '../pages/admin/create_job.dart';
import '../pages/admin/job_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../pages/user/home.dart';
import '../pages/user/job_view.dart';
import '../pages/user/profile.dart';

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
        path: '/check_role',
        builder: (context, state) {
          return const CheckRolePage();
        }
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

              routes: [
                GoRoute(
                    path: 'view_applicants',
                    builder: (context, state) {
                      return ViewApplicantsPage(jobID: state.pathParameters['jobID']!);
                    }
                ),

                GoRoute(
                    path: 'applicant/:applicantID',
                    builder: (context, state) {
                      return ApplicantProfile(applicantID: state.pathParameters['applicantID']!);
                    }
                )
              ]
            ),



            GoRoute(
              path: 'edit_profile',
              builder: (context, state) {
                return const AdminEditProfile();
              }
            )
          ]
      ),


      // applicant routes
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ApplicantPage(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const Home(),

                routes: [
                  GoRoute(
                      path: '/job_view/:jobID',
                      builder: (context, state) => JobView(jobID: state.pathParameters['jobID'],)
                  )
                ]
              ),
            ]
          ),

          StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/profile',
                    builder: (context, state) => const Profile(),
                ),
              ]
          )
        ]
      )
    ]
);