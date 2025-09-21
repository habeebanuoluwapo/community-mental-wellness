;; mindful-resources
;; Contract for mental health resource library, wellness tracking, meditation sessions, and educational content verification

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u300))
(define-constant err-resource-not-found (err u301))
(define-constant err-session-not-found (err u302))
(define-constant err-invalid-resource-type (err u303))
(define-constant err-invalid-difficulty-level (err u304))
(define-constant err-already-enrolled (err u305))
(define-constant err-capacity-exceeded (err u306))
(define-constant err-invalid-rating (err u307))
(define-constant err-journey-not-found (err u308))
(define-constant err-milestone-not-found (err u309))
(define-constant err-invalid-wellness-metric (err u310))
(define-constant err-content-not-verified (err u311))

;; Data Maps
(define-map mindful-resource-library
  { resource-id: uint }
  {
    title: (string-utf8 200),
    resource-type: (string-utf8 50),
    category: (string-utf8 50),
    description: (string-utf8 1000),
    content-hash: (optional (string-utf8 64)),
    creator: principal,
    difficulty-level: uint,
    duration-minutes: uint,
    target-audience: (list 8 (string-utf8 100)),
    wellness-focus-areas: (list 10 (string-utf8 100)),
    prerequisites: (optional (string-utf8 300)),
    learning-outcomes: (list 8 (string-utf8 150)),
    accessibility-features: (list 5 (string-utf8 100)),
    trigger-warnings: (optional (string-utf8 200)),
    evidence-based: bool,
    professional-reviewed: bool,
    reviewer: (optional principal),
    review-date: (optional uint),
    creation-date: uint,
    last-updated: uint,
    usage-count: uint,
    completion-rate: uint,
    average-rating: uint,
    total-ratings: uint,
    content-status: (string-utf8 20),
    languages-available: (list 5 (string-utf8 50)),
    age-appropriateness: (string-utf8 50)
  }
)

(define-map meditation-sessions
  { session-id: uint }
  {
    session-title: (string-utf8 150),
    facilitator: principal,
    session-type: (string-utf8 50),
    meditation-style: (string-utf8 50),
    description: (string-utf8 600),
    session-date: uint,
    duration-minutes: uint,
    max-participants: uint,
    current-participants: uint,
    participant-list: (list 100 principal),
    session-format: (string-utf8 30),
    location: (optional (string-utf8 150)),
    experience-level: (string-utf8 20),
    focus-intention: (string-utf8 200),
    guided-elements: (list 8 (string-utf8 100)),
    music-soundscape: (optional (string-utf8 100)),
    preparation-notes: (optional (string-utf8 300)),
    follow-up-resources: (list 5 uint),
    session-rating: uint,
    rating-count: uint,
    session-status: (string-utf8 20),
    recording-available: bool,
    community-feedback: (optional (string-utf8 400)),
    mindfulness-techniques: (list 6 (string-utf8 100))
  }
)

(define-map wellness-journeys
  { journey-id: uint }
  {
    journey-name: (string-utf8 150),
    participant: principal,
    journey-type: (string-utf8 50),
    wellness-goals: (list 8 (string-utf8 150)),
    start-date: uint,
    target-completion: uint,
    current-milestone: uint,
    total-milestones: uint,
    milestones-completed: (list 20 uint),
    daily-practices: (list 10 (string-utf8 100)),
    weekly-reflections: (list 12 (string-utf8 300)),
    progress-metrics: (list 8 uint),
    wellness-score-history: (list 30 uint),
    challenges-encountered: (list 15 (string-utf8 200)),
    breakthroughs-achieved: (list 10 (string-utf8 200)),
    support-resources-used: (list 25 uint),
    community-connections: (list 20 principal),
    professional-guidance: (optional principal),
    journey-status: (string-utf8 20),
    completion-percentage: uint,
    last-activity: uint,
    next-milestone-date: (optional uint),
    personal-insights: (optional (string-utf8 500))
  }
)

