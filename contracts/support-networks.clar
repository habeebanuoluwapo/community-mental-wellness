;; support-networks
;; Contract for peer support groups, anonymous matching, crisis support networks, and community wellness check-ins

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u200))
(define-constant err-group-not-found (err u201))
(define-constant err-member-not-found (err u202))
(define-constant err-invalid-support-type (err u203))
(define-constant err-invalid-crisis-level (err u204))
(define-constant err-already-member (err u205))
(define-constant err-capacity-exceeded (err u206))
(define-constant err-invalid-privacy-setting (err u207))
(define-constant err-insufficient-permissions (err u208))
(define-constant err-check-in-not-found (err u209))
(define-constant err-invalid-wellness-score (err u210))
(define-constant err-crisis-active (err u211))

;; Data Maps
(define-map peer-support-groups
  { group-id: uint }
  {
    group-name: (string-utf8 150),
    facilitator: principal,
    co-facilitators: (list 3 principal),
    group-type: (string-utf8 50),
    focus-area: (string-utf8 100),
    description: (string-utf8 800),
    meeting-format: (string-utf8 50),
    meeting-schedule: (string-utf8 200),
    location-type: (string-utf8 30),
    privacy-level: (string-utf8 20),
    max-members: uint,
    current-members: uint,
    member-list: (list 100 principal),
    waiting-list: (list 50 principal),
    group-guidelines: (string-utf8 1000),
    entry-requirements: (optional (string-utf8 500)),
    professional-support: bool,
    crisis-protocols: (string-utf8 400),
    creation-date: uint,
    last-meeting: uint,
    total-meetings: uint,
    group-rating: uint,
    rating-count: uint,
    group-status: (string-utf8 20),
    anonymous-mode: bool,
    age-range: (optional (string-utf8 50)),
    cultural-focus: (optional (string-utf8 100))
  }
)

(define-map support-network-members
  { member: principal }
  {
    member-id: (string-utf8 64),
    preferred-name: (string-utf8 50),
    support-preferences: (list 10 (string-utf8 100)),
    availability-schedule: (string-utf8 200),
    crisis-contact-ok: bool,
    peer-mentor: bool,
    support-experience: (list 8 (string-utf8 100)),
    comfort-topics: (list 15 (string-utf8 100)),
    communication-style: (string-utf8 100),
    joined-groups: (list 20 uint),
    active-connections: (list 30 principal),
    total-support-given: uint,
    total-support-received: uint,
    community-rating: uint,
    total-ratings: uint,
    registration-date: uint,
    last-active: uint,
    wellness-streak: uint,
    privacy-settings: (string-utf8 100),
    emergency-contacts: (list 3 (string-utf8 200)),
    preferred-languages: (list 3 (string-utf8 50))
  }
)

(define-map anonymous-matching-requests
  { request-id: uint }
  {
    requester: principal,
    request-type: (string-utf8 50),
    support-needed: (string-utf8 300),
    urgency-level: uint,
    preferred-demographics: (optional (string-utf8 200)),
    communication-preferences: (list 5 (string-utf8 50)),
    availability-window: (string-utf8 150),
    anonymous-id: (string-utf8 64),
    request-date: uint,
    match-status: (string-utf8 20),
    matched-supporter: (optional principal),
    match-date: (optional uint),
    session-count: uint,
    satisfaction-rating: (optional uint),
    completion-status: (string-utf8 20),
    follow-up-needed: bool,
    crisis-flag: bool
  }
)

(define-map crisis-support-network
  { crisis-id: uint }
  {
    reporting-member: principal,
    crisis-type: (string-utf8 50),
    crisis-level: uint,
    location: (optional (string-utf8 200)),
    description: (string-utf8 500),
    immediate-danger: bool,
    professional-needed: bool,
    responders-notified: (list 10 principal),
    primary-responder: (optional principal),
    backup-responders: (list 5 principal),
    response-status: (string-utf8 20),
    response-time: (optional uint),
    crisis-date: uint,
    resolution-date: (optional uint),
    follow-up-scheduled: bool,
    resources-provided: (list 10 (string-utf8 100)),
    professional-referral: (optional (string-utf8 200)),
    crisis-resolved: bool,
    anonymous-report: bool
  }
)

