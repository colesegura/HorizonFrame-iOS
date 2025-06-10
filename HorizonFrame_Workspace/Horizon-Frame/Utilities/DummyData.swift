import Foundation

struct DummyData {
    static let passages: [Passage] = [
        // Existing Passages Updated with Categories
        Passage(
            title: "Hamlet's Soliloquy",
            content:
                """
                To be, or not to be, that is the question:
                Whether 'tis nobler in the mind to suffer
                The slings and arrows of outrageous fortune,
                Or to take arms against a sea of troubles
                And by opposing end them.
                """,
            author: "William Shakespeare",
            category: "Poetry & Literature"
        ),
        Passage(
            title: "Confucian Wisdom",
            content:
                """
                Life is really simple, but we insist on making it complicated.
                It does not matter how slowly you go as long as you do not stop.
                """,
            author: "Confucius",
            category: "Ancient Wisdom"
        ),
        Passage(
            title: "Invictus (Excerpt)",
            content:
                """
                Out of the night that covers me,
                Black as the pit from pole to pole,
                I thank whatever gods may be
                For my unconquerable soul.
                """,
            author: "W.E. Henley",
            category: "Poetry & Literature"
        ),
        Passage(
            title: "FDR Inaugural Address",
            content: "The only thing we have to fear is fear itself.",
            author: "Franklin D. Roosevelt",
            category: "Human Experience"
        ),
        Passage(
            title: "JFK Inaugural Address",
            content: "Ask not what your country can do for you – ask what you can do for your country.",
            author: "John F. Kennedy",
            category: "Human Experience"
        ),

        // New Passages
        // Bible
        Passage(
            title: "John 3:16",
            content: "For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.",
            author: "Bible",
            category: "Bible"
        ),
        Passage(
            title: "Psalm 23:1",
            content: "The Lord is my shepherd; I shall not want.",
            author: "Bible",
            category: "Bible"
        ),
        Passage(
            title: "Proverbs 3:5-6",
            content: "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.",
            author: "Bible",
            category: "Bible"
        ),

        // Philosophical
        Passage(
            title: "Socratic Wisdom",
            content: "The only true wisdom is in knowing you know nothing.",
            author: "Socrates",
            category: "Philosophical"
        ),
        Passage(
            title: "Existential Freedom",
            content: "Man is condemned to be free; because once thrown into the world, he is responsible for everything he does.",
            author: "Jean-Paul Sartre",
            category: "Philosophical"
        ),
        Passage(
            title: "Childlike Wonder",
            content: "We can easily forgive a child who is afraid of the dark; the real tragedy of life is when men are afraid of the light.",
            author: "Plato",
            category: "Philosophical"
        ),

        // Ancient Wisdom
        Passage(
            title: "The Journey Begins",
            content: "The journey of a thousand miles begins with a single step.",
            author: "Lao Tzu",
            category: "Ancient Wisdom"
        ),
        Passage(
            title: "Be Good",
            content: "Waste no more time arguing about what a good man should be. Be one.",
            author: "Marcus Aurelius",
            category: "Ancient Wisdom"
        ),
        Passage(
            title: "The Art of War",
            content: "The supreme art of war is to subdue the enemy without fighting.",
            author: "Sun Tzu",
            category: "Ancient Wisdom"
        ),

        // Poetry & Literature
        Passage(
            title: "The Road Not Taken (Excerpt)",
            content: "Two roads diverged in a wood, and I— I took the one less traveled by, And that has made all the difference.",
            author: "Robert Frost",
            category: "Poetry & Literature"
        ),
        Passage(
            title: "Still I Rise (Excerpt)",
            content: "You may shoot me with your words, You may cut me with your eyes, You may kill me with your hatefulness, But still, like air, I’ll rise.",
            author: "Maya Angelou",
            category: "Poetry & Literature"
        ),
        Passage(
            title: "The Light Within",
            content: "The wound is the place where the Light enters you.",
            author: "Rumi",
            category: "Poetry & Literature"
        ),

        // Scientific Insights
        Passage(
            title: "The Nature of Science",
            content: "The good thing about science is that it's true whether or not you believe in it.",
            author: "Neil deGrasse Tyson",
            category: "Scientific Insights"
        ),
        Passage(
            title: "Cosmic Wonder",
            content: "Somewhere, something incredible is waiting to be known.",
            author: "Carl Sagan",
            category: "Scientific Insights"
        ),
        Passage(
            title: "Understanding Fear",
            content: "Nothing in life is to be feared, it is only to be understood. Now is the time to understand more, so that we may fear less.",
            author: "Marie Curie",
            category: "Scientific Insights"
        ),

        // Mindfulness & Meditation
        Passage(
            title: "Inner Peace",
            content: "Peace comes from within. Do not seek it without.",
            author: "Buddha",
            category: "Mindfulness & Meditation"
        ),
        Passage(
            title: "Mindful Steps",
            content: "Walk as if you are kissing the Earth with your feet.",
            author: "Thich Nhat Hanh",
            category: "Mindfulness & Meditation"
        ),

        // Art & Creativity
        Passage(
            title: "The Artist Within",
            content: "Every child is an artist. The problem is how to remain an artist once he grows up.",
            author: "Pablo Picasso",
            category: "Art & Creativity"
        ),
        Passage(
            title: "Painting Dreams",
            content: "I dream my painting, and then I paint my dream.",
            author: "Vincent Van Gogh",
            category: "Art & Creativity"
        ),

        // Nature & Cosmos
        Passage(
            title: "Understanding Nature",
            content: "Look deep into nature, and then you will understand everything better.",
            author: "Albert Einstein",
            category: "Nature & Cosmos"
        ),
        Passage(
            title: "The Call of the Mountains",
            content: "The mountains are calling and I must go.",
            author: "John Muir",
            category: "Nature & Cosmos"
        ),

        // Human Experience
        Passage(
            title: "Things of the Heart",
            content: "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.",
            author: "Helen Keller",
            category: "Human Experience"
        ),
        Passage(
            title: "The Last Freedom",
            content: "Everything can be taken from a man but one thing: the last of the human freedoms—to choose one’s attitude in any given set of circumstances, to choose one’s own way.",
            author: "Viktor Frankl",
            category: "Human Experience"
        )
    ]

    static let collections: [Collection] = [
        Collection(title: "Favorites", passages: [
            passages[0], // Hamlet
            passages[1], // Confucius
            passages[3]  // FDR
        ]),
        Collection(title: "Read Later", passages: [
            passages[2], // Invictus
            passages[4]  // JFK
        ])
    ]

    static let user: UserProfile = {
        // Create a dummy user with the above collections
        UserProfile(name: "Jane Doe", collections: collections)
    }()

    static let sessions: [Session] = [
        Session(title: "Hamlet Alignment",   passage: passages[0], date: Date(), isDailyPractice: true),
        Session(title: "Invictus Alignment", passage: passages[2], date: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isDailyPractice: true),
        Session(title: "Confucius Alignment", passage: passages[1], date: nil, isDailyPractice: false)
    ]
}

