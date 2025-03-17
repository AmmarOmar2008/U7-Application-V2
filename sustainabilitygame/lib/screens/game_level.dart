import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/questions.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class GameLevel extends StatefulWidget {
  final List<Question> questions;
  final int level;

  const GameLevel({
    super.key,
    required this.questions,
    required this.level,
  });

  @override
  State<GameLevel> createState() => _GameLevelState();
}

class _GameLevelState extends State<GameLevel>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool showAnswer = false;
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playFeedback(bool isCorrect) async {
    try {
      await _audioPlayer.play(AssetSource(
        isCorrect ? 'sounds/correct.mp3' : 'sounds/wrong.mp3',
      ));
    } catch (e) {
      debugPrint('Error playing sound: $e');
      // Fallback to haptic feedback if sound fails
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> _saveLevelCompletion() async {
    if (correctAnswers >= 7) {
      // Pass threshold is 7 correct answers
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('level_${widget.level}_completed', true);
    }
  }

  void _checkAnswer(int selectedAnswer) {
    bool isCorrect =
        selectedAnswer == widget.questions[currentQuestionIndex].correctAnswer;
    if (isCorrect) {
      correctAnswers++;
      _animationController.forward();
    }
    _playFeedback(isCorrect);
    setState(() {
      showAnswer = true;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        showAnswer = false;
      });
      _animationController.reset();
    } else {
      _showFinalScore();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        showAnswer = false;
      });
      _animationController.reset();
    }
  }

  void _showFinalScore() {
    _saveLevelCompletion();
    final bool isHighScore = correctAnswers >= 7;

    if (isHighScore) {
      _animationController.repeat();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          isHighScore ? _buildHighScoreDialog() : _buildNormalScoreDialog(),
    );
  }

  Widget _buildHighScoreDialog() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + math.sin(_animationController.value * math.pi) * 0.03,
          child: AlertDialog(
            backgroundColor: Colors.green.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Colors.green.shade300,
                width: 3,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: _animationController.value * math.pi * 2,
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'إنجاز رائع!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Transform.rotate(
                  angle: -_animationController.value * math.pi * 2,
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'لقد حصلت على $correctAnswers من ${widget.questions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.amber,
                    ],
                    transform: GradientRotation(
                        _animationController.value * math.pi * 2),
                  ).createShader(bounds),
                  child: const Text(
                    'أنت خبير في الاستدامة! 🌟',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            actions: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.level < 2) ...[
                        ElevatedButton.icon(
                          onPressed: () {
                            _animationController.stop();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameLevel(
                                  questions: level2Questions,
                                  level: 2,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('المستوى التالي'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      ElevatedButton.icon(
                        onPressed: () {
                          _animationController.stop();
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameLevel(
                                questions: widget.questions,
                                level: widget.level,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.replay),
                        label: const Text('إعادة المحاولة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _animationController.stop();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('العودة للقائمة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNormalScoreDialog() {
    return AlertDialog(
      title: const Text('اكتمل المستوى!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('لقد حصلت على $correctAnswers من ${widget.questions.length}'),
          const SizedBox(height: 10),
          Text(
            correctAnswers >= 5
                ? 'عمل جيد! واصل تعلم المزيد عن الاستدامة! 📚'
                : 'واصل التدرب لتتعلم المزيد عن الاستدامة! 💪',
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameLevel(
                      questions: widget.questions,
                      level: widget.level,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.replay),
              label: const Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
              label: const Text('العودة للقائمة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionButton(int index, String option, bool isCorrectAnswer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        color: showAnswer
            ? (isCorrectAnswer
                ? Colors.green.shade100
                : index == widget.questions[currentQuestionIndex].correctAnswer
                    ? Colors.green.shade100
                    : Colors.red.shade100)
            : Colors.white,
        child: InkWell(
          onTap: showAnswer ? null : () => _checkAnswer(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('هل تريد الخروج من الاختبار؟'),
            content:
                const Text('سيتم فقدان تقدمك في هذا المستوى إذا خرجت الآن.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('البقاء'),
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
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('اختبار المستوى ${widget.level}'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Material(
          color: Colors.white,
          child: SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / widget.questions.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السؤال ${currentQuestionIndex + 1}/${widget.questions.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'الإجابات الصحيحة: $correctAnswers',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      currentQuestion.question,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  currentQuestion.options.length,
                  (index) => _buildOptionButton(
                    index,
                    currentQuestion.options[index],
                    index == currentQuestion.correctAnswer,
                  ),
                ),
                if (showAnswer) ...[
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explanation:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion.explanation,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentQuestionIndex > 0)
                        ElevatedButton.icon(
                          onPressed: _previousQuestion,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('السابق'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      ElevatedButton.icon(
                        onPressed: _nextQuestion,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          currentQuestionIndex < widget.questions.length - 1
                              ? 'التالي'
                              : 'إنهاء',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