(define-map wellness-activities
  { activity-id: uint }
  {
    activity-name: (string-utf8 100),
    activity-type: (string-utf8 50),
    participant: principal,
    date-completed: uint,
    duration-minutes: uint,
    intensity-level: uint,
    mood-before: uint,
    mood-after: uint,
    energy-before: uint,
    energy-after: uint,
    stress-before: uint,
    stress-after: uint,
    focus-level: uint,
    enjoyment-rating: uint,
    notes: (optional (string-utf8 400)),
    location: (optional (string-utf8 100)),
    companions: (list 5 principal),
    related-resources: (list 5 uint),
    weather-mood: (optional (string-utf8 50)),
    follow-up-planned: bool,
    habit-streak: uint,
    weekly-frequency: uint,
    personal-best: bool
  }
)

(define-map educational-content
  { content-id: uint }
  {
    content-title: (string-utf8 200),
    content-type: (string-utf8 50),
    topic-category: (string-utf8 50),
    author: principal,
    expert-contributor: (optional principal),
    description: (string-utf8 800),
    content-hash: (string-utf8 64),
    scientific-backing: bool,
    research-citations: (list 10 (string-utf8 200)),
    target-audience: (list 6 (string-utf8 100)),
    reading-time: uint,
    difficulty-level: uint,
    key-takeaways: (list 5 (string-utf8 200)),
    practical-applications: (list 8 (string-utf8 150)),
    related-content: (list 10 uint),
    prerequisite-knowledge: (optional (string-utf8 300)),
    content-warnings: (optional (string-utf8 200)),
    publication-date: uint,
    last-revision: uint,
    peer-reviewed: bool,
    reviewer-credentials: (optional (string-utf8 200)),
    view-count: uint,
    bookmark_count: uint,
    share_count: uint,
    helpfulness_rating: uint,
    total_ratings: uint
  }
)

(define-map community-challenges
  { challenge-id: uint }
  {
    challenge-name: (string-utf8 150),
    organizer: principal,
    challenge-type: (string-utf8 50),
    description: (string-utf8 600),
    wellness-focus: (string-utf8 100),
    duration-days: uint,
    start-date: uint,
    end-date: uint,
    participation-requirements: (list 5 (string-utf8 100)),
    daily-activities: (list 31 (string-utf8 150)),
    weekly-goals: (list 8 (string-utf8 200)),
    participants: (list 200 principal),
    max-participants: uint,
    completion-criteria: (list 5 (string-utf8 150)),
    rewards-system: (optional (string-utf8 200)),
    support-resources: (list 15 uint),
    community-chat: bool,
    progress-tracking: (string-utf8 100),
    challenge-status: (string-utf8 20),
    average-completion: uint,
    participant-feedback: (list 20 (string-utf8 300)),
    success_stories: (list 10 (string-utf8 400))
  }
)

(define-map wellness-milestones
  { milestone-id: uint }
  {
    milestone-name: (string-utf8 100),
    participant: principal,
    milestone-type: (string-utf8 50),
    achievement-date: uint,
    wellness-metric: (string-utf8 50),
    previous-value: uint,
    achieved-value: uint,
    improvement-percentage: uint,
    time-to-achieve: uint,
    supporting-activities: (list 10 uint),
    celebration-method: (optional (string-utf8 200)),
    shared-with-community: bool,
    mentor-acknowledgment: (optional principal),
    next-goal-set: (optional (string-utf8 150)),
    personal-reflection: (optional (string-utf8 400)),
    photo-memory: (optional (string-utf8 64)),
    milestone-category: (string-utf8 50),
    difficulty_overcome: uint,
    support_received: (list 5 principal)
  }
)

;; Data Variables
(define-data-var next-resource-id uint u1)
(define-data-var next-session-id uint u1)
(define-data-var next-journey-id uint u1)
(define-data-var next-activity-id uint u1)
(define-data-var next-content-id uint u1)
(define-data-var next-challenge-id uint u1)
(define-data-var next-milestone-id uint u1)
(define-data-var total-resources uint u0)
(define-data-var total-meditation-sessions uint u0)
(define-data-var total-wellness-journeys uint u0)
(define-data-var community-wellness-score uint u0)
(define-data-var active-challenges uint u0)
(define-data-var daily-active-users uint u0)

