import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/src/features/home/widgets/user_chats_widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_widgets/doctors_search.dart';

class UserChats extends StatefulWidget {
  UserChats({super.key});

  @override
  State<UserChats> createState() => _UserChatsState();
}

class _UserChatsState extends State<UserChats> {
  late final TextEditingController searchController;
  late final ScrollController scrollingController;
  // bool isSearchBarVisible = true;

  ValueNotifier<bool> isSearchBarVisible = ValueNotifier(true);

  void _scrollListener(){
    if(scrollingController.position.userScrollDirection == ScrollDirection.forward){
      isSearchBarVisible.value = true;
    }else{
      isSearchBarVisible.value = false;
    }
  }
  @override
  void initState() {
    searchController = TextEditingController();
    scrollingController = ScrollController();
    scrollingController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollingController.removeListener(_scrollListener);
    scrollingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(text: 'Messages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: isSearchBarVisible,
              builder: (context, value, child) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: value ? 90.h : 0,
                  child: value
                      ? DoctorsSearch(
                    controller: searchController,
                    onChanged: (p0) {},
                  )
                      : const SizedBox.shrink()),
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollingController,
                  itemBuilder: (context, index) => ChatCard(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 12.h,
                      ),
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
