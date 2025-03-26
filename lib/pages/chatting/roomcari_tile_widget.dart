import 'package:eassist_tools_app/pages/groupchat/groupchat_main.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';

class RoomCariTileWidget extends StatelessWidget {
	final String chatgroupId;
	final String chatroomId;
	final String roomName;
	final String groupName;

	const RoomCariTileWidget(
		{super.key,
		required this.chatgroupId, 
		required this.chatroomId, 
		required this.roomName, 
		required this.groupName});

	@override
	Widget build(BuildContext context) {
		return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                      const Expanded(
                        flex: 2,
                        child: Icon(
                            Icons.group,
                            size: 50.0,
                          )),
                  Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [				    		
                              Text(
                                roomName,
                                style: MyText.bodyLarge(context)!
                                  .copyWith(color: MyColors.grey_80)),
                                Container(height: 10),
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                
                                return GroupChatMainPage(roomId: chatroomId, groupName: groupName, roomName: roomName);
                              }),
                            );

                          },
                          child: const Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            size: 50.0,
                          ),
                        ),
                      )
                ],
              ),
            )
          ),
        );
	}
}