;; Private Functions
(define-private (is-valid-resource-type (resource-type (string-utf8 50)))
  (or (is-eq resource-type u"guided-meditation")
      (is-eq resource-type u"breathing-exercise")
      (is-eq resource-type u"mindfulness-practice")
      (is-eq resource-type u"educational-article")
      (is-eq resource-type u"video-tutorial")
      (is-eq resource-type u"audio-guide")
      (is-eq resource-type u"worksheet")
      (is-eq resource-type u"journal-template")
      (is-eq resource-type u"assessment-tool")
      (is-eq resource-type u"crisis-resource")
      (is-eq resource-type u"coping-strategy")
      (is-eq resource-type u"sleep-aid")
      (is-eq resource-type u"stress-relief")
      (is-eq resource-type u"mood-booster"))
)

(define-private (is-valid-difficulty-level (level uint))
  (and (>= level u1) (<= level u5))
)

(define-private (is-valid-wellness-metric (metric uint))
  (and (>= metric u1) (<= metric u10))
)

(define-private (calculate-wellness-improvement (previous uint) (current uint))
  (if (> current previous)
    (/ (* (- current previous) u100) previous)
    u0
  )
)

(define-private (update-community-wellness-score (participant principal) (wellness-change uint))
  (let
    (
      (current-score (var-get community-wellness-score))
    )
    (var-set community-wellness-score (+ current-score wellness-change))
  )
)

;; Public Functions
(define-public (create-mindful-resource
    (title (string-utf8 200))
    (resource-type (string-utf8 50))
    (category (string-utf8 50))
    (description (string-utf8 1000))
    (content-hash (optional (string-utf8 64)))
    (difficulty-level uint)
    (duration-minutes uint)
    (target-audience (list 8 (string-utf8 100)))
    (wellness-focus-areas (list 10 (string-utf8 100)))
    (prerequisites (optional (string-utf8 300)))
    (learning-outcomes (list 8 (string-utf8 150)))
    (accessibility-features (list 5 (string-utf8 100)))
    (trigger-warnings (optional (string-utf8 200)))
    (languages-available (list 5 (string-utf8 50)))
    (age-appropriateness (string-utf8 50))
  )
  (let
    (
      (resource-id (var-get next-resource-id))
    )
    (asserts! (is-valid-resource-type resource-type) err-invalid-resource-type)
    (asserts! (is-valid-difficulty-level difficulty-level) err-invalid-difficulty-level)
    
    (map-set mindful-resource-library
      { resource-id: resource-id }
      {
        title: title,
        resource-type: resource-type,
        category: category,
        description: description,
        content-hash: content-hash,
        creator: tx-sender,
        difficulty-level: difficulty-level,
        duration-minutes: duration-minutes,
        target-audience: target-audience,
        wellness-focus-areas: wellness-focus-areas,
        prerequisites: prerequisites,
        learning-outcomes: learning-outcomes,
        accessibility-features: accessibility-features,
        trigger-warnings: trigger-warnings,
        evidence-based: false,
        professional-reviewed: false,
        reviewer: none,
        review-date: none,
        creation-date: block-height,
        last-updated: block-height,
        usage-count: u0,
        completion-rate: u0,
        average-rating: u0,
        total-ratings: u0,
        content-status: u"draft",
        languages-available: languages-available,
        age-appropriateness: age-appropriateness
      }
    )
    
    (var-set next-resource-id (+ resource-id u1))
    (var-set total-resources (+ (var-get total-resources) u1))
    
    (ok resource-id)
  )
)

