import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/pages/chatting/roomcari_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/roomcari_bloc.dart';
import 'package:eassist_tools_app/models/chatting/roomcari_model.dart';
import 'package:grouped_list/grouped_list.dart';

class RoomCariListWidget extends StatefulWidget {
  final String searchText;
  const RoomCariListWidget({super.key, required this.searchText});

  @override
  RoomCariListWidgetState createState() => RoomCariListWidgetState();
}

class RoomCariListWidgetState extends State<RoomCariListWidget> {
  late RoomCariBloc roomCariBloc;
  List<RoomCariModel> roomCari = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    roomCariBloc = BlocProvider.of<RoomCariBloc>(context);
    return BlocConsumer<RoomCariBloc, RoomCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            if (!state.hasReachedMax) {
              roomCari.addAll(state.items);
            }
            var elements = state.items.map((e) => e.toJson()).toList();

            return state.items.isNotEmpty
                ? Flexible(
                    child: Container(
                    color: Colors.grey[200],
                    child: GroupedListView<dynamic, String>(  
                      controller: _scrollController,                    
                      elements: elements,
                      groupBy: (elements) => elements['groupName'],
                      groupComparator: (value1, value2) =>
                          value1.compareTo(value2),
                      itemComparator: (item1, item2) =>
                          item1['chatroomId'].compareTo(item2['chatroomId']),
                      order: GroupedListOrder.ASC,
                      useStickyGroupSeparators: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      groupSeparatorBuilder: (String value) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      indexedItemBuilder: (c, element, index) {
                        return RoomCariTileWidget(
                            chatgroupId: element["chatgroupId"],
                            chatroomId: element["chatroomId"],
                            roomName: element["roomName"],
                            groupName: element["groupName"]);
                      },
                    ),
                  ))
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Text(
                        'No Data Available!!',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
          } else {
            return const Center(
              child: Text(
                'No Data Available!!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
        },
        buildWhen: (previous, current) {
          return (current.status == ListStatus.success);
        },
        listener: (context, state) {});
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      roomCariBloc.add(FetchRoomCariEvent(
          searchText: widget.searchText, hal: roomCariBloc.state.hal));
    }
  }
}
