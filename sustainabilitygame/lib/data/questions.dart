class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

final List<Question> level1Questions = [
  Question(
    question: 'ما هي الاستدامة الغذائية؟',
    options: [
      'تناول الطعام العضوي فقط',
      'طريقة لإنتاج الطعام لا تضر بالبيئة',
      'المواد الغذائية باهظة الثمن',
      'استهلاك الوجبات السريعة'
    ],
    correctAnswer: 1,
    explanation: 'الاستدامة الغذائية تعني إنتاج الطعام بطريقة تحافظ على الموارد الطبيعية وتدعم النظم البيئية وتضمن الأمن الغذائي للأجيال القادمة دون الإضرار بالبيئة.',
  ),
  Question(
    question: 'ما هي الممارسة التي تقلل من هدر الطعام؟',
    options: [
      'الشراء بكميات كبيرة دون تخطيط',
      'التخطيط السليم للوجبات والتخزين',
      'طلب الطعام للمنزل دائماً',
      'رمي بقايا الطعام'
    ],
    correctAnswer: 1,
    explanation: 'التخطيط السليم للوجبات والتخزين يساعد في تقليل هدر الطعام من خلال ضمان شراء ما نحتاجه فقط وحفظ الطعام بشكل صحيح، مما يمنع التلف والهدر غير الضروري.',
  ),
  Question(
    question: 'ما هو التسميد العضوي؟',
    options: [
      'رمي الطعام في القمامة',
      'حرق نفايات الطعام',
      'تحويل النفايات العضوية إلى سماد',
      'تجميد بقايا الطعام'
    ],
    correctAnswer: 2,
    explanation: 'التسميد العضوي هو عملية طبيعية تحول النفايات العضوية إلى سماد غني بالمغذيات للتربة، مما يقلل من نفايات المكبات ويوفر مغذيات قيمة للنباتات.',
  ),
  Question(
    question: 'ما هو الخيار الغذائي المستدام؟',
    options: [
      'المنتجات الموسمية المزروعة محلياً',
      'الفواكه المستوردة خارج موسمها',
      'الأطعمة المصنعة بكثافة',
      'الوجبات الخفيفة المعلبة'
    ],
    correctAnswer: 0,
    explanation: 'المنتجات الموسمية المزروعة محلياً مستدامة لأنها تتطلب نقلاً أقل، وتدعم المزارعين المحليين، وعادةً ما تستخدم موارد أقل في الإنتاج.',
  ),
  Question(
    question: 'ما الذي يساعد في تقليل البصمة الكربونية في إنتاج الغذاء؟',
    options: [
      'النقل لمسافات طويلة',
      'التغليف المفرط',
      'النظام الغذائي النباتي',
      'الزراعة الصناعية'
    ],
    correctAnswer: 2,
    explanation: 'النظام الغذائي النباتي يساعد في تقليل البصمة الكربونية لأن إنتاج النباتات عموماً يتطلب مياهاً وأرضاً وطاقة أقل مقارنة بالثروة الحيوانية.',
  ),
  Question(
    question: 'ما هو التغليف الأكثر صديقاً للبيئة؟',
    options: [
      'البلاستيك قابل للاستخدام مرة واحدة',
      'المواد القابلة للتحلل',
      'طبقات متعددة من البلاستيك',
      'أوعية من مادة الاستايروفوم'
    ],
    correctAnswer: 1,
    explanation: 'المواد القابلة للتحلل تتحلل بشكل طبيعي دون الإضرار بالبيئة، على عكس البلاستيك والاستايروفوم التي يمكن أن تستمر لآلاف السنين.',
  ),
  Question(
    question: 'ما هو المزرعة إلى الطاولة؟',
    options: [
      'توزيع الأطعمة المصنعة',
      'التوريد المباشر من المزارع إلى المستهلكين',
      'التجارة الدولية للأغذية',
      'توصيل الوجبات السريعة'
    ],
    correctAnswer: 1,
    explanation: 'المزرعة إلى الطاولة تعني أن الأغذية يتم توريدها مباشرة من المزارع المحلية إلى المستهلكين، مما يقلل من مسافات النقل ويدعم الزراعة المحلية.',
  ),
  Question(
    question: 'كيف يمكننا دعم صيد الأسماك المستدام؟',
    options: [
      'صيد الأسماك المفرط',
      'اختيار الأسماك البحرية المستدامة المعتمدة',
      'تجاهل مواسم الصيد',
      'استخدام أساليب صيد ضارة'
    ],
    correctAnswer: 1,
    explanation: 'الأسماك البحرية المستدامة المعتمدة تضمن أن الأسماك يتم صيدها باستخدام أساليب لا تضر بالبيئة البحرية.',
  ),
  Question(
    question: 'ما هي الزراعة الحضرية؟',
    options: [
      'الزراعة الصناعية',
      'زراعة الأغذية في المدن',
      'استيراد المنتجات الغذائية',
      'معالجة الأغذية'
    ],
    correctAnswer: 1,
    explanation: 'الزراعة الحضرية تعني زراعة الأغذية في المدن، مما يقلل من الحاجة إلى نقل الأغذية ويوفر أغذية محلية طازجة ويساهم في خلق مساحات خضراء حضرية.',
  ),
  Question(
    question: 'ما هي الممارسة التي تحافظ على المياه في إنتاج الأغذية؟',
    options: [
      'ري الفيض',
      'أنظمة الري بالتنقيط',
      'الرش المستمر',
      'لا يوجد ري'
    ],
    correctAnswer: 1,
    explanation: 'أنظمة الري بالتنقيط توفر المياه مباشرة إلى جذور النبات، مما يقلل من هدر المياه بسبب التبخر والجريان السطحي.',
  ),
];