(define-map wellness-check-ins
  { check-in-id: uint }
  {
    member: principal,
    check-in-date: uint,
    wellness-score: uint,
    mood-rating: uint,
    energy-level: uint,
    stress-level: uint,
    sleep-quality: uint,
    social-connection: uint,
    coping-effectiveness: uint,
    support-needed: bool,
    notes: (optional (string-utf8 400)),
    goal-progress: (optional uint),
    challenges-faced: (optional (string-utf8 300)),
    victories-celebrated: (optional (string-utf8 300)),
    next-goals: (optional (string-utf8 200)),
    professional-flag: bool,
    check-in-streak: uint,
    previous-score: uint,
    improvement-trend: (string-utf8 20),
    community-support-received: bool
  }
)

(define-map mutual-aid-requests
  { aid-request-id: uint }
  {
    requester: principal,
    request-type: (string-utf8 50),
    title: (string-utf8 150),
    description: (string-utf8 600),
    urgency: uint,
    location: (optional (string-utf8 150)),
    resources-needed: (list 10 (string-utf8 100)),
    time-sensitive: bool,
    deadline: (optional uint),
    fulfilled-by: (optional principal),
    fulfillment-status: (string-utf8 20),
    community-response: uint,
    helpers: (list 15 principal),
    creation-date: uint,
    fulfillment-date: (optional uint),
    gratitude-expressed: bool,
    follow-up-needed: bool,
    aid-category: (string-utf8 50),
    privacy-level: (string-utf8 20),
    recurring-need: bool
  }
)

(define-map support-connections
  { connection-id: uint }
  {
    supporter: principal,
    supported: principal,
    connection-type: (string-utf8 50),
    connection-strength: uint,
    start-date: uint,
    last-interaction: uint,
    total-interactions: uint,
    support-sessions: uint,
    mutual-support: bool,
    connection-rating: uint,
    connection-status: (string-utf8 20),
    shared-experiences: (list 8 (string-utf8 100)),
    communication-frequency: (string-utf8 30),
    support-goals: (list 5 (string-utf8 150)),
    goal-achievements: uint,
    crisis-support-given: bool,
    professional-involvement: bool,
    connection-notes: (optional (string-utf8 400)),
    next-check-in: (optional uint),
    boundary-agreements: (optional (string-utf8 300))
  }
)

;; Data Variables
(define-data-var next-group-id uint u1)
(define-data-var next-request-id uint u1)
(define-data-var next-crisis-id uint u1)
(define-data-var next-check-in-id uint u1)
(define-data-var next-aid-request-id uint u1)
(define-data-var next-connection-id uint u1)
(define-data-var total-support-groups uint u0)
(define-data-var total-members uint u0)
(define-data-var total-crisis-responses uint u0)
(define-data-var community-wellness-avg uint u0)
(define-data-var crisis-alert-active bool false)
(define-data-var total-check-ins-today uint u0)

;; Private Functions
(define-private (is-valid-support-type (support-type (string-utf8 50)))
  (or (is-eq support-type u"peer-support")
      (is-eq support-type u"crisis-intervention")
      (is-eq support-type u"grief-support")
      (is-eq support-type u"addiction-recovery")
      (is-eq support-type u"anxiety-depression")
      (is-eq support-type u"trauma-support")
      (is-eq support-type u"family-support")
      (is-eq support-type u"lgbtq-support")
      (is-eq support-type u"chronic-illness")
      (is-eq support-type u"caregiver-support")
      (is-eq support-type u"youth-support")
      (is-eq support-type u"elder-support")
      (is-eq support-type u"general-wellness"))
)

