import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/home/home_cubit.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    widget.homeCubit.getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.homeCubit,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: Stack(
              children: [
                DefaultAppBarWithRadius(
                  screenTitle: "",
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              "assets/images/yousef_avatar.png",
                            ),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Youssef Salama",
                        style: AppConstants.textTheme(context).titleSmall,
                      ),
                    ],
                  ),
                  suffixIcon: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) {
                      return current is GetChatLoadingState ||
                          current is GetChatSuccessState ||
                          current is GetChatErrorState;
                    },
                    builder: (context, state) {
                      return state is GetChatLoadingState
                          ? const Padding(
                              padding: EdgeInsetsDirectional.only(end: 16),
                              child: CircularProgressIndicator(
                                color: AppColors.oldMainColor,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                widget.homeCubit.getMessages();
                              },
                              icon: const Icon(
                                Icons.refresh_rounded,
                                color: AppColors.white,
                              ),
                            );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) =>
                        current is SendMessageSuccessState ||
                        current is SendMessageLoadingState ||
                        current is SendMessageErrorState ||
                        current is GetChatLoadingState ||
                        current is GetChatErrorState ||
                        current is GetChatSuccessState,
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.viewInsetsOf(context).bottom),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: state is GetChatLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.oldMainColor,
                                      ),
                                    )
                                  : ListView(
                                      reverse: true,
                                      controller: scrollController,
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 8,
                                      ),
                                      children: List.generate(
                                          context
                                              .watch<HomeCubit>()
                                              .messages
                                              .length, (index) {
                                        return _buildMessageListItem(
                                          message: context
                                                  .watch<HomeCubit>()
                                                  .messages[index]
                                                  .message ??
                                              "",
                                          receiver: context
                                                  .watch<HomeCubit>()
                                                  .messages[index]
                                                  .receiver ??
                                              "",
                                        );
                                      }),
                                    ),
                            ),
                            const Divider(
                              color: AppColors.lightGrey,
                              thickness: 2,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextField(
                                        controller: context
                                            .read<HomeCubit>()
                                            .messageController,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: AppColors.lightGrey,
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          hintStyle:
                                              AppConstants.textTheme(context)
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: AppColors.mainColor,
                                                  ),
                                          hintText: "typeYourMessage"
                                              .getLocale(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  state is SendMessageLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.oldMainColor,
                                          ),
                                        )
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.send,
                                            color: AppColors.oldMainColor,
                                          ),
                                          onPressed: () {
                                            String message = context
                                                .read<HomeCubit>()
                                                .messageController
                                                .text;
                                            if (message.isNotEmpty) {
                                              context
                                                  .read<HomeCubit>()
                                                  .sendMessage(message);
                                            }
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageListItem({
    String message = '',
    String receiver = '',
  }) {
    return Align(
      alignment:
          receiver.isNotEmpty ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        decoration: BoxDecoration(
          color:
              receiver.isNotEmpty ? AppColors.oldMainColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          receiver.isNotEmpty ? receiver : message,
          textAlign: receiver.isNotEmpty ? TextAlign.left : TextAlign.right,
          style: TextStyle(
            fontSize: 16.0,
            color: receiver.isNotEmpty ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
