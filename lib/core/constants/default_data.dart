// lib/core/constants/default_data.dart
import '../../data/models/game_models.dart';

class DefaultData {
  // ===== EMOJIS PARA MEMORY GAME =====
  static const List<String> defaultEmojis = [
    '🎂', '🎉', '🎁', '🎈', '🌟', '💝',
    '🎊', '🍰', '🎵', '💐', '🎭', '🎨',
    '🌈', '⭐', '💫', '🎀', '🦄', '🍾',
    '💖', '🎪', '🎺', '🎸', '🎹', '🎤',
    '🎯', '🎲', '🎮', '🎸', '🎬', '📸',
    '🏆', '🎖️', '🥇', '🎗️', '🎟️', '🎫',
    '🎳', '🎱', '🏓', '🏸', '⚽', '🏀',
    '🎾', '🏐', '🏈', '⚾', '🥎', '🏑',
    '🍕', '🍔', '🍟', '🌭', '🥪', '🌮',
    '🌯', '🥙', '🧆', '🥚', '🍳', '🥞',
  ];

  // ===== PREGUNTAS DE TRIVIA POR DEFECTO =====
  static final List<TriviaQuestion> defaultTriviaQuestions = [
    TriviaQuestion(
      id: 'q1',
      question: '¿Cuál es el color favorito de [NOMBRE]?',
      options: ['Azul', 'Rojo', 'Verde', 'Amarillo'],
      correctAnswer: 0,
      category: 'Personal',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
    TriviaQuestion(
      id: 'q2',
      question: '¿En qué año nació [NOMBRE]?',
      options: ['1990', '1991', '1992', '1993'],
      correctAnswer: 1,
      category: 'Personal',
      difficulty: DifficultyLevel.medium,
      points: 150,
    ),
    TriviaQuestion(
      id: 'q3',
      question: '¿Cuál es el hobbie favorito de [NOMBRE]?',
      options: ['Leer', 'Cocinar', 'Deportes', 'Música'],
      correctAnswer: 2,
      category: 'Intereses',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
    TriviaQuestion(
      id: 'q4',
      question: '¿Cuál es la comida favorita de [NOMBRE]?',
      options: ['Pizza', 'Hamburguesa', 'Sushi', 'Pasta'],
      correctAnswer: 0,
      category: 'Favoritos',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
    TriviaQuestion(
      id: 'q5',
      question: '¿Dónde nació [NOMBRE]?',
      options: ['Buenos Aires', 'Córdoba', 'Rosario', 'Mendoza'],
      correctAnswer: 2,
      category: 'Personal',
      difficulty: DifficultyLevel.medium,
      points: 150,
    ),
    TriviaQuestion(
      id: 'q6',
      question: '¿Cuál es el animal favorito de [NOMBRE]?',
      options: ['Perro', 'Gato', 'Pájaro', 'Pez'],
      correctAnswer: 0,
      category: 'Favoritos',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
    TriviaQuestion(
      id: 'q7',
      question: '¿Cuántos hermanos tiene [NOMBRE]?',
      options: ['1', '2', '3', 'Es hijo único'],
      correctAnswer: 1,
      category: 'Familia',
      difficulty: DifficultyLevel.medium,
      points: 150,
    ),
    TriviaQuestion(
      id: 'q8',
      question: '¿Cuál es la materia favorita de [NOMBRE] en el colegio?',
      options: ['Matemáticas', 'Historia', 'Educación Física', 'Arte'],
      correctAnswer: 3,
      category: 'Escuela',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
    TriviaQuestion(
      id: 'q9',
      question: '¿Cuál es el destino de viaje soñado de [NOMBRE]?',
      options: ['París', 'Tokio', 'Nueva York', 'Londres'],
      correctAnswer: 1,
      category: 'Sueños',
      difficulty: DifficultyLevel.medium,
      points: 150,
    ),
    TriviaQuestion(
      id: 'q10',
      question: '¿Cuál es el superhéroe favorito de [NOMBRE]?',
      options: ['Superman', 'Batman', 'Spider-Man', 'Wonder Woman'],
      correctAnswer: 2,
      category: 'Entretenimiento',
      difficulty: DifficultyLevel.easy,
      points: 100,
    ),
  ];

  // ===== CATEGORÍAS DE TRIVIA =====
  static const List<String> triviaCategories = [
    'Personal',
    'Familia',
    'Intereses',
    'Favoritos',
    'Memorias',
    'Escuela',
    'Trabajo',
    'Sueños',
    'Entretenimiento',
    'Deportes',
    'Música',
    'Comida',
    'Viajes',
    'Amigos',
    'Mascotas',
  ];

  // ===== TIPOS DE EVENTO CON EMOJIS =====
  static const Map<EventType, String> eventTypeEmojis = {
    EventType.birthday: '🎂',
    EventType.wedding: '💒',
    EventType.graduation: '🎓',
    EventType.anniversary: '💕',
    EventType.babyShower: '👶',
    EventType.corporate: '🏢',
    EventType.celebration: '🎉',
  };

  static const Map<EventType, String> eventTypeNames = {
    EventType.birthday: 'Cumpleaños',
    EventType.wedding: 'Boda',
    EventType.graduation: 'Graduación',
    EventType.anniversary: 'Aniversario',
    EventType.babyShower: 'Baby Shower',
    EventType.corporate: 'Corporativo',
    EventType.celebration: 'Celebración',
  };

  // ===== PALETAS DE COLORES EXTENDIDAS =====
  static const List<ColorPalette> extendedColorPalettes = [
    ColorPalette.sunset,
    ColorPalette.ocean,
    ColorPalette.forest,
    ColorPalette(
      name: 'Lavender',
      primary: '#805AD5',
      secondary: '#B794F6',
      accent: '#D6BCFA',
      background: '#FAF5FF',
      surface: '#FFFFFF',
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: '#2D3748',
      onSurface: '#2D3748',
    ),
    ColorPalette(
      name: 'Coral',
      primary: '#F56565',
      secondary: '#FC8181',
      accent: '#FEB2B2',
      background: '#FFFAFA',
      surface: '#FFFFFF',
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: '#2D3748',
      onSurface: '#2D3748',
    ),
    ColorPalette(
      name: 'Midnight',
      primary: '#2D3748',
      secondary: '#4A5568',
      accent: '#718096',
      background: '#F7FAFC',
      surface: '#FFFFFF',
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: '#1A202C',
      onSurface: '#1A202C',
    ),
    ColorPalette(
      name: 'Candy',
      primary: '#ED64A6',
      secondary: '#F687B3',
      accent: '#FBB6CE',
      background: '#FFFAF0',
      surface: '#FFFFFF',
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: '#2D3748',
      onSurface: '#2D3748',
    ),
    ColorPalette(
      name: 'Emerald',
      primary: '#10B981',
      secondary: '#34D399',
      accent: '#6EE7B7',
      background: '#ECFDF5',
      surface: '#FFFFFF',
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: '#064E3B',
      onSurface: '#064E3B',
    ),
  ];

  // ===== CONFIGURACIONES DE DIFICULTAD =====
  static const Map<DifficultyLevel, Map<String, dynamic>> difficultyConfigs = {
    DifficultyLevel.easy: {
      'name': 'Fácil',
      'emoji': '😊',
      'description': 'Perfecto para comenzar',
      'color': '#10B981', // Green
    },
    DifficultyLevel.medium: {
      'name': 'Medio',
      'emoji': '🤔',
      'description': 'Un pequeño desafío',
      'color': '#F59E0B', // Amber
    },
    DifficultyLevel.hard: {
      'name': 'Difícil',
      'emoji': '😅',
      'description': '¡Para expertos!',
      'color': '#EF4444', // Red
    },
  };

  // ===== CONSEJOS PARA USUARIOS =====
  static const List<String> gameTips = [
    '💡 Consejo: Personaliza las preguntas de trivia en el Panel de Administración para hacer el juego más divertido.',
    '🎨 Tip: Cambia los colores del tema para que coincidan con tu evento.',
    '🧠 Estrategia: En Memory, trata de recordar las posiciones de las cartas que ya viste.',
    '⏱️ Tiempo: En Trivia, responder rápido te da puntos extra.',
    '📸 Personalización: Sube tus propias imágenes para el juego Memory.',
    '🎯 Práctica: Juega en dificultad fácil primero para acostumbrarte a los controles.',
    '🔊 Audio: Activa los sonidos para una mejor experiencia de juego.',
    '📊 Estadísticas: Revisa tus puntuaciones anteriores en el panel de administración.',
    '🎮 Desafío: Intenta mejorar tu tiempo y número de movimientos en cada partida.',
    '👥 Multijugador: Toma turnos con amigos para hacer más divertida la experiencia.',
  ];

  // ===== MENSAJES DE CELEBRACIÓN =====
  static const List<String> celebrationMessages = [
    '¡Increíble! 🎉',
    '¡Fantástico! ⭐',
    '¡Excelente trabajo! 🏆',
    '¡Eres genial! 🌟',
    '¡Perfecto! 💫',
    '¡Impresionante! 🎊',
    '¡Maravilloso! 🎈',
    '¡Extraordinario! 🎁',
    '¡Asombroso! 🎯',
    '¡Brillante! 💎',
  ];

  // ===== MENSAJES DE ÁNIMO =====
  static const List<String> encouragementMessages = [
    '¡No te rindas! 💪',
    '¡Inténtalo de nuevo! 🔄',
    '¡Casi lo tienes! 🎯',
    '¡Sigue así! 🌟',
    '¡Tú puedes! 💫',
    '¡Cada intento cuenta! 🎈',
    '¡La práctica hace al maestro! 🏆',
    '¡Eres increíble! ⭐',
    '¡Sigue jugando! 🎮',
    '¡No te rindas! 🎉',
  ];

  // ===== CONFIGURACIÓN DE SONIDOS =====
  static const Map<String, Map<String, dynamic>> soundConfig = {
    'flip': {
      'frequency': 800,
      'duration': 0.1,
      'volume': 0.3,
    },
    'match': {
      'frequency': 1200,
      'duration': 0.3,
      'volume': 0.5,
    },
    'mismatch': {
      'frequency': 300,
      'duration': 0.5,
      'volume': 0.3,
    },
    'correct': {
      'frequencies': [523, 659, 784],
      'duration': 0.2,
      'volume': 0.6,
    },
    'incorrect': {
      'frequency': 200,
      'duration': 0.5,
      'volume': 0.4,
    },
    'completion': {
      'frequencies': [523, 659, 784, 1047],
      'duration': 0.3,
      'volume': 0.8,
    },
    'pop': {
      'frequency': 800,
      'duration': 0.1,
      'volume': 0.4,
    },
    'sequence': {
      'frequency': 400,
      'duration': 0.2,
      'volume': 0.3,
    },
    'countdown': {
      'frequency': 600,
      'duration': 0.1,
      'volume': 0.2,
    },
  };

  // ===== SPEED GAMES CONFIGURATION =====
  static const Map<String, Map<String, dynamic>> speedGamesConfig = {
    'balloonPop': {
      'name': 'Explota Globos',
      'emoji': '🎈',
      'description': 'Toca los globos antes de que desaparezcan',
      'duration': 60, // seconds
      'minSpawnTime': 800, // milliseconds
      'maxSpawnTime': 2000,
      'balloonLifetime': 3000,
      'colors': ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD'],
    },
    'sequence': {
      'name': 'Secuencia de Memoria',
      'emoji': '🔢',
      'description': 'Memoriza y repite las secuencias',
      'initialLength': 3,
      'maxLength': 10,
      'showTime': 1000, // milliseconds per item
      'rounds': 5,
    },
    'quickTap': {
      'name': 'Toque Rápido',
      'emoji': '🎯',
      'description': 'Toca el color correcto lo más rápido posible',
      'rounds': 10,
      'timeWindow': 2000, // milliseconds
      'colors': ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD'],
    },
  };

  // ===== ACHIEVEMENTS SYSTEM =====
  static const List<Map<String, dynamic>> achievements = [
    {
      'id': 'first_game',
      'name': 'Primer Juego',
      'description': 'Completa tu primer juego',
      'emoji': '🎮',
      'points': 50,
    },
    {
      'id': 'memory_master',
      'name': 'Maestro de la Memoria',
      'description': 'Completa Memory en dificultad difícil',
      'emoji': '🧠',
      'points': 200,
    },
    {
      'id': 'trivia_expert',
      'name': 'Experto en Trivia',
      'description': 'Responde correctamente 10 preguntas seguidas',
      'emoji': '🎯',
      'points': 150,
    },
    {
      'id': 'speed_demon',
      'name': 'Demonio de la Velocidad',
      'description': 'Obtén más de 100 puntos en juegos de velocidad',
      'emoji': '⚡',
      'points': 180,
    },
    {
      'id': 'perfect_memory',
      'name': 'Memoria Perfecta',
      'description': 'Completa Memory sin errores',
      'emoji': '⭐',
      'points': 300,
    },
    {
      'id': 'time_master',
      'name': 'Maestro del Tiempo',
      'description': 'Completa Memory en menos de 2 minutos',
      'emoji': '⏱️',
      'points': 250,
    },
  ];
}