(define-private (is-valid-privacy-setting (setting (string-utf8 20)))
  (or (is-eq setting u"public")
      (is-eq setting u"community")
      (is-eq setting u"members-only")
      (is-eq setting u"anonymous")
      (is-eq setting u"private"))
)

(define-private (is-valid-crisis-level (level uint))
  (and (>= level u1) (<= level u5))
)

(define-private (calculate-connection-strength (supporter principal) (supported principal))
  ;; Calculate connection strength based on interactions and mutual support
  (let
    (
      (supporter-info (map-get? support-network-members { member: supporter }))
      (supported-info (map-get? support-network-members { member: supported }))
    )
    ;; Simplified calculation - in practice would be more sophisticated
    (if (and (is-some supporter-info) (is-some supported-info))
      (+ u50 (* u10 u3)) ;; Base score plus interaction bonus
      u0
    )
  )
)

(define-private (update-community-wellness-average)
  ;; Update the community wellness average based on recent check-ins
  (let
    (
      (current-avg (var-get community-wellness-avg))
      (total-checkins (var-get total-check-ins-today))
    )
    ;; Simplified wellness calculation
    (if (> total-checkins u0)
      (var-set community-wellness-avg (+ current-avg u1))
      true
    )
  )
)

;; Public Functions
(define-public (register-support-network-member
    (member-id (string-utf8 64))
    (preferred-name (string-utf8 50))
    (support-preferences (list 10 (string-utf8 100)))
    (availability-schedule (string-utf8 200))
    (crisis-contact-ok bool)
    (peer-mentor bool)
    (support-experience (list 8 (string-utf8 100)))
    (comfort-topics (list 15 (string-utf8 100)))
    (communication-style (string-utf8 100))
    (privacy-settings (string-utf8 100))
    (emergency-contacts (list 3 (string-utf8 200)))
    (preferred-languages (list 3 (string-utf8 50)))
  )
  (begin
    (asserts! (is-none (map-get? support-network-members { member: tx-sender })) err-already-member)
    
    (map-set support-network-members
      { member: tx-sender }
      {
        member-id: member-id,
        preferred-name: preferred-name,
        support-preferences: support-preferences,
        availability-schedule: availability-schedule,
        crisis-contact-ok: crisis-contact-ok,
        peer-mentor: peer-mentor,
        support-experience: support-experience,
        comfort-topics: comfort-topics,
        communication-style: communication-style,
        joined-groups: (list),
        active-connections: (list),
        total-support-given: u0,
        total-support-received: u0,
        community-rating: u0,
        total-ratings: u0,
        registration-date: block-height,
        last-active: block-height,
        wellness-streak: u0,
        privacy-settings: privacy-settings,
        emergency-contacts: emergency-contacts,
        preferred-languages: preferred-languages
      }
    )
    
    (var-set total-members (+ (var-get total-members) u1))
    (ok true)
  )
)

(define-public (create-peer-support-group
    (group-name (string-utf8 150))
    (group-type (string-utf8 50))
    (focus-area (string-utf8 100))
    (description (string-utf8 800))
    (meeting-format (string-utf8 50))
    (meeting-schedule (string-utf8 200))
    (location-type (string-utf8 30))
    (privacy-level (string-utf8 20))
    (max-members uint)
    (group-guidelines (string-utf8 1000))
    (entry-requirements (optional (string-utf8 500)))
    (professional-support bool)
    (crisis-protocols (string-utf8 400))
    (anonymous-mode bool)
    (age-range (optional (string-utf8 50)))
    (cultural-focus (optional (string-utf8 100)))
  )
  (let
    (
      (group-id (var-get next-group-id))
      (member-info (map-get? support-network-members { member: tx-sender }))
    )
    (asserts! (is-valid-support-type group-type) err-invalid-support-type)
    (asserts! (is-valid-privacy-setting privacy-level) err-invalid-privacy-setting)
    (asserts! (is-some member-info) err-member-not-found)
    (asserts! (> max-members u0) err-capacity-exceeded)
    
    (map-set peer-support-groups
      { group-id: group-id }
      {
        group-name: group-name,
        facilitator: tx-sender,
        co-facilitators: (list),
        group-type: group-type,
        focus-area: focus-area,
        description: description,
        meeting-format: meeting-format,
        meeting-schedule: meeting-schedule,
        location-type: location-type,
        privacy-level: privacy-level,
        max-members: max-members,
        current-members: u1,
        member-list: (list tx-sender),
        waiting-list: (list),
        group-guidelines: group-guidelines,
        entry-requirements: entry-requirements,
        professional-support: professional-support,
        crisis-protocols: crisis-protocols,
        creation-date: block-height,
        last-meeting: u0,
        total-meetings: u0,
        group-rating: u0,
        rating-count: u0,
        group-status: u"active",
        anonymous-mode: anonymous-mode,
        age-range: age-range,
        cultural-focus: cultural-focus
      }
    )
    
    (var-set next-group-id (+ group-id u1))
    (var-set total-support-groups (+ (var-get total-support-groups) u1))
    
    (ok group-id)
  )
)

