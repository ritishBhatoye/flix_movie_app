import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/assistant/bloc/chat_bloc.dart';
import 'package:netflix_clone/assistant/models/chat_message_model.dart';
// import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';

class HomePageAssistant extends StatefulWidget {
  const HomePageAssistant({super.key});

  @override
  State<HomePageAssistant> createState() => _HomePageAssistantState();
}

class _HomePageAssistantState extends State<HomePageAssistant> {
  final ChatBloc chatBloc = ChatBloc();

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: Colors.transparent,
      child:assistantPage(chatBloc: chatBloc, runtimeType: runtimeType, textEditingController: textEditingController)

    );

  }
}


      // assistantPage(chatBloc: chatBloc, runtimeType: runtimeType, textEditingController: textEditingController);

class assistantPage extends StatelessWidget {
  const assistantPage({
    super.key,
    required this.chatBloc,
    required this.runtimeType,
    required this.textEditingController,
  });

  final ChatBloc chatBloc;
  final Type runtimeType;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.transparent,

      body: Card(
        elevation: 0,
        color: Colors.transparent,
        
        child: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {},
          builder: ((context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Container(
                  
                  width: MediaQuery.sizeOf(context).width,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    
                      // image: DecorationImage(
                      //     opacity: 0.5,
                      //     image: AssetImage("assets/space_bg.jpg"),
                      //     fit: BoxFit.cover)
                          ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   height: 100,
                      //   // color: Colors.red,
                      //   child: 
                      //   Row(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Patara",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 24),
                      //       ),
                      //       Icon(
                      //         Icons.image_search,
                      //         color: Colors.white,
                      //       )
                      //     ],
                      //   ),
                      // ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                 
                        
                                  return FadeInDown(
                                     animate: true,
                    duration: Duration(milliseconds: 700),

                delay: const Duration(microseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                        child: Align(
                                      alignment: 
                                      messages[index].role=="user"?
                                      Alignment.topLeft:
                                      Alignment.topRight,
                                      child: Container(
                                          margin: 
                                      messages[index].role=="user"?
                                                            
                                          const EdgeInsets.only(
                                              bottom: 6, left: 0, right: 40,top: 6)
                                              :const EdgeInsets.only(
                                              bottom: 6, left: 47.5, right: 0,top: 10),
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                      
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors:
                                                messages[index].role=="user"?
                                                <Color>[Color.fromARGB(164, 0, 0, 0), Color.fromARGB(152, 158, 158, 158),Color.fromARGB(243, 255, 255, 255)]
                                               
                                                :   <Color>[Color.fromARGB(164, 0, 0, 0), Color.fromARGB(163, 255, 17, 0),Colors.red]),
                                              borderRadius: BorderRadius.circular(16),
                                              // color: Color.fromARGB(136, 255, 17, 0)
                                                  ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                messages[index].role == "user"
                                                    ? "User"
                                                    : "Flix",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        messages[index].role == "user"
                                                            ? Colors.white
                                                            : Colors.red),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                messages[index].parts.first.text,
                                                style: TextStyle(height: 1.2),
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                })),
                      if (chatBloc.generating)
                        Row(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Lottie.asset('assets/loader.json')),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Loading..."),
                          ],
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 0),
                        // height: 120,
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: textEditingController,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    fillColor: Colors.transparent,
                                    hintText: "Ask something from Flix ",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color:
                                               Colors.transparent
                                                // Theme.of(context).primaryColor
                                                
                                                ))),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  String text = textEditingController.text;
                                  textEditingController.clear();
                                  chatBloc.add(ChatGenerateNewTextMessageEvent(
                                      inputMessage: text));
                                }
                              },
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Color.fromARGB(86, 89, 89, 89),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              default:
                return SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