(define-public (create-meditation-session
    (session-title (string-utf8 150))
    (session-type (string-utf8 50))
    (meditation-style (string-utf8 50))
    (description (string-utf8 600))
    (session-date uint)
    (duration-minutes uint)
    (max-participants uint)
    (session-format (string-utf8 30))
    (location (optional (string-utf8 150)))
    (experience-level (string-utf8 20))
    (focus-intention (string-utf8 200))
    (guided-elements (list 8 (string-utf8 100)))
    (music-soundscape (optional (string-utf8 100)))
    (preparation-notes (optional (string-utf8 300)))
    (mindfulness-techniques (list 6 (string-utf8 100)))
  )
  (let
    (
      (session-id (var-get next-session-id))
    )
    (map-set meditation-sessions
      { session-id: session-id }
      {
        session-title: session-title,
        facilitator: tx-sender,
        session-type: session-type,
        meditation-style: meditation-style,
        description: description,
        session-date: session-date,
        duration-minutes: duration-minutes,
        max-participants: max-participants,
        current-participants: u0,
        participant-list: (list),
        session-format: session-format,
        location: location,
        experience-level: experience-level,
        focus-intention: focus-intention,
        guided-elements: guided-elements,
        music-soundscape: music-soundscape,
        preparation-notes: preparation-notes,
        follow-up-resources: (list),
        session-rating: u0,
        rating-count: u0,
        session-status: u"scheduled",
        recording-available: false,
        community-feedback: none,
        mindfulness-techniques: mindfulness-techniques
      }
    )
    
    (var-set next-session-id (+ session-id u1))
    (var-set total-meditation-sessions (+ (var-get total-meditation-sessions) u1))
    
    (ok session-id)
  )
)

(define-public (start-wellness-journey
    (journey-name (string-utf8 150))
    (journey-type (string-utf8 50))
    (wellness-goals (list 8 (string-utf8 150)))
    (target-completion uint)
    (total-milestones uint)
    (daily-practices (list 10 (string-utf8 100)))
    (professional-guidance (optional principal))
  )
  (let
    (
      (journey-id (var-get next-journey-id))
    )
    (map-set wellness-journeys
      { journey-id: journey-id }
      {
        journey-name: journey-name,
        participant: tx-sender,
        journey-type: journey-type,
        wellness-goals: wellness-goals,
        start-date: block-height,
        target-completion: target-completion,
        current-milestone: u0,
        total-milestones: total-milestones,
        milestones-completed: (list),
        daily-practices: daily-practices,
        weekly-reflections: (list),
        progress-metrics: (list),
        wellness-score-history: (list),
        challenges-encountered: (list),
        breakthroughs-achieved: (list),
        support-resources-used: (list),
        community-connections: (list),
        professional-guidance: professional-guidance,
        journey-status: u"active",
        completion-percentage: u0,
        last-activity: block-height,
        next-milestone-date: none,
        personal-insights: none
      }
    )
    
    (var-set next-journey-id (+ journey-id u1))
    (var-set total-wellness-journeys (+ (var-get total-wellness-journeys) u1))
    
    (ok journey-id)
  )
)

(define-public (log-wellness-activity
    (activity-name (string-utf8 100))
    (activity-type (string-utf8 50))
    (duration-minutes uint)
    (intensity-level uint)
    (mood-before uint)
    (mood-after uint)
    (energy-before uint)
    (energy-after uint)
    (stress-before uint)
    (stress-after uint)
    (focus-level uint)
    (enjoyment-rating uint)
    (notes (optional (string-utf8 400)))
    (location (optional (string-utf8 100)))
    (companions (list 5 principal))
  )
  (let
    (
      (activity-id (var-get next-activity-id))
      (mood-improvement (calculate-wellness-improvement mood-before mood-after))
    )
    (asserts! (is-valid-wellness-metric mood-before) err-invalid-wellness-metric)
    (asserts! (is-valid-wellness-metric mood-after) err-invalid-wellness-metric)
    (asserts! (is-valid-wellness-metric energy-before) err-invalid-wellness-metric)
    (asserts! (is-valid-wellness-metric energy-after) err-invalid-wellness-metric)
    
    (map-set wellness-activities
      { activity-id: activity-id }
      {
        activity-name: activity-name,
        activity-type: activity-type,
        participant: tx-sender,
        date-completed: block-height,
        duration-minutes: duration-minutes,
        intensity-level: intensity-level,
        mood-before: mood-before,
        mood-after: mood-after,
        energy-before: energy-before,
        energy-after: energy-after,
        stress-before: stress-before,
        stress-after: stress-after,
        focus-level: focus-level,
        enjoyment-rating: enjoyment-rating,
        notes: notes,
        location: location,
        companions: companions,
        related-resources: (list),
        weather-mood: none,
        follow-up-planned: false,
        habit-streak: u1,
        weekly-frequency: u1,
        personal-best: false
      }
    )
    
    ;; Update community wellness score based on improvement
    (update-community-wellness-score tx-sender mood-improvement)
    (var-set next-activity-id (+ activity-id u1))
    (var-set daily-active-users (+ (var-get daily-active-users) u1))
    
    (ok activity-id)
  )
)

