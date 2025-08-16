import 'package:flutter/material.dart';

// HERO ANIMATION IN FLUTTER

class HeroAnimation extends StatelessWidget {
  HeroAnimation({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation"), centerTitle: true),
      body: Center(
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonDetail(person: people[index]),
                  ),
                );
              },
              leading: Hero(
                flightShuttleBuilder:
                    (
                      flightContext,
                      animation,
                      flightDirection,
                      fromHeroContext,
                      toHeroContext,
                    ) {
                      switch (flightDirection) {

                        case HeroFlightDirection.push:
                          return Material(color: Colors.transparent,child: ScaleTransition(
                              scale: animation.drive(Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut))),
                              child: toHeroContext.widget));
                        case HeroFlightDirection.pop:
                          return Material(color: Colors.transparent,child: fromHeroContext.widget);
                      }
                    },
                tag: people[index].name,
                child: Text(
                  people[index].emoji,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              title: Text(people[index].name),
              subtitle: Text('${people[index].age} years old'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            );
          },
        ),
      ),
    );
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: person.name,
          child: Text(person.emoji, style: TextStyle(fontSize: 40)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [Text(person.name), Text('${person.age} years old')],
        ),
      ),
    );
  }
}

@immutable
class Person {
  final String name;
  final String emoji;
  final int age;

  const Person({required this.name, required this.emoji, required this.age});
}

List<Person> people = [
  Person(name: 'Jimi', emoji: '👨‍🎓', age: 18),
  Person(name: 'Ali', emoji: '👨', age: 18),
  Person(name: 'Jack', emoji: '👨‍🎓', age: 18),
];
