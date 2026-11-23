import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'catalog/catalog_screen.dart';
import 'catalog/foundations_screen.dart';
import 'catalog/sample_auth_screen.dart';
import 'catalog/sample_health_portal_screen.dart';
import 'package:meayar_flutter/meayar.dart';

void main() {
  runApp(const MeayarApp());
}

class MeayarApp extends StatefulWidget {
  const MeayarApp({super.key});

  @override
  State<MeayarApp> createState() => _MeayarAppState();
}

class _MeayarAppState extends State<MeayarApp> {
  bool _isDarkMode = false;
  bool _isRtl = true; // RTL demonstration by default

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEAYAR Flutter',
      debugShowCheckedModeBanner: false,
      locale: _isRtl ? const Locale('ar', 'SY') : const Locale('en', 'US'),
      supportedLocales: const [
        Locale('ar', 'SY'),
        Locale('ar'),
        Locale('en', 'US'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        MeayarLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Dual compatibility: Material 3 Themes bridged directly to Syrian identity tokens
      theme: MeayarTheme.createThemeData(brightness: Brightness.light),
      darkTheme: MeayarTheme.createThemeData(brightness: Brightness.dark),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Wrap with MeayarTheme and RTL Directionality demonstration
      builder: (context, child) {
        return MeayarTheme(
          data: _isDarkMode ? MeayarThemeData.dark : MeayarThemeData.light,
          child: Directionality(
            textDirection: _isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: child!,
          ),
        );
      },

      home: MeayarMainShell(
        isDarkMode: _isDarkMode,
        onToggleTheme: () => setState(() => _isDarkMode = !_isDarkMode),
        isRtl: _isRtl,
        onToggleDirection: () => setState(() => _isRtl = !_isRtl),
      ),
    );
  }
}

/// Root Application Shell for MEAYAR Flutter catalog and demo views.
class MeayarMainShell extends StatefulWidget {
  const MeayarMainShell({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.isRtl,
    required this.onToggleDirection,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final bool isRtl;
  final VoidCallback onToggleDirection;

  @override
  State<MeayarMainShell> createState() => _MeayarMainShellState();
}

class _MeayarMainShellState extends State<MeayarMainShell> {
  int _selectedBottomNav = 0;
  final MeayarDrawerController _drawerController = MeayarDrawerController();

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final drawerNavItems = [
      MeayarDrawerItemData(
        id: 'portal',
        title: 'بوابة وزارة الصحة',
        icon: MeayarIcons.home,
        isSelected: _selectedBottomNav == 0,
      ),
      MeayarDrawerItemData(
        id: 'catalog',
        title: 'معرض المكوّنات (36+ مكوّن)',
        icon: MeayarIcons.document,
        badge: '49 عنصر',
        isSelected: _selectedBottomNav == 1,
      ),
      MeayarDrawerItemData(
        id: 'foundations',
        title: 'الأساسيات والرموز (Tokens)',
        icon: MeayarIcons.building,
        isSelected: _selectedBottomNav == 2,
      ),
      MeayarDrawerItemData(
        id: 'auth',
        title: 'الهوية الرقمية الموحدة',
        icon: MeayarIcons.user,
        isSelected: _selectedBottomNav == 3,
      ),
    ];

    return MeayarNavigationDrawer(
      controller: _drawerController,
      items: drawerNavItems,
      userName: 'حمزة الخطيب',
      userNationalId: '01030094821',
      onItemSelected: (item) {
        setState(() {
          switch (item.id) {
            case 'portal':
              _selectedBottomNav = 0;
              break;
            case 'catalog':
              _selectedBottomNav = 1;
              break;
            case 'foundations':
              _selectedBottomNav = 2;
              break;
            case 'auth':
              _selectedBottomNav = 3;
              break;
          }
        });
        _drawerController.close();
      },
      onLogoutClick: () {
        setState(() => _selectedBottomNav = 3);
        _drawerController.close();
      },
      child: Scaffold(
        backgroundColor: colors.backgroundPage,
        bottomNavigationBar: MeayarNavigationBar(
          items: const [
            MeayarNavigationItem(title: 'البوابة', icon: MeayarIcons.home),
            MeayarNavigationItem(title: 'المكوّنات', icon: MeayarIcons.document),
            MeayarNavigationItem(title: 'الأساسيات', icon: MeayarIcons.building),
            MeayarNavigationItem(title: 'الهوية الرقمية', icon: MeayarIcons.user),
          ],
          selectedIndex: _selectedBottomNav,
          onItemSelected: (idx) => setState(() => _selectedBottomNav = idx),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Quick Interactive Switcher Header (Light/Dark + RTL/LTR)
              Container(
                color: colors.backgroundSubtle,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: colors.backgroundBrand,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'معيار MEAYAR Flutter',
                          style: typography.textXsMedium.copyWith(color: colors.textPrimary),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MeayarButton(
                          text: widget.isDarkMode ? 'فاتح ☀️' : 'داكن 🌙',
                          size: MeayarButtonSize.xs,
                          variant: MeayarButtonVariant.secondary,
                          onPressed: widget.onToggleTheme,
                        ),
                        const SizedBox(width: 8.0),
                        MeayarButton(
                          text: widget.isRtl ? 'English LTR' : 'عربي RTL',
                          size: MeayarButtonSize.xs,
                          variant: MeayarButtonVariant.outlined,
                          onPressed: widget.onToggleDirection,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Active Screen
              Expanded(
                child: IndexedStack(
                  index: _selectedBottomNav,
                  children: [
                    HealthServicePortalScreen(
                      onOpenDrawer: () => _drawerController.open(),
                    ),
                    CatalogScreen(
                      onOpenDrawer: () => _drawerController.open(),
                    ),
                    const FoundationsScreen(),
                    MeayarAuthScreen(
                      onLoginSuccess: () => setState(() => _selectedBottomNav = 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