final List<Question> level2Questions = [
  Question(
    question: 'ما هي الزراعة التجديدية؟',
    options: [
      'طريقة زراعية تستنزف موارد التربة',
      'نهج شامل يعزز صحة النظام البيئي وخصوبة التربة',
      'استخدام الأسمدة الكيميائية لزيادة المحصول',
      'زراعة نوع واحد من المحاصيل في كل موسم'
    ],
    correctAnswer: 1,
    explanation: 'الزراعة التجديدية هي نهج زراعي شامل يركز على استعادة صحة التربة، وزيادة التنوع البيولوجي، وتحسين دورات المياه، وتعزيز خدمات النظام البيئي مع إنتاج غذاء مغذٍ.',
  ),
  Question(
    question: 'كيف يساعد تقليل استهلاك اللحوم في الاستدامة؟',
    options: [
      'لا يساعد',
      'يقلل من استخدام المياه وانبعاثات غازات الاحتباس الحراري',
      'يجعل الطعام أكثر تكلفة',
      'يزيد من استخدام الأراضي'
    ],
    correctAnswer: 1,
    explanation: 'تقليل استهلاك اللحوم يساعد في الاستدامة لأن إنتاج اللحوم عادةً يتطلب مياهاً وأرضاً وطاقة أكثر، وينتج غازات احتباس حراري أكثر من الأغذية النباتية.',
  ),
  Question(
    question: 'ما هي الصحراء الغذائية؟',
    options: [
      'مكان به العديد من خيارات الوجبات السريعة',
      'منطقة تفتقر إلى الوصول للطعام الطازج والصحي',
      'اتجاه جديد في الحلويات',
      'نوع من المطاعم'
    ],
    correctAnswer: 1,
    explanation: 'الصحراء الغذائية هي منطقة يكون فيها وصول السكان إلى الطعام المغذي بأسعار معقولة محدوداً، غالباً بسبب نقص متاجر البقالة أو أسواق المزارعين.',
  ),
  Question(
    question: 'ما هي طريقة الزراعة التي تستخدم أقل كمية من المياه؟',
    options: [
      'الزراعة المائية',
      'الري التقليدي',
      'أنظمة الرش',
      'الري بالغمر'
    ],
    correctAnswer: 0,
    explanation: 'الزراعة المائية تستخدم حتى 90% مياه أقل من الزراعة التقليدية لأن المياه يتم إعادة تدويرها وتوصيلها مباشرة إلى جذور النباتات.',
  ),
  Question(
    question: 'ما هو تأثير نفايات تغليف الطعام؟',
    options: [
      'لا يوجد تأثير بيئي',
      'يساعد في حفظ الطعام لفترة أطول',
      'يساهم في التلوث ومكبات النفايات',
      'يحسن جودة الطعام'
    ],
    correctAnswer: 2,
    explanation: 'نفايات تغليف الطعام تساهم بشكل كبير في التلوث، وتملأ مكبات النفايات، ويمكن أن تستغرق مئات السنين للتحلل، مما يضر بالحياة البرية والنظم البيئية.',
  ),
  Question(
    question: 'كيف يمكن للمدارس تعزيز الاستدامة الغذائية؟',
    options: [
      'المزيد من آلات البيع',
      'حدائق المدرسة وبرامج التعليم',
      'خيارات الغداء المصنعة',
      'حظر فترات الغداء'
    ],
    correctAnswer: 1,
    explanation: 'حدائق المدرسة وبرامج التعليم تعلم الطلاب عن إنتاج الغذاء المستدام، والأكل الصحي، والإشراف البيئي.',
  ),
  Question(
    question: 'ما هو الاقتصاد الغذائي الدائري؟',
    options: [
      'قطع أراضي زراعية دائرية',
      'نظام يتم فيه تقليل النفايات وإعادة استخدام الموارد',
      'سلسلة مطاعم وجبات سريعة',
      'خدمة توصيل طعام'
    ],
    correctAnswer: 1,
    explanation: 'الاقتصاد الغذائي الدائري هو نظام يهدف إلى تقليل النفايات وإعادة استخدام الموارد في كل مرحلة من مراحل إنتاج واستهلاك الغذاء.',
  ),
  Question(
    question: 'ما هو تأثير تغير المناخ على إنتاج الغذاء؟',
    options: [
      'لا يوجد تأثير',
      'يحسن من المحاصيل',
      'يغير مواسم الزراعة ويزيد من الظواهر الجوية القاسية',
      'يجعل الطعام أكثر نكهة'
    ],
    correctAnswer: 2,
    explanation: 'تغير المناخ يؤثر على مواسم الزراعة، ويزيد من الظواهر الجوية القاسية، ويمكن أن يؤدي إلى فشل المحاصيل وتقليل الإنتاج.',
  ),
  Question(
    question: 'ما هو التغليف المستدام؟',
    options: [
      'طبقات متعددة من البلاستيك',
      'مواد صديقة للبيئة وقابلة لإعادة التدوير',
      'تغليف باهظ الثمن',
      'لا يوجد تغليف'
    ],
    correctAnswer: 1,
    explanation: 'التغليف المستدام يستخدم مواد صديقة للبيئة وقابلة لإعادة التدوير، مما يقلل من التأثير البيئي.',
  ),
  Question(
    question: 'كيف يمكن للتكنولوجيا تحسين الاستدامة الغذائية؟',
    options: [
      'من خلال زيادة هدر الطعام',
      'الزراعة الذكية واستخدام الموارد بكفاءة',
      'جعل الطعام أكثر تكلفة',
      'إزالة المزارعين'
    ],
    correctAnswer: 1,
    explanation: 'التكنولوجيا يمكن أن تحسن الاستدامة الغذائية من خلال الزراعة الدقيقة، وإدارة الموارد بكفاءة، ورصد صحة المحاصيل واستخدام المياه.',
  ),
];
