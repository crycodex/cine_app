import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_app/presentation/widgets/about/about_widgets.dart';
import 'package:cine_app/domain/entities/recommended_app.dart';

class CreditsScreen extends StatelessWidget {
  static const String name = "credits-screen";

  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final recommendedApps = _getRecommendedApps();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    theme.colorScheme.primary.withValues(alpha: 0.3),
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    Colors.black,
                  ]
                : [
                    theme.colorScheme.primary.withValues(alpha: 0.2),
                    theme.colorScheme.primary.withValues(alpha: 0.05),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Acerca de",
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      shadows: [
                        Shadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DeveloperCard(theme: theme, isDark: isDark),
                      const SizedBox(height: 24),
                      AppInfoCard(theme: theme, isDark: isDark),
                      const SizedBox(height: 24),
                      TechnologiesCard(theme: theme, isDark: isDark),
                      const SizedBox(height: 24),
                      RecommendedAppsCard(
                        theme: theme,
                        isDark: isDark,
                        apps: recommendedApps,
                      ),
                      const SizedBox(height: 24),
                      CreditsFooter(theme: theme),
                      const SizedBox(height: 30),
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

  List<RecommendedApp> _getRecommendedApps() {
    return [
      // Ejemplo de cómo agregar apps recomendadas
      // RecommendedApp(
      //   name: "Mi App",
      //   iconAsset: "assets/app_icon.png",
      //   androidUrl: "https://play.google.com/store/apps/details?id=com.example.app",
      //   iosUrl: "https://apps.apple.com/app/id123456789",
      // ),
      RecommendedApp(
        name: "Swapme",
        iconAsset: "assets/apps/swapme.webp",
        androidUrl:
            "https://play.google.com/store/apps/details?id=com.company.swapme&hl=es_EC",
        iosUrl: "",
      ),
      RecommendedApp(
        name: "Swapme 2.0",
        iconAsset: "assets/apps/swapme2.0.webp",
        androidUrl:
            "https://play.google.com/store/apps/details?id=com.swapapp.me&hl=es_EC",
        iosUrl: "https://apps.apple.com/ec/app/swapme/id6749961783",
      ),
      RecommendedApp(
        name: "Tribbe",
        iconAsset: "assets/apps/tribbe.webp",
        androidUrl: "",
        iosUrl: "https://apps.apple.com/ec/app/tribbe/id6754004167",
      ),
      RecommendedApp(
        name: "Chullacash",
        iconAsset: "assets/apps/chullacash.webp",
        androidUrl:
            "https://play.google.com/store/apps/details?id=com.chullacash.app&hl=es_EC",
        iosUrl: "https://apps.apple.com/ec/app/chulla-cash/id6747735919",
      ),
      RecommendedApp(
        name: "ChatSim",
        iconAsset: "assets/apps/chatsim.webp",
        androidUrl:
            "https://play.google.com/store/apps/details?id=com.cristhianrecalde.app_chat&hl=es_EC",
        iosUrl: "",
      ),
      RecommendedApp(
        name: "Count",
        iconAsset: "assets/apps/count.webp",
        androidUrl:
            "https://play.google.com/store/apps/details?id=com.isnotcristhianr.app_counter&hl=es_EC",
        iosUrl: "",
      ),
    ];
  }
}