(define-public (create-educational-content
    (content-title (string-utf8 200))
    (content-type (string-utf8 50))
    (topic-category (string-utf8 50))
    (description (string-utf8 800))
    (content-hash (string-utf8 64))
    (scientific-backing bool)
    (research-citations (list 10 (string-utf8 200)))
    (target-audience (list 6 (string-utf8 100)))
    (reading-time uint)
    (difficulty-level uint)
    (key-takeaways (list 5 (string-utf8 200)))
    (practical-applications (list 8 (string-utf8 150)))
    (prerequisite-knowledge (optional (string-utf8 300)))
    (content-warnings (optional (string-utf8 200)))
  )
  (let
    (
      (content-id (var-get next-content-id))
    )
    (asserts! (is-valid-difficulty-level difficulty-level) err-invalid-difficulty-level)
    
    (map-set educational-content
      { content-id: content-id }
      {
        content-title: content-title,
        content-type: content-type,
        topic-category: topic-category,
        author: tx-sender,
        expert-contributor: none,
        description: description,
        content-hash: content-hash,
        scientific-backing: scientific-backing,
        research-citations: research-citations,
        target-audience: target-audience,
        reading-time: reading-time,
        difficulty-level: difficulty-level,
        key-takeaways: key-takeaways,
        practical-applications: practical-applications,
        related-content: (list),
        prerequisite-knowledge: prerequisite-knowledge,
        content-warnings: content-warnings,
        publication-date: block-height,
        last-revision: block-height,
        peer-reviewed: false,
        reviewer-credentials: none,
        view-count: u0,
        bookmark_count: u0,
        share_count: u0,
        helpfulness_rating: u0,
        total_ratings: u0
      }
    )
    
    (var-set next-content-id (+ content-id u1))
    (ok content-id)
  )
)

(define-public (create-community-challenge
    (challenge-name (string-utf8 150))
    (challenge-type (string-utf8 50))
    (description (string-utf8 600))
    (wellness-focus (string-utf8 100))
    (duration-days uint)
    (max-participants uint)
    (participation-requirements (list 5 (string-utf8 100)))
    (daily-activities (list 31 (string-utf8 150)))
    (weekly-goals (list 8 (string-utf8 200)))
    (completion-criteria (list 5 (string-utf8 150)))
    (rewards-system (optional (string-utf8 200)))
  )
  (let
    (
      (challenge-id (var-get next-challenge-id))
      (start-date block-height)
      (end-date (+ start-date duration-days))
    )
    (map-set community-challenges
      { challenge-id: challenge-id }
      {
        challenge-name: challenge-name,
        organizer: tx-sender,
        challenge-type: challenge-type,
        description: description,
        wellness-focus: wellness-focus,
        duration-days: duration-days,
        start-date: start-date,
        end-date: end-date,
        participation-requirements: participation-requirements,
        daily-activities: daily-activities,
        weekly-goals: weekly-goals,
        participants: (list),
        max-participants: max-participants,
        completion-criteria: completion-criteria,
        rewards-system: rewards-system,
        support-resources: (list),
        community-chat: true,
        progress-tracking: u"daily-check-ins",
        challenge-status: u"recruiting",
        average-completion: u0,
        participant-feedback: (list),
        success_stories: (list)
      }
    )
    
    (var-set next-challenge-id (+ challenge-id u1))
    (var-set active-challenges (+ (var-get active-challenges) u1))
    
    (ok challenge-id)
  )
)

