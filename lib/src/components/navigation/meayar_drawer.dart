import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../display/meayar_avatar.dart';
import '../display/meayar_divider.dart';

class MeayarDrawerItemData {
  const MeayarDrawerItemData({
    required this.id,
    required this.title,
    required this.icon,
    this.badge,
    this.isSelected = false,
  });

  final String id;
  final String title;
  final IconData icon;
  final String? badge;
  final bool isSelected;
}

/// Official MEAYAR Drawer Content component.
class MeayarDrawerContent extends StatelessWidget {
  const MeayarDrawerContent({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.userName,
    this.userNationalId,
    this.onLogoutClick,
    this.logoutText = 'تسجيل الخروج',
    this.headerTitle = 'بوابة الخدمات الحكومية',
    this.headerSubtitle = 'الجمهورية العربية السورية',
    this.footerText = 'معيار • الهوية الرقمية السورية',
    this.width = 320.0,
    this.useSafeArea = true,
  });

  final List<MeayarDrawerItemData> items;
  final ValueChanged<MeayarDrawerItemData> onItemSelected;
  final String? userName;
  final String? userNationalId;
  final VoidCallback? onLogoutClick;
  final String? logoutText;
  final String? headerTitle;
  final String? headerSubtitle;
  final String? footerText;
  final double? width;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveHeaderTitle = headerTitle ?? 'بوابة الخدمات الحكومية';
    final effectiveHeaderSubtitle = headerSubtitle ?? 'الجمهورية العربية السورية';
    final effectiveFooterText = footerText ?? 'معيار • الهوية الرقمية السورية';
    final effectiveLogout = logoutText ?? 'تسجيل الخروج';