(define-public (join-support-group (group-id uint))
  (let
    (
      (group (unwrap! (map-get? peer-support-groups { group-id: group-id }) err-group-not-found))
      (member-info (unwrap! (map-get? support-network-members { member: tx-sender }) err-member-not-found))
      (current-members (get current-members group))
      (member-list (get member-list group))
      (joined-groups (get joined-groups member-info))
    )
    (asserts! (< current-members (get max-members group)) err-capacity-exceeded)
    (asserts! (not (is-some (index-of member-list tx-sender))) err-already-member)
    
    ;; Add member to group
    (map-set peer-support-groups
      { group-id: group-id }
      (merge group {
        current-members: (+ current-members u1),
        member-list: (unwrap! (as-max-len? (append member-list tx-sender) u100) (err u212))
      })
    )
    
    ;; Update member's joined groups
    (map-set support-network-members
      { member: tx-sender }
      (merge member-info {
        joined-groups: (unwrap! (as-max-len? (append joined-groups group-id) u20) (err u213)),
        last-active: block-height
      })
    )
    
    (ok true)
  )
)

(define-public (create-anonymous-matching-request
    (request-type (string-utf8 50))
    (support-needed (string-utf8 300))
    (urgency-level uint)
    (preferred-demographics (optional (string-utf8 200)))
    (communication-preferences (list 5 (string-utf8 50)))
    (availability-window (string-utf8 150))
    (crisis-flag bool)
  )
  (let
    (
      (request-id (var-get next-request-id))
      (anonymous-id u"anonymous-request")
    )
    (asserts! (is-valid-support-type request-type) err-invalid-support-type)
    (asserts! (and (>= urgency-level u1) (<= urgency-level u5)) (err u214))
    
    (map-set anonymous-matching-requests
      { request-id: request-id }
      {
        requester: tx-sender,
        request-type: request-type,
        support-needed: support-needed,
        urgency-level: urgency-level,
        preferred-demographics: preferred-demographics,
        communication-preferences: communication-preferences,
        availability-window: availability-window,
        anonymous-id: anonymous-id,
        request-date: block-height,
        match-status: u"pending",
        matched-supporter: none,
        match-date: none,
        session-count: u0,
        satisfaction-rating: none,
        completion-status: u"active",
        follow-up-needed: true,
        crisis-flag: crisis-flag
      }
    )
    
    ;; If crisis flag, activate crisis protocol
    (if crisis-flag
      (var-set crisis-alert-active true)
      true
    )
    
    (var-set next-request-id (+ request-id u1))
    (ok request-id)
  )
)

