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
            category: "Poetry & Literature",
            tags: ["classic", "soliloquy", "existential"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Confucian Wisdom",
            content:
                """
                Life is really simple, but we insist on making it complicated.
                It does not matter how slowly you go as long as you do not stop.
                """,
            author: "Confucius",
            category: "Ancient Wisdom",
            tags: ["philosophy", "simplicity", "perseverance"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
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
            category: "Poetry & Literature",
            tags: ["strength", "resilience", "soul"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "FDR Inaugural Address",
            content: "The only thing we have to fear is fear itself.",
            author: "Franklin D. Roosevelt",
            category: "Human Experience",
            tags: ["history", "courage", "fear"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "JFK Inaugural Address",
            content: "Ask not what your country can do for you – ask what you can do for your country.",
            author: "John F. Kennedy",
            category: "Human Experience",
            tags: ["history", "service", "patriotism"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // New Passages
        // Bible
        Passage(
            title: "John 3:16",
            content: "For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.",
            author: "Bible",
            category: "Bible",
            tags: ["faith", "love", "salvation"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Psalm 23:1",
            content: "The Lord is my shepherd; I shall not want.",
            author: "Bible",
            category: "Bible",
            tags: ["trust", "guidance", "comfort"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Proverbs 3:5-6",
            content: "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.",
            author: "Bible",
            category: "Bible",
            tags: ["wisdom", "faith", "direction"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Philosophical
        Passage(
            title: "Socratic Wisdom",
            content: "The only true wisdom is in knowing you know nothing.",
            author: "Socrates",
            category: "Philosophical",
            tags: ["humility", "knowledge"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Existential Freedom",
            content: "Man is condemned to be free; because once thrown into the world, he is responsible for everything he does.",
            author: "Jean-Paul Sartre",
            category: "Philosophical",
            tags: ["freedom", "responsibility"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Childlike Wonder",
            content: "All that is gold does not glitter, not all those who wander are lost; the old that is strong does not wither, deep roots are not reached by the frost.",
            author: "J.R.R. Tolkien",
            category: "Poetry & Literature",
            tags: ["wisdom", "appearance"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Stoic Virtue",
            content: "Waste no more time arguing about what a good man should be. Be one.",
            author: "Marcus Aurelius",
            category: "Ancient Wisdom",
            tags: ["action", "virtue"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "The Art of War",
            content: "The supreme art of war is to subdue the enemy without fighting.",
            author: "Sun Tzu",
            category: "Ancient Wisdom",
            tags: ["strategy", "peace"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "The Wound is the Place",
            content: "The wound is the place where the Light enters you.",
            author: "Rumi",
            category: "Poetry & Literature",
            tags: ["healing", "spirituality"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Scientific Insights
        Passage(
            title: "The Nature of Science",
            content: "The good thing about science is that it's true whether or not you believe in it.",
            author: "Neil deGrasse Tyson",
            category: "Scientific Insights",
            tags: ["truth", "objectivity"],
            isActive: true,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Understanding Fear",
            content: "Nothing in life is to be feared, it is only to be understood. Now is the time to understand more, so that we may fear less.",
            author: "Marie Curie",
            category: "Scientific Insights",
            tags: ["knowledge", "courage"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Mindfulness & Meditation
        Passage(
            title: "Inner Peace",
            content: "Peace comes from within. Do not seek it without.",
            author: "Buddha",
            category: "Mindfulness & Meditation",
            tags: ["serenity", "self-awareness"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Mindful Steps",
            content: "Walk as if you are kissing the Earth with your feet.",
            author: "Thich Nhat Hanh",
            category: "Mindfulness & Meditation",
            tags: ["presence", "connection"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Art & Creativity
        Passage(
            title: "The Artist Within",
            content: "Every child is an artist. The problem is how to remain an artist once he grows up.",
            author: "Pablo Picasso",
            category: "Art & Creativity",
            tags: ["creativity", "potential"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "Painting Dreams",
            content: "I dream my painting, and then I paint my dream.",
            author: "Vincent Van Gogh",
            category: "Art & Creativity",
            tags: ["inspiration", "expression"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Nature & Cosmos
        Passage(
            title: "Understanding Nature",
            content: "Look deep into nature, and then you will understand everything better.",
            author: "Albert Einstein",
            category: "Nature & Cosmos",
            tags: ["observation", "wisdom"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "The Call of the Mountains",
            content: "The mountains are calling and I must go.",
            author: "John Muir",
            category: "Nature & Cosmos",
            tags: ["adventure", "nature-love"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),

        // Human Experience
        Passage(
            title: "Things of the Heart",
            content: "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.",
            author: "Helen Keller",
            category: "Human Experience",
            tags: ["emotion", "beauty"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
        ),
        Passage(
            title: "The Last Freedom",
            content: "Everything can be taken from a man but one thing: the last of the human freedoms—to choose one’s attitude in any given set of circumstances, to choose one’s own way.",
            author: "Viktor Frankl",
            category: "Human Experience",
            tags: ["resilience", "choice", "freedom"],
            isActive: false,
            thumbnailName: "Thumbnail1",
            videoName: "placeholder_video.mp4"
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