    final innerContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              // Syrian Official Header
              Row(
                children: [
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: colors.backgroundBrand,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(MeayarIcons.building, color: colors.textInverse, size: 24.0),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          effectiveHeaderTitle,
                          style: typography.textMdBold.copyWith(color: colors.textPrimary),
                        ),
                        Text(
                          effectiveHeaderSubtitle,
                          style: typography.text2xs.copyWith(color: colors.textTertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // User Identity Card (if provided)
              if (userName != null) ...[
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: colors.backgroundSubtle,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      MeayarAvatar(
                        name: userName!,
                        size: MeayarAvatarSize.md,
                        status: MeayarPresenceStatus.online,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName!,
                              style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                            ),
                            if (userNationalId != null)
                              Text(
                                'الرقم الوطني: $userNationalId',
                                style: typography.textXs.copyWith(color: colors.textTertiary),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],

              const MeayarDivider(),
              const SizedBox(height: 12.0),

              // Navigation Items
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 4.0),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = item.isSelected;

                    return Material(
                      color: isSelected ? colors.backgroundBrandSubtle : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        onTap: () => onItemSelected(item),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          child: Row(
                            children: [
                              Icon(
                                item.icon,
                                size: 20.0,
                                color: isSelected ? colors.iconBrand : colors.iconSecondary,
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: typography.textSmMedium.copyWith(
                                    color: isSelected ? colors.textBrand : colors.textPrimary,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (item.badge != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: isSelected ? colors.backgroundBrand : colors.backgroundMuted,
                                    borderRadius: const BorderRadius.all(Radius.circular(999.0)),
                                  ),
                                  child: Text(
                                    item.badge!,
                                    style: typography.text2xsMedium.copyWith(
                                      color: isSelected ? colors.textInverse : colors.textSecondary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (onLogoutClick != null) ...[
                const MeayarDivider(),
                InkWell(
                  onTap: onLogoutClick,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                    child: Row(
                      children: [
                        Icon(MeayarIcons.logOut, size: 18.0, color: colors.textError),
                        const SizedBox(width: 8.0),
                        Text(
                          effectiveLogout,
                          style: typography.textSmMedium.copyWith(color: colors.textError),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              if (effectiveFooterText.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Center(
                  child: Text(
                    effectiveFooterText,
                    style: typography.text2xs.copyWith(color: colors.textTertiary),
                  ),
                ),
              ],
            ],
          ),
        );

    return Container(
      width: width,
      color: colors.backgroundSurface,
      child: useSafeArea ? SafeArea(child: innerContent) : innerContent,
    );
  }
}

/// Official MEAYAR Side Navigation Drawer widget.
class MeayarDrawer extends StatelessWidget {
  const MeayarDrawer({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.userName,
    this.userNationalId,
    this.onLogoutClick,
    this.logoutText,
    this.headerTitle,
    this.headerSubtitle,
    this.footerText,
    this.width = 320.0,
    this.useSafeArea = true,
  });

  final List<MeayarDrawerItemData> items;
  final ValueChanged<MeayarDrawerItemData> onItemSelected;
  final String? userName;
  final String? userNationalId;
  final VoidCallback? onLogoutClick;
  final String? logoutText;
  final String? headerTitle;
  final String? headerSubtitle;
  final String? footerText;
  final double? width;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(
          end: Radius.circular(16.0),
        ),
      ),
      child: MeayarDrawerContent(
        items: items,
        onItemSelected: onItemSelected,
        userName: userName,
        userNationalId: userNationalId,
        onLogoutClick: onLogoutClick,
        logoutText: logoutText,
        headerTitle: headerTitle,
        headerSubtitle: headerSubtitle,
        footerText: footerText,
        width: width,
        useSafeArea: useSafeArea,
      ),
    );
  }
}

/// Controller for [MeayarModalNavigationDrawer] and [MeayarNavigationDrawer].
class MeayarDrawerController extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}

/// Official MEAYAR Modal Navigation Drawer component.
/// Full RTL-first support: the drawer slides in smoothly from the start edge
/// (from the right in Arabic RTL, from the left in English LTR) with a dimming scrim overlay.
/// Draws OVER both Top App Bar and Bottom Navigation Bar.
class MeayarModalNavigationDrawer extends StatefulWidget {
  const MeayarModalNavigationDrawer({
    super.key,
    required this.drawerContent,
    required this.child,
    this.controller,
    this.scrimColor = const Color(0x80000000),
    this.gesturesEnabled = true,
  });

  final Widget drawerContent;
  final Widget child;
  final MeayarDrawerController? controller;
  final Color scrimColor;
  final bool gesturesEnabled;

  static MeayarModalNavigationDrawerState? of(BuildContext context) {
    return context.findAncestorStateOfType<MeayarModalNavigationDrawerState>();
  }

  @override
  State<MeayarModalNavigationDrawer> createState() => MeayarModalNavigationDrawerState();
}

class MeayarModalNavigationDrawerState extends State<MeayarModalNavigationDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;
  MeayarDrawerController? _internalController;

  MeayarDrawerController get _effectiveController =>
      widget.controller ?? (_internalController ??= MeayarDrawerController());

  bool get isOpen => _effectiveController.isOpen;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _effectiveController.addListener(_handleControllerChange);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && _effectiveController.isOpen) {
        _effectiveController.close();
      } else if (status == AnimationStatus.completed && !_effectiveController.isOpen) {
        _effectiveController.open();
      }
      if (mounted) setState(() {});
    });
    if (_effectiveController.isOpen) {
      _animController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant MeayarModalNavigationDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      final oldEffective = oldWidget.controller ?? _internalController;
      oldEffective?.removeListener(_handleControllerChange);
      if (widget.controller != null && _internalController != null) {
        _internalController!.dispose();
        _internalController = null;
      }
      _effectiveController.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChange);
    _animController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _handleControllerChange() {
    if (_effectiveController.isOpen) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
    if (mounted) setState(() {});
  }

  void open() => _effectiveController.open();
  void close() => _effectiveController.close();
  void toggle() => _effectiveController.toggle();

  void _onHorizontalDragUpdate(DragUpdateDetails details, bool isRtl) {
    if (!widget.gesturesEnabled) return;
    final delta = details.primaryDelta ?? 0.0;
    // In RTL, dragging right (delta > 0) dismisses. In LTR, dragging left (delta < 0) dismisses.
    final progressDelta = (isRtl ? -delta : delta) / 320.0;
    _animController.value = (_animController.value + progressDelta).clamp(0.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details, bool isRtl) {
    if (!widget.gesturesEnabled) return;
    final velocity = details.primaryVelocity ?? 0.0;
    // Velocity towards dismiss direction
    final isDismissVelocity = isRtl ? velocity > 300.0 : velocity < -300.0;
    final isOpenVelocity = isRtl ? velocity < -300.0 : velocity > 300.0;

    if (isDismissVelocity || (_animController.value < 0.6 && !isOpenVelocity)) {
      _animController.reverse().then((_) => close());
    } else {
      _animController.forward().then((_) => open());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return PopScope(
      canPop: !isOpen,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isOpen) {
          close();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Content over which drawer slides (TopAppBar, Screen, BottomNavigationBar)
          widget.child,

          // Edge gesture detector to open drawer by swiping from screen start edge
          if (widget.gesturesEnabled && !isOpen)
            PositionedDirectional(
              start: 0,
              top: 0,
              bottom: 0,
              width: 24.0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details, isRtl),
                onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details, isRtl),
              ),
            ),

          // Scrim & Drawer Sheet Overlay
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              if (_animation.value == 0.0) return const SizedBox.shrink();

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Full-screen Dimming Scrim with tap & swipe to dismiss
                  GestureDetector(
                    onTap: close,
                    onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details, isRtl),
                    onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details, isRtl),
                    child: Container(
                      color: widget.scrimColor.withValues(
                        alpha: widget.scrimColor.a * _animation.value,
                      ),
                    ),
                  ),

                  // Slide Drawer Sheet with swipe to dismiss
                  Align(
                    alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                    child: FractionalTranslation(
                      translation: Offset(
                        isRtl ? (1.0 - _animation.value) : (_animation.value - 1.0),
                        0.0,
                      ),
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details, isRtl),
                        onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details, isRtl),
                        child: SizedBox(
                          width: 320.0,
                          height: double.infinity,
                          child: Material(
                            color: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.circular(16.0),
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 16.0,
                            child: widget.drawerContent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Convenient all-in-one MEAYAR Navigation Drawer that combines the modal drawer
/// container with [MeayarDrawerContent] automatically.
/// Draws OVER both Top App Bar and Bottom Navigation Bar.
class MeayarNavigationDrawer extends StatelessWidget {
  const MeayarNavigationDrawer({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.child,
    this.controller,
    this.userName,
    this.userNationalId,
    this.onLogoutClick,
    this.logoutText,
    this.headerTitle,
    this.headerSubtitle,
    this.footerText,
    this.scrimColor = const Color(0x80000000),
    this.gesturesEnabled = true,
  });

  final List<MeayarDrawerItemData> items;
  final ValueChanged<MeayarDrawerItemData> onItemSelected;
  final Widget child;
  final MeayarDrawerController? controller;
  final String? userName;
  final String? userNationalId;
  final VoidCallback? onLogoutClick;
  final String? logoutText;
  final String? headerTitle;
  final String? headerSubtitle;
  final String? footerText;
  final Color scrimColor;
  final bool gesturesEnabled;

  static MeayarModalNavigationDrawerState? of(BuildContext context) {
    return MeayarModalNavigationDrawer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MeayarModalNavigationDrawer(
      controller: controller,
      scrimColor: scrimColor,
      gesturesEnabled: gesturesEnabled,
      drawerContent: MeayarDrawerContent(
        items: items,
        onItemSelected: onItemSelected,
        userName: userName,
        userNationalId: userNationalId,
        onLogoutClick: onLogoutClick,
        logoutText: logoutText,
        headerTitle: headerTitle,
        headerSubtitle: headerSubtitle,
        footerText: footerText,
      ),
      child: child,
    );
  }
}
