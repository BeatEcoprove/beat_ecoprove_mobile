import 'package:beat_ecoprove/client/game/domain/quiz_question.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class QuizQuestions {
  static const List<QuizQuestion> _pt = [
    QuizQuestion(
      question: "O que significa o 'R' de Reutilizar nos 4R?",
      options: [
        "Reciclar materiais",
        "Usar o produto novamente",
        "Reduzir o consumo",
        "Reparar objetos"
      ],
      correctIndex: 1,
      explanation:
          "Reutilizar significa dar nova vida ao produto sem o transformar.",
    ),
    QuizQuestion(
      question: "Qual é o objetivo da economia circular nos têxteis?",
      options: [
        "Produzir mais roupa barata",
        "Eliminar resíduos mantendo materiais em uso",
        "Exportar roupa usada",
        "Usar apenas algodão"
      ],
      correctIndex: 1,
      explanation:
          "A economia circular visa manter os materiais em ciclo, reduzindo desperdício.",
    ),
    QuizQuestion(
      question:
          "Quantas vezes por semana é considerado sustentável usar uma peça de roupa?",
      options: [
        "1 vez",
        "Apenas em ocasiões especiais",
        "O máximo possível",
        "2 vezes"
      ],
      correctIndex: 2,
      explanation:
          "Maximizar o uso de cada peça reduz o impacto ambiental por utilização.",
    ),
    QuizQuestion(
      question: "O que é 'fast fashion'?",
      options: [
        "Moda de alta qualidade produzida rapidamente",
        "Roupa produzida em grande volume a baixo custo com curto ciclo de vida",
        "Tendências de moda que mudam a cada estação",
        "Plataformas de venda rápida de roupa"
      ],
      correctIndex: 1,
      explanation:
          "Fast fashion caracteriza-se por grande volume, baixo custo e elevado desperdício.",
    ),
    QuizQuestion(
      question: "Reciclar roupa é sempre a melhor opção ambiental?",
      options: [
        "Sim, sempre",
        "Não, reduzir e reutilizar são prioritários",
        "Só se a roupa for de algodão",
        "Depende da cor da roupa"
      ],
      correctIndex: 1,
      explanation: "A hierarquia é: Reduzir > Reutilizar > Reparar > Reciclar.",
    ),
    QuizQuestion(
      question: "Qual o impacto hídrico de produzir uma t-shirt de algodão?",
      options: ["~500 litros", "~100 litros", "~2700 litros", "~50 litros"],
      correctIndex: 2,
      explanation: "Produzir uma t-shirt consome em média 2700 litros de água.",
    ),
    QuizQuestion(
      question: "O que significa 'upcycling'?",
      options: [
        "Reciclar para obter material de menor qualidade",
        "Transformar resíduos em produtos de maior valor",
        "Vender roupa usada online",
        "Lavar roupa a alta temperatura"
      ],
      correctIndex: 1,
      explanation:
          "Upcycling transforma materiais descartados em produtos de maior valor ou qualidade.",
    ),
    QuizQuestion(
      question: "Qual destes materiais tem menor impacto ambiental?",
      options: [
        "Poliéster virgem",
        "Algodão convencional",
        "Algodão orgânico certificado",
        "Nylon"
      ],
      correctIndex: 2,
      explanation:
          "O algodão orgânico certificado usa menos água e sem pesticidas.",
    ),
    QuizQuestion(
      question: "O que é a certificação GOTS nos têxteis?",
      options: [
        "Garante que a roupa é produzida na Europa",
        "Certifica têxteis orgânicos desde a matéria-prima até ao produto final",
        "Indica que a roupa é reciclável",
        "Garante preço justo ao consumidor"
      ],
      correctIndex: 1,
      explanation:
          "GOTS (Global Organic Textile Standard) certifica toda a cadeia de produção orgânica.",
    ),
    QuizQuestion(
      question: "Qual é a forma mais sustentável de lavar roupa?",
      options: [
        "Água quente para desinfetar melhor",
        "Água fria com carga cheia e detergente ecológico",
        "Lavar peça a peça para maior cuidado",
        "Sempre na máquina com programa intensivo"
      ],
      correctIndex: 1,
      explanation:
          "Água fria, carga cheia e detergente ecológico reduzem energia, água e poluição.",
    ),
  ];

  static const List<QuizQuestion> _en = [
    QuizQuestion(
      question: "What does the 'R' of Reuse mean in the 4Rs?",
      options: [
        "Recycle materials",
        "Use the product again",
        "Reduce consumption",
        "Repair objects"
      ],
      correctIndex: 1,
      explanation:
          "Reusing means giving a product a new life without transforming it.",
    ),
    QuizQuestion(
      question: "What is the goal of the circular economy in textiles?",
      options: [
        "Produce cheaper clothing",
        "Eliminate waste by keeping materials in use",
        "Export used clothing",
        "Use only cotton"
      ],
      correctIndex: 1,
      explanation:
          "The circular economy aims to keep materials in cycle, reducing waste.",
    ),
    QuizQuestion(
      question: "How often is it considered sustainable to wear a garment?",
      options: [
        "Once a week",
        "Only on special occasions",
        "As often as possible",
        "Twice a week"
      ],
      correctIndex: 2,
      explanation:
          "Maximising the use of each garment reduces environmental impact per use.",
    ),
    QuizQuestion(
      question: "What is 'fast fashion'?",
      options: [
        "High-quality fashion produced quickly",
        "Clothing produced in high volume at low cost with a short lifecycle",
        "Fashion trends that change each season",
        "Fast online clothing sales platforms"
      ],
      correctIndex: 1,
      explanation:
          "Fast fashion is characterised by high volume, low cost, and significant waste.",
    ),
    QuizQuestion(
      question: "Is recycling clothing always the best environmental option?",
      options: [
        "Yes, always",
        "No, reducing and reusing come first",
        "Only if the garment is cotton",
        "It depends on the colour"
      ],
      correctIndex: 1,
      explanation: "The hierarchy is: Reduce > Reuse > Repair > Recycle.",
    ),
    QuizQuestion(
      question: "What is the water footprint of producing a cotton t-shirt?",
      options: ["~500 litres", "~100 litres", "~2700 litres", "~50 litres"],
      correctIndex: 2,
      explanation:
          "Producing one t-shirt consumes on average 2700 litres of water.",
    ),
    QuizQuestion(
      question: "What does 'upcycling' mean?",
      options: [
        "Recycling into lower quality material",
        "Transforming waste into higher-value products",
        "Selling used clothing online",
        "Washing clothing at high temperature"
      ],
      correctIndex: 1,
      explanation:
          "Upcycling transforms discarded materials into products of higher value or quality.",
    ),
    QuizQuestion(
      question: "Which of these materials has the lowest environmental impact?",
      options: [
        "Virgin polyester",
        "Conventional cotton",
        "Certified organic cotton",
        "Nylon"
      ],
      correctIndex: 2,
      explanation:
          "Certified organic cotton uses less water and no pesticides.",
    ),
    QuizQuestion(
      question: "What is the GOTS certification in textiles?",
      options: [
        "Guarantees clothing is made in Europe",
        "Certifies organic textiles from raw material to final product",
        "Indicates the garment is recyclable",
        "Guarantees fair price for consumers"
      ],
      correctIndex: 1,
      explanation:
          "GOTS (Global Organic Textile Standard) certifies the entire organic production chain.",
    ),
    QuizQuestion(
      question: "What is the most sustainable way to wash clothes?",
      options: [
        "Hot water to disinfect better",
        "Cold water with a full load and eco detergent",
        "Washing each item separately for better care",
        "Always using the intensive machine programme"
      ],
      correctIndex: 1,
      explanation:
          "Cold water, full load, and eco detergent reduce energy, water use, and pollution.",
    ),
  ];

  static List<QuizQuestion> get current {
    final locale = LocaleContext.getCurrentLocaleString();
    return locale.startsWith('pt') ? _pt : _en;
  }
}
