import 'package:flutter/material.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/chat_widget.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<String> messages = [];
  TextEditingController chatCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w_12, right: Dimensions.w_12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonAppbar(),
                          VerticalSpacing(height: Dimensions.h_20),
                          const BubbleNormal(
                            text: 'Good evening! How may I assist you during your stay?',
                            isSender: false,
                            color: AppColor.white,
                            tail: true,
                            sent: true,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          const BubbleNormal(
                            text: 'Hi there! I just wanted to inquire about a few things',
                            isSender: true,
                            color: AppColor.appColor,
                            tail: true,
                            sent: true,
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          const BubbleNormal(
                            text: "Of course, I'm here to help. What do you need assistance with?",
                            isSender: false,
                            color: AppColor.white,
                            tail: true,
                            sent: true,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          const BubbleNormal(
                            text: "Sure, it seems like the air conditioning unit is not cooling the room properly. I've adjusted the temperature settings, but it still feels warm and stuffy inside.",
                            isSender: true,
                            color: AppColor.appColor,
                            tail: true,
                            sent: true,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: messages.length,itemBuilder: (c,i) {
                            return BubbleNormal(
                              text: messages[i],
                              isSender: true,
                              color: AppColor.appColor,
                              tail: true,
                              sent: true,
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.h_1,
                    child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_20,vertical: Dimensions.h_1),
                        child: SizedBox(
                          width: Dimensions.defaultWidth - Dimensions.w_10,
                          child: TextFormField(
                            cursorColor: AppColor.appColor,
                            controller: chatCont,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            cursorErrorColor: AppColor.neutral_600,
                            keyboardType: TextInputType.emailAddress,
                            style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.black,weight: FontWeight.w500),
                            decoration: InputDecoration(
                                fillColor: AppColor.white,
                                filled: true,
                                isCollapsed: true,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    messages.add(chatCont.text);
                                    chatCont.clear();
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    height: Dimensions.h_20,
                                    width: Dimensions.h_20,
                                    child: Image.asset('assets/send.png',scale: 4),
                                  ),
                                ),
                                counterText: ' ',
                                contentPadding: EdgeInsets.only(top: Dimensions.h_12,bottom: Dimensions.h_10,left: Dimensions.w_15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:   const BorderSide(color: AppColor.transparent),
                                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:   const BorderSide(color: AppColor.transparent),
                                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:   const BorderSide(color: AppColor.transparent),
                                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: AppColor.transparent),
                                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: AppColor.transparent),
                                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                                ),
                                errorStyle: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.red),
                                hintText: 'Write your message',
                                hintStyle: AppTextStyle.normalTextStyle(FontSize.sp_11, AppColor.neutral_600,weight: FontWeight.w600)),
                          ),
                        )),
                  )
                ],
              );
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w_12, right: Dimensions.w_12,bottom: Dimensions.h_15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonAppbar(),
                        VerticalSpacing(height: Dimensions.h_20),
                         BubbleNormal(
                          text: 'Good evening! How may I assist you during your stay?',
                          isSender: false,
                          color: AppColor.white,
                          tail: true,
                          sent: true,
                          textStyle: AppTextStyle.themeBoldNormalTextStyle(
                           fontSize: FontSize.sp_8,color: AppColor.black
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_10),
                         BubbleNormal(
                          text: 'Hi there! I just wanted to inquire about a few things',
                          isSender: true,
                          color: AppColor.appColor,
                          tail: true,
                          sent: true,
                          textStyle: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_8,color: AppColor.black
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_20),
                         BubbleNormal(
                          text: "Of course, I'm here to help. What do you need assistance with?",
                          isSender: false,
                          color: AppColor.white,
                          tail: true,
                          sent: true,
                          textStyle: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_8,color: AppColor.black
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_10),
                         BubbleNormal(
                          text: "Sure, it seems like the air conditioning unit is not cooling the room properly. I've adjusted the temperature settings, but it still feels warm and stuffy inside.",
                          isSender: true,
                          color: AppColor.appColor,
                          tail: true,
                          sent: true,
                           textStyle: AppTextStyle.themeBoldNormalTextStyle(
                               fontSize: FontSize.sp_8,color: AppColor.black
                           ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: messages.length,itemBuilder: (c,i) {
                          return BubbleNormal(
                            text: messages[i],
                            isSender: true,
                            color: AppColor.appColor,
                            tail: true,
                            sent: true,
                            textStyle: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_8,color: AppColor.black
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: Dimensions.h_1,
                  child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_20,vertical: Dimensions.h_1),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - Dimensions.w_80,
                        child: TextFormField(
                          cursorColor: AppColor.appColor,
                          controller: chatCont,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          cursorErrorColor: AppColor.neutral_600,
                          keyboardType: TextInputType.emailAddress,
                          style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.black,weight: FontWeight.w500),
                          decoration: InputDecoration(
                              fillColor: AppColor.white,
                              filled: true,
                              isCollapsed: true,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  messages.add(chatCont.text);
                                  chatCont.clear();
                                  setState(() {});
                                },
                                child: SizedBox(
                                  height: Dimensions.h_20,
                                  width: Dimensions.h_20,
                                  child: Image.asset('assets/send.png',scale: 4),
                                ),
                              ),
                              counterText: ' ',
                              contentPadding: EdgeInsets.only(top: Dimensions.h_12,bottom: Dimensions.h_10,left: Dimensions.w_15),
                              enabledBorder: OutlineInputBorder(
                                borderSide:   const BorderSide(color: AppColor.transparent),
                                borderRadius: BorderRadius.circular(Dimensions.h_25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:   const BorderSide(color: AppColor.transparent),
                                borderRadius: BorderRadius.circular(Dimensions.h_25),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:   const BorderSide(color: AppColor.transparent),
                                borderRadius: BorderRadius.circular(Dimensions.h_25),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:  const BorderSide(color: AppColor.transparent),
                                borderRadius: BorderRadius.circular(Dimensions.h_25),
                              ),
                              border: OutlineInputBorder(
                                borderSide:  const BorderSide(color: AppColor.transparent),
                                borderRadius: BorderRadius.circular(Dimensions.h_25),
                              ),
                              errorStyle: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.red),
                              hintText: 'Write your message',
                              hintStyle: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.neutral_600,weight: FontWeight.w600)),
                        ),
                      )),
                )
              ],
            );
          },
        ));
  }
}