(define-public (achieve-wellness-milestone
    (milestone-name (string-utf8 100))
    (milestone-type (string-utf8 50))
    (wellness-metric (string-utf8 50))
    (previous-value uint)
    (achieved-value uint)
    (time-to-achieve uint)
    (supporting-activities (list 10 uint))
    (celebration-method (optional (string-utf8 200)))
    (shared-with-community bool)
    (personal-reflection (optional (string-utf8 400)))
    (milestone-category (string-utf8 50))
    (difficulty_overcome uint)
  )
  (let
    (
      (milestone-id (var-get next-milestone-id))
      (improvement-percentage (calculate-wellness-improvement previous-value achieved-value))
    )
    (map-set wellness-milestones
      { milestone-id: milestone-id }
      {
        milestone-name: milestone-name,
        participant: tx-sender,
        milestone-type: milestone-type,
        achievement-date: block-height,
        wellness-metric: wellness-metric,
        previous-value: previous-value,
        achieved-value: achieved-value,
        improvement-percentage: improvement-percentage,
        time-to-achieve: time-to-achieve,
        supporting-activities: supporting-activities,
        celebration-method: celebration-method,
        shared-with-community: shared-with-community,
        mentor-acknowledgment: none,
        next-goal-set: none,
        personal-reflection: personal-reflection,
        photo-memory: none,
        milestone-category: milestone-category,
        difficulty_overcome: difficulty_overcome,
        support_received: (list)
      }
    )
    
    ;; Update community wellness score
    (update-community-wellness-score tx-sender improvement-percentage)
    (var-set next-milestone-id (+ milestone-id u1))
    
    (ok milestone-id)
  )
)

(define-public (join-meditation-session (session-id uint))
  (let
    (
      (session (unwrap! (map-get? meditation-sessions { session-id: session-id }) err-session-not-found))
      (current-participants (get current-participants session))
      (participant-list (get participant-list session))
    )
    (asserts! (< current-participants (get max-participants session)) err-capacity-exceeded)
    (asserts! (not (is-some (index-of participant-list tx-sender))) err-already-enrolled)
    
    (map-set meditation-sessions
      { session-id: session-id }
      (merge session {
        current-participants: (+ current-participants u1),
        participant-list: (unwrap! (as-max-len? (append participant-list tx-sender) u100) (err u312))
      })
    )
    
    (ok true)
  )
)

(define-public (rate-resource
    (resource-id uint)
    (rating uint)
  )
  (let
    (
      (resource (unwrap! (map-get? mindful-resource-library { resource-id: resource-id }) err-resource-not-found))
      (current-rating (get average-rating resource))
      (total-ratings (get total-ratings resource))
      (new-total-ratings (+ total-ratings u1))
      (new-average (/ (+ (* current-rating total-ratings) rating) new-total-ratings))
    )
    (asserts! (and (>= rating u1) (<= rating u5)) err-invalid-rating)
    
    (map-set mindful-resource-library
      { resource-id: resource-id }
      (merge resource {
        average-rating: new-average,
        total-ratings: new-total-ratings
      })
    )
    
    (ok true)
  )
)

;; Read Functions
(define-read-only (get-resource (resource-id uint))
  (map-get? mindful-resource-library { resource-id: resource-id })
)

(define-read-only (get-meditation-session (session-id uint))
  (map-get? meditation-sessions { session-id: session-id })
)

(define-read-only (get-wellness-journey (journey-id uint))
  (map-get? wellness-journeys { journey-id: journey-id })
)

(define-read-only (get-wellness-activity (activity-id uint))
  (map-get? wellness-activities { activity-id: activity-id })
)

(define-read-only (get-educational-content (content-id uint))
  (map-get? educational-content { content-id: content-id })
)

(define-read-only (get-community-challenge (challenge-id uint))
  (map-get? community-challenges { challenge-id: challenge-id })
)

(define-read-only (get-wellness-milestone (milestone-id uint))
  (map-get? wellness-milestones { milestone-id: milestone-id })
)

(define-read-only (get-mindful-resources-stats)
  {
    total-resources: (var-get total-resources),
    total-meditation-sessions: (var-get total-meditation-sessions),
    total-wellness-journeys: (var-get total-wellness-journeys),
    community-wellness-score: (var-get community-wellness-score),
    active-challenges: (var-get active-challenges),
    daily-active-users: (var-get daily-active-users),
    next-resource-id: (var-get next-resource-id),
    next-session-id: (var-get next-session-id),
    next-journey-id: (var-get next-journey-id),
    next-challenge-id: (var-get next-challenge-id)
  }
)

