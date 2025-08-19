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
                          return Material(color: Colors.transparent,
                              child: toHeroContext.widget);
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
        title: Text(person.emoji, style: TextStyle(fontSize: 40)),
        centerTitle: true
      ),
      body: Center(
        child: Column(
          children: [Text(person.name), Text('${person.age} years old'),
          Hero(
            tag: person.name,
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/Images/flower.png'),
            ),
          )
          ],
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
