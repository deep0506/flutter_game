import 'package:flutter/material.dart';
import 'package:game/custom_widget/custom_widgets.dart';
import 'package:game/utils/constant/app_constant.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({Key? key}) : super(key: key);

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  int attempt = 0;
  int match = 0;
  List<String>? textList;

  @override
  void initState() {
    super.initState();
    textList = List.generate(16, (index) => "?");
  }


  List<Map<int, String>> matchCheck = [];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Pick Game"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(title: "Attempt",subTitle: "$attempt"),
              CustomCard(title: "Matches",subTitle: "$match"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount:textList?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(matchCheck);
                        setState(() {
                          attempt++;
                          textList![index] = cards[index];
                          matchCheck
                              .add({index: cards[index]});
                          print(matchCheck.first);
                        });
                        if (matchCheck.length == 2) {
                          if (matchCheck[0].values.first ==
                              matchCheck[1].values.first) {
                            match += 1;
                            matchCheck.clear();
                          } else {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              setState(() {
                                textList![matchCheck[0].keys.first] =
                                    "?";
                                textList![matchCheck[1].keys.first] =
                                    "?";
                                matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Colors.black,width: 2,)
                        ),
                        child: Center(child: Text(textList![index],style: const TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),)),
                      ),
                    );
                  }))
        ],
      ),

    );
  }
}