(define-public (report-crisis
    (crisis-type (string-utf8 50))
    (crisis-level uint)
    (location (optional (string-utf8 200)))
    (description (string-utf8 500))
    (immediate-danger bool)
    (professional-needed bool)
    (anonymous-report bool)
  )
  (let
    (
      (crisis-id (var-get next-crisis-id))
    )
    (asserts! (is-valid-crisis-level crisis-level) err-invalid-crisis-level)
    
    (map-set crisis-support-network
      { crisis-id: crisis-id }
      {
        reporting-member: tx-sender,
        crisis-type: crisis-type,
        crisis-level: crisis-level,
        location: location,
        description: description,
        immediate-danger: immediate-danger,
        professional-needed: professional-needed,
        responders-notified: (list),
        primary-responder: none,
        backup-responders: (list),
        response-status: u"reported",
        response-time: none,
        crisis-date: block-height,
        resolution-date: none,
        follow-up-scheduled: false,
        resources-provided: (list),
        professional-referral: none,
        crisis-resolved: false,
        anonymous-report: anonymous-report
      }
    )
    
    ;; Activate crisis alert
    (var-set crisis-alert-active true)
    (var-set next-crisis-id (+ crisis-id u1))
    (var-set total-crisis-responses (+ (var-get total-crisis-responses) u1))
    
    (ok crisis-id)
  )
)

(define-public (submit-wellness-check-in
    (wellness-score uint)
    (mood-rating uint)
    (energy-level uint)
    (stress-level uint)
    (sleep-quality uint)
    (social-connection uint)
    (coping-effectiveness uint)
    (support-needed bool)
    (notes (optional (string-utf8 400)))
    (goal-progress (optional uint))
    (challenges-faced (optional (string-utf8 300)))
    (victories-celebrated (optional (string-utf8 300)))
    (next-goals (optional (string-utf8 200)))
  )
  (let
    (
      (check-in-id (var-get next-check-in-id))
      (member-info (unwrap! (map-get? support-network-members { member: tx-sender }) err-member-not-found))
      (current-streak (get wellness-streak member-info))
    )
    (asserts! (and (>= wellness-score u1) (<= wellness-score u10)) err-invalid-wellness-score)
    (asserts! (and (>= mood-rating u1) (<= mood-rating u10)) err-invalid-wellness-score)
    
    (map-set wellness-check-ins
      { check-in-id: check-in-id }
      {
        member: tx-sender,
        check-in-date: block-height,
        wellness-score: wellness-score,
        mood-rating: mood-rating,
        energy-level: energy-level,
        stress-level: stress-level,
        sleep-quality: sleep-quality,
        social-connection: social-connection,
        coping-effectiveness: coping-effectiveness,
        support-needed: support-needed,
        notes: notes,
        goal-progress: goal-progress,
        challenges-faced: challenges-faced,
        victories-celebrated: victories-celebrated,
        next-goals: next-goals,
        professional-flag: (< wellness-score u4),
        check-in-streak: (+ current-streak u1),
        previous-score: wellness-score,
        improvement-trend: u"stable",
        community-support-received: false
      }
    )
    
    ;; Update member's wellness streak
    (map-set support-network-members
      { member: tx-sender }
      (merge member-info {
        wellness-streak: (+ current-streak u1),
        last-active: block-height
      })
    )
    
    ;; Update community wellness metrics
    (var-set next-check-in-id (+ check-in-id u1))
    (var-set total-check-ins-today (+ (var-get total-check-ins-today) u1))
    (update-community-wellness-average)
    
    (ok check-in-id)
  )
)

(define-public (create-mutual-aid-request
    (request-type (string-utf8 50))
    (title (string-utf8 150))
    (description (string-utf8 600))
    (urgency uint)
    (location (optional (string-utf8 150)))
    (resources-needed (list 10 (string-utf8 100)))
    (time-sensitive bool)
    (deadline (optional uint))
    (aid-category (string-utf8 50))
    (privacy-level (string-utf8 20))
    (recurring-need bool)
  )
  (let
    (
      (aid-request-id (var-get next-aid-request-id))
    )
    (asserts! (is-valid-privacy-setting privacy-level) err-invalid-privacy-setting)
    (asserts! (and (>= urgency u1) (<= urgency u5)) (err u215))
    
    (map-set mutual-aid-requests
      { aid-request-id: aid-request-id }
      {
        requester: tx-sender,
        request-type: request-type,
        title: title,
        description: description,
        urgency: urgency,
        location: location,
        resources-needed: resources-needed,
        time-sensitive: time-sensitive,
        deadline: deadline,
        fulfilled-by: none,
        fulfillment-status: u"open",
        community-response: u0,
        helpers: (list),
        creation-date: block-height,
        fulfillment-date: none,
        gratitude-expressed: false,
        follow-up-needed: true,
        aid-category: aid-category,
        privacy-level: privacy-level,
        recurring-need: recurring-need
      }
    )
    
    (var-set next-aid-request-id (+ aid-request-id u1))
    (ok aid-request-id)
  )
)

