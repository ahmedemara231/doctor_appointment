import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/view/home/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/base_widgets/text.dart';
import '../../helpers/data_types/spec.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Speciality> specialities = [
    Speciality(
        image: Assets.imagesGeneral,
        speciality: 'General'
    ),
    Speciality(
        image: Assets.imagesNeurologic,
        speciality: 'Neurologic'
    ),
    Speciality(
        image: Assets.imagesPediatric,
        speciality: 'Pediatric'
    ),
    Speciality(
        image: Assets.imagesRadiology,
        speciality: 'Radiology'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: 'Hi, Omar', fontWeight: FontWeight.w500,),
              MyText(text: 'How are you today?', color: Colors.grey, fontSize: 16.sp,),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none)
            )
          ],
        ),
        body: Column(
          children: [
            const HomeCard(),
            Row(
              children: [
                MyText(text: 'Doctor Speciality', fontSize: 18.sp, fontWeight: FontWeight.w500,),
                const Spacer(),
                TextButton(
                    onPressed: (){},
                    child: MyText(text: 'See All', color: Colors.blue,)
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    specialities.length,
                        (index) => Column(
                      children: [
                        CircleAvatar(
                          radius: 30.sp,
                          backgroundColor: Colors.grey[200],
                          child: Image.asset(specialities[index].image),
                        ),
                        const SizedBox(height: 5),
                        MyText(
                          text: specialities[index].speciality,
                          fontSize: 12.sp,
                        )
                      ],
                    )
                ),
              ),
            ),
            Row(
              children: [
                MyText(text: 'Recommendation Doctor', fontSize: 18.sp, fontWeight: FontWeight.w500,),
                const Spacer(),
                TextButton(
                    onPressed: (){},
                    child: MyText(text: 'See All', color: Colors.blue,)
                )
              ],
            ),
          ],
        )
    );
  }
}