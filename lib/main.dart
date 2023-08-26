import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const PictureStoryApp());
}

class PictureStoryApp extends StatelessWidget {
  const PictureStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StoryLibraryScreen(),
    );
  }
}

class StoryLibraryScreen extends StatelessWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add New Story'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Title'),
                  Text('Image'),
                  Text('Content'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Library'),
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    storyList[index].coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    storyList[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showMyDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class StoryViewerScreen extends StatefulWidget {
  StoryViewerScreen({super.key, required this.story});
  final Story story;

  FlutterTts flutterTts = FlutterTts();

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreen();
}

class _StoryViewerScreen extends State<StoryViewerScreen> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.story.coverImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.story.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implement interactive elements or read-aloud functionality
                if (playing) {
                  await widget.flutterTts.pause();
                } else {
                  await widget.flutterTts.speak(widget.story.content);
                }
                setState(() {
                  playing = !playing;
                });
              },
              child: Text(playing ? 'Pause' : 'Read Aloud'),
            ),
          ],
        ),
      ),
    );
  }
}

class Story {
  final String title;
  final String coverImage;
  final String content;

  Story({required this.title, required this.coverImage, required this.content});
}

// Dummy data
List<Story> storyList = [
  Story(
    title: 'A man with bad luck',
    coverImage: 'assets/yevgeny_prigozhin.jpeg',
    content:
        "Yevgeny Prigozhin (1 June 1961 - 23 August 2023) was a Russian oligarch and leader of the Wagner private military company. He was a close confidant of Russian President Vladimir Putin until he launched a rebellion in June 2023. "
        "Prigozhin was sometimes referred to as 'Putin's chef' because he owned restaurants and catering businesses that provided services to the Kremlin. Once a convict in the Soviet Union, Prigozhin controlled a network of influential companies whose operations, according to a 2022 investigation, "
        "were 'tightly integrated with Russia's Defence Ministry and its intelligence arm, the GRU'.\n\n In 2014, Prigozhin reportedly founded the Wagner Group to support pro-Russian paramilitaries in Ukraine. Funded by the Russian state, it played a significant role in Russia's invasion of Ukraine and "
        "supported Russian interests in the Middle East and in Africa. In November 2022, Prigozhin acknowledged his companies' interference in United States elections. In February 2023, he confirmed that he was the founder and long-time manager of the Internet Research Agency, a Russian company accused "
        "of running online propaganda and disinformation campaigns.",
  ),
  Story(
    title: 'The Adventure of Alex',
    coverImage: 'assets/adventure.jpg',
    content:
        "In a land veiled by mystery, young Alex embarked on an extraordinary adventure that would forever alter his life's course. The sun cast golden rays upon the untouched landscape as Alex's curiosity led him into a dense forest, whispering secrets of hidden realms. "
        "Guided by an ancient map, he navigated through towering trees and babbling brooks, stumbling upon a forgotten cave entrance. Inside, shimmering crystals illuminated a trove of relics from eras unknown. Among them was a weathered journal chronicling tales of courage and wonder. "
        "Driven by an insatiable thirst for knowledge, Alex deciphered the journal's cryptic passages, uncovering the path to a mythical artifact—a source of boundless power. With the journal in hand, he faced treacherous challenges and unraveled age-old puzzles, proving his mettle as a true adventurer. "
        "Yet, the artifact's allure was a double-edged sword, tempting even the noblest hearts with its promise. In the final confrontation, Alex chose wisdom over power, leaving the artifact untouched, safeguarding the balance of the world. "
        "Emerging from the depths, Alex returned to his village a hero, not for the treasures he sought, but for the wisdom he gained. The adventure transformed him, gifting him a legacy of courage, humility, and a lifelong appreciation for life's enigmatic wonders.",
  ),
  Story(
    title: 'Lost in the unknown city',
    coverImage: 'assets/lost_in_city.jpg',
    content:
        "Amidst the whispers of history, a young boy named Leo found himself adrift in the labyrinthine alleys of an ancient city. The city's stones spoke tales of empires and epochs long past, and as Leo wandered its cobblestone streets, he became a living echo of the past. "
        "Separated from his family during a bustling market day, Leo's heart raced with a mix of awe and fear. Towering columns, ornate archways, and weathered statues cast their shadows on him. The city's grandeur seemed to hold him captive, weaving a spell of enchantment that entwined his steps. "
        "As the sun dipped below the horizon, Leo's footsteps took him deeper into the heart of the city. Flickering lanterns illuminated forgotten courtyards and secret passages. He glimpsed glimpses of lives that had once thrived within these walls—merchants, poets, artisans—all leaving whispers of their existence for him to discover. "
        "Leo's journey led him to a plaza where an ancient tree stretched its branches toward the stars. Beneath it sat an elderly man, a guardian of the city's memories. His eyes held a wisdom that transcended time, and he listened to Leo's story of being lost amidst the city's stories. "
        "The old man shared tales of bygone eras, igniting Leo's imagination with images of triumphant kings, mysterious artifacts, and untamed adventures. The stories painted a vivid tapestry of the city's history, connecting its past to the present. "
        "With the dawn's light, the city revealed its secrets to Leo. Guided by the old man's wisdom, he navigated its winding paths with newfound purpose. He discovered hidden fountains, intricate mosaics, and the melody of a forgotten song echoing through ancient walls. "
        "Finally, as the city awoke with life, Leo's steps retraced his journey, leading him back to the plaza. There, the old man awaited, a knowing smile gracing his lips. Leo thanked him for the stories and the lessons they held. "
        "As Leo was reunited with his family, he carried with him not only the relief of being found but also the gift of a journey that transcended time. In the embrace of his loved ones, he knew that the ancient city had gifted him not only a day of adventure but a lifetime of stories to share—a treasure woven from the threads of past and present.",
  ),
  // Add more stories here
];
