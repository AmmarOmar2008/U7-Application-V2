import 'package:flutter/material.dart';
import 'screens/game_level.dart';
import 'data/questions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لعبة الاستدامة الغذائية',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الخروج'),
        content: const Text('هل تريد الخروج من التطبيق؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('خروج'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100,
              Colors.green.shade50,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.eco,
                size: 80,
                color: Color.fromARGB(255, 3, 28, 255),
              ),
              const SizedBox(height: 30),
              const Text(
                'مرحباً بك في\nلعبة الاستدامة الغذائية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'تعلم وأختبر معرفتك حول الاستدامة الغذائية من خلال مستويين تعليميين',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomePage(showVideoFirst: true),
                    ),
                  );
                },
                icon: const Icon(Icons.play_circle_outline),
                label: const Text(
                  'مشاهدة الفيديو التعليمي',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomePage(showVideoFirst: false),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz),
                label: const Text(
                  'بدء الاختبار مباشرة',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final shouldExit = await _showExitDialog(context);
                  if (shouldExit ?? false) {
                    SystemNavigator.pop();
                  }
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text(
                  'خروج من التطبيق',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool showVideoFirst;

  const HomePage({
    super.key,
    required this.showVideoFirst,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final YoutubePlayerController _controller;
  bool _isLevel1Completed = false;

  @override
  void initState() {
    super.initState();
    if (widget.showVideoFirst) {
      _initYoutubePlayer();
    }
    _loadLevelStatus();
  }

  Future<void> _loadLevelStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLevel1Completed = prefs.getBool('level_1_completed') ?? false;
    });
  }

  void _initYoutubePlayer() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'RMx3bcTlxqY',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
        loop: false,
        showVideoAnnotations: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.showVideoFirst) {
      _controller.close();
    }
    super.dispose();
  }

  void _showLevelLockedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('المستوى مقفل'),
        content: const Text(
            'يجب إكمال المستوى الأول أولاً بنجاح للوصول إلى المستوى الثاني'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار المستوى'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100,
              Colors.green.shade50,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (widget.showVideoFirst) ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'الفيديو التعليمي',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: YoutubePlayer(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
            const Center(
              child: Icon(
                Icons.eco,
                size: 80,
                color: Color.fromARGB(255, 3, 28, 255),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'اختر المستوى',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'قم باختيار المستوى المناسب لك للبدء في الاختبار',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameLevel(
                            questions: level1Questions,
                            level: 1,
                          ),
                        ),
                      ).then((_) => _loadLevelStatus());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'المستوى ١',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLevel1Completed
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameLevel(
                                  questions: level2Questions,
                                  level: 2,
                                ),
                              ),
                            );
                          }
                        : _showLevelLockedDialog,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      backgroundColor: _isLevel1Completed ? null : Colors.grey,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'المستوى ٢',
                          style: TextStyle(
                            fontSize: 20,
                            color: _isLevel1Completed ? null : Colors.white70,
                          ),
                        ),
                        if (!_isLevel1Completed) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.lock,
                            color: Colors.white70,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
