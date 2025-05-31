import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';
import 'package:jose_app/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScheduleCarousel extends StatefulWidget {
  final List<ScheduleEntity> schedules;
  final double height;
  final double width;

  const ScheduleCarousel({
    super.key,
    required this.schedules,
    this.height = 450,
    this.width = double.infinity,
  });

  @override
  State<ScheduleCarousel> createState() => _ScheduleCarouselState();
}

class _ScheduleCarouselState extends State<ScheduleCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    int page = _pageController.page?.round() ?? 0;
    if (_currentPage != page) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.schedules.length,
              physics: const BouncingScrollPhysics(),
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              itemBuilder: (context, index) {
                final schedule = widget.schedules[index];
                final isActive = index == _currentPage;

                return AnimatedScale(
                  scale: isActive ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ScheduleCard(schedule: schedule, index: index),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.schedules.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? shadTheme.colorScheme.primary
                        : shadTheme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
