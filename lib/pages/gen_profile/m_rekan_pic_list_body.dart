import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/showdialoghapus_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiclist_tile_widget.dart';

class MRekanPicListListWidget extends StatefulWidget {
  final void Function(String recordId)? onEdit;
  final void Function(String recordId)? onDelete;

  const MRekanPicListListWidget({super.key, this.onEdit, this.onDelete});


  @override
  State<MRekanPicListListWidget> createState() => _MRekanPicListListWidgetState();
}

class _MRekanPicListListWidgetState extends State<MRekanPicListListWidget>
    with TickerProviderStateMixin {
  late MRekanPicListBloc mRekanPicListBloc;
  late MRekanPicCrudBloc mRekanPicCrudBloc;
  final ScrollController _scrollController = ScrollController();
  int? _expandedIndex;

  late AnimationController _listAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _listFadeAnimation;
  late Animation<Offset> _listSlideAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize animation controllers
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Initialize animations
    _listFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _listAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _listSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _listAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Start list animation
    _listAnimationController.forward();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _listAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mRekanPicListBloc = BlocProvider.of<MRekanPicListBloc>(context);
    mRekanPicCrudBloc = BlocProvider.of<MRekanPicCrudBloc>(context);

    return BlocConsumer<MRekanPicListBloc, MRekanPicListState>(
      buildWhen: (previous, current) => current.status == ListStatus.success,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          if (state.items.isEmpty) return _buildNoDataWidget();

          return AnimatedBuilder(
            animation: _listAnimationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _listFadeAnimation,
                child: SlideTransition(
                  position: _listSlideAnimation,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: state.items.length > 3 ? 3 : state.items.length,
                    itemBuilder: (_, index) {
                      final item = state.items[index];
                      final isSelected = _expandedIndex == index;

                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: _buildModernCard(item, index, isSelected),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return _buildNoDataWidget();
        }
      },
    );
  }

  Widget _buildModernCard(dynamic item, int index, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.blue.shade200
              : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.blue.withOpacity(0.15)
                : Colors.black.withOpacity(0.08),
            blurRadius: isSelected ? 12 : 8,
            offset: Offset(0, isSelected ? 6 : 4),
            spreadRadius: isSelected ? 2 : 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Main content area
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MRekanPicListTileWidget(
                          isDefault: item.isDefault,
                          jabatanDesc: item.jabatanDesc,
                          mrekanpicId: item.mrekanpicId,
                          picEmail: item.picEmail,
                          picHp: item.picHp,
                          picNama: item.picNama,
                        ),
                      ],
                    ),
                  ),

                  // Modern action button
                  _buildActionButton(index, isSelected),
                ],
              ),
            ),

            // Expandable action buttons
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              height: isSelected ? 80 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildModernActionButton(
                          icon: Icons.edit_rounded,
                          label: "Edit",
                          color: Colors.green,
                            onPressed: () {
                              _animateButtonPress(() {
                                if (widget.onEdit != null) {
                                  widget.onEdit!(item.mrekanpicId);
                                }
                              });
                            }
                        ),
                        const SizedBox(width: 12),
                        _buildModernActionButton(
                          icon: Icons.delete_rounded,
                          label: "Hapus",
                          color: Colors.red,
                            onPressed: () {
                              _animateButtonPress(() {
                                if (widget.onDelete != null) {
                                  widget.onDelete!(item.mrekanpicId);
                                } else {
                                  showDialogHapus(item.mrekanpicId); // fallback lama
                                }
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(int index, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _expandedIndex = isSelected ? null : index;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue.shade50
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.blue.shade200
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: isSelected ? 0.125 : 0,
              child: Icon(
                isSelected ? Icons.close_rounded : Icons.more_horiz_rounded,
                color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: color,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoDataWidget() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.person_search_rounded,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada data PIC',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Data akan muncul di sini',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _animateButtonPress(VoidCallback action) {
    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
      action();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      mRekanPicListBloc.add(FetchMRekanPicListEvent());
    }
  }

  void onHapusFunction(String recordId) {
    mRekanPicCrudBloc.add(MRekanPicCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ShowDialogHapusWidget(
          onHapusFunction: onHapusFunction,
          recordId: recordId,
        );
      },
    ).then((_) {
      mRekanPicListBloc.add(CloseDialogMRekanPicListEvent());
    });
  }
}