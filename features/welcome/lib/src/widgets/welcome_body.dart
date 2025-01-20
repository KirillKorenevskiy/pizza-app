import 'dart:ui';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'authentication_tab.dart';
import 'registration_tab.dart';

class WelcomeScreenBody extends StatefulWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenBody> createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    alignment: const AlignmentDirectional(1.7, 2.2),
                    child: Container(
                      height: screenSize.width,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.of(context).primaryBg,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(3.7, -1.4),
                    child: Container(
                      height: screenSize.width / 1.3,
                      width: screenSize.width / 1.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.of(context).primaryBg,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              Align(
                child: SizedBox(
                  height: screenSize.height / 1.8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          unselectedLabelColor:
                              AppColors.of(context).black.withOpacity(0.5),
                          labelColor: AppColors.of(context).black,
                          tabs: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const <Widget>[
                            AuthenticationTab(),
                            RegistrationTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