(define-public (create-support-connection
    (supported principal)
    (connection-type (string-utf8 50))
    (support-goals (list 5 (string-utf8 150)))
    (communication-frequency (string-utf8 30))
    (boundary-agreements (optional (string-utf8 300)))
  )
  (let
    (
      (connection-id (var-get next-connection-id))
      (connection-strength (calculate-connection-strength tx-sender supported))
      (supporter-info (unwrap! (map-get? support-network-members { member: tx-sender }) err-member-not-found))
      (supported-info (unwrap! (map-get? support-network-members { member: supported }) err-member-not-found))
    )
    (map-set support-connections
      { connection-id: connection-id }
      {
        supporter: tx-sender,
        supported: supported,
        connection-type: connection-type,
        connection-strength: connection-strength,
        start-date: block-height,
        last-interaction: block-height,
        total-interactions: u0,
        support-sessions: u0,
        mutual-support: false,
        connection-rating: u0,
        connection-status: u"active",
        shared-experiences: (list),
        communication-frequency: communication-frequency,
        support-goals: support-goals,
        goal-achievements: u0,
        crisis-support-given: false,
        professional-involvement: false,
        connection-notes: none,
        next-check-in: none,
        boundary-agreements: boundary-agreements
      }
    )
    
    ;; Update member connection counts
    (map-set support-network-members
      { member: tx-sender }
      (merge supporter-info {
        total-support-given: (+ (get total-support-given supporter-info) u1),
        last-active: block-height
      })
    )
    
    (map-set support-network-members
      { member: supported }
      (merge supported-info {
        total-support-received: (+ (get total-support-received supported-info) u1)
      })
    )
    
    (var-set next-connection-id (+ connection-id u1))
    (ok connection-id)
  )
)

;; Read Functions
(define-read-only (get-support-group (group-id uint))
  (map-get? peer-support-groups { group-id: group-id })
)

(define-read-only (get-network-member (member principal))
  (map-get? support-network-members { member: member })
)

(define-read-only (get-matching-request (request-id uint))
  (map-get? anonymous-matching-requests { request-id: request-id })
)

(define-read-only (get-crisis-report (crisis-id uint))
  (map-get? crisis-support-network { crisis-id: crisis-id })
)

(define-read-only (get-wellness-check-in (check-in-id uint))
  (map-get? wellness-check-ins { check-in-id: check-in-id })
)

(define-read-only (get-mutual-aid-request (aid-request-id uint))
  (map-get? mutual-aid-requests { aid-request-id: aid-request-id })
)

(define-read-only (get-support-connection (connection-id uint))
  (map-get? support-connections { connection-id: connection-id })
)

(define-read-only (get-support-network-stats)
  {
    total-support-groups: (var-get total-support-groups),
    total-members: (var-get total-members),
    total-crisis-responses: (var-get total-crisis-responses),
    community-wellness-avg: (var-get community-wellness-avg),
    crisis-alert-active: (var-get crisis-alert-active),
    total-check-ins-today: (var-get total-check-ins-today),
    next-group-id: (var-get next-group-id),
    next-request-id: (var-get next-request-id),
    next-crisis-id: (var-get next-crisis-id),
    next-connection-id: (var-get next-connection-id)
  }
)

