;; wellness-registry
;; Contract for mental health practitioner registration, wellness service providers, and community resource management

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u100))
(define-constant err-practitioner-not-found (err u101))
(define-constant err-service-not-found (err u102))
(define-constant err-invalid-specialization (err u103))
(define-constant err-invalid-service-type (err u104))
(define-constant err-already-registered (err u105))
(define-constant err-invalid-verification-level (err u106))
(define-constant err-space-not-found (err u107))
(define-constant err-capacity-exceeded (err u108))
(define-constant err-invalid-privacy-level (err u109))
(define-constant err-insufficient-credentials (err u110))

;; Data Maps
(define-map mental-health-practitioners
  { practitioner: principal }
  {
    name: (string-utf8 100),
    license-type: (string-utf8 50),
    license-number: (string-utf8 50),
    specializations: (list 10 (string-utf8 100)),
    years-experience: uint,
    education-background: (string-utf8 500),
    therapeutic-approaches: (list 8 (string-utf8 100)),
    languages-spoken: (list 5 (string-utf8 50)),
    service-areas: (list 10 (string-utf8 100)),
    availability: (string-utf8 200),
    contact-preferences: (string-utf8 100),
    verification-status: (string-utf8 20),
    verification-level: uint,
    community-rating: uint,
    total-ratings: uint,
    total-sessions: uint,
    registration-date: uint,
    last-active: uint,
    accepts-crisis-calls: bool,
    sliding-scale-fees: bool,
    cultural-competencies: (list 5 (string-utf8 100))
  }
)

(define-map wellness-service-providers
  { provider: principal }
  {
    organization-name: (string-utf8 150),
    service-type: (string-utf8 50),
    services-offered: (list 15 (string-utf8 100)),
    target-demographics: (list 8 (string-utf8 100)),
    accessibility-features: (list 10 (string-utf8 100)),
    location: (string-utf8 200),
    contact-info: (string-utf8 200),
    operating-hours: (string-utf8 150),
    cost-structure: (string-utf8 100),
    insurance-accepted: (list 10 (string-utf8 50)),
    emergency-services: bool,
    crisis-intervention: bool,
    community-rating: uint,
    total-ratings: uint,
    people-served: uint,
    registration-date: uint,
    verification-status: (string-utf8 20),
    accreditation: (optional (string-utf8 100)),
    website: (optional (string-utf8 200)),
    social-media: (optional (string-utf8 200))
  }
)

(define-map community-wellness-resources
  { resource-id: uint }
  {
    resource-title: (string-utf8 200),
    resource-type: (string-utf8 50),
    description: (string-utf8 1000),
    content-hash: (optional (string-utf8 64)),
    creator: principal,
    target-audience: (list 5 (string-utf8 100)),
    wellness-categories: (list 8 (string-utf8 100)),
    difficulty-level: uint,
    estimated-duration: (optional uint),
    accessibility-notes: (optional (string-utf8 300)),
    trigger-warnings: (optional (string-utf8 200)),
    professional-review: bool,
    reviewer: (optional principal),
    evidence-based: bool,
    creation-date: uint,
    last-updated: uint,
    usage-count: uint,
    helpful-votes: uint,
    total-votes: uint,
    privacy-level: (string-utf8 20),
    languages-available: (list 3 (string-utf8 50))
  }
)

(define-map safe-spaces
  { space-id: uint }
  {
    space-name: (string-utf8 100),
    facilitator: principal,
    space-type: (string-utf8 50),
    description: (string-utf8 800),
    guidelines: (string-utf8 500),
    focus-areas: (list 10 (string-utf8 100)),
    meeting-schedule: (string-utf8 150),
    location-type: (string-utf8 30),
    location-details: (optional (string-utf8 200)),
    max-capacity: uint,
    current-members: uint,
    member-list: (list 50 principal),
    privacy-level: (string-utf8 20),
    entry-requirements: (optional (string-utf8 300)),
    moderation-style: (string-utf8 50),
    crisis-protocols: (string-utf8 300),
    creation-date: uint,
    last-activity: uint,
    space-rating: uint,
    rating-count: uint,
    space-status: (string-utf8 20),
    professional-oversight: bool
  }
)

(define-map practitioner-specialties
  { specialty: (string-utf8 100) }
  {
    practitioners: (list 100 principal),
    description: (string-utf8 500),
    related-conditions: (list 10 (string-utf8 100)),
    typical-approaches: (list 5 (string-utf8 100)),
    specialty-rating: uint
  }
)

(define-map wellness-directories
  { directory-id: uint }
  {
    directory-name: (string-utf8 150),
    curator: principal,
    category: (string-utf8 50),
    description: (string-utf8 500),
    included-resources: (list 200 uint),
    practitioner-list: (list 100 principal),
    service-providers: (list 50 principal),
    target-community: (string-utf8 100),
    last-updated: uint,
    directory-rating: uint,
    usage-stats: uint,
    is-public: bool,
    verification-required: bool
  }
)

(define-map crisis-response-network
  { responder: principal }
  {
    responder-type: (string-utf8 30),
    availability-status: (string-utf8 20),
    crisis-specialties: (list 8 (string-utf8 100)),
    response-time: uint,
    contact-methods: (list 5 (string-utf8 50)),
    backup-contacts: (list 3 principal),
    certification-level: uint,
    active-cases: uint,
    max-cases: uint,
    last-response: uint,
    response-rating: uint,
    total-responses: uint,
    emergency-only: bool
  }
)

;; Data Variables
(define-data-var next-resource-id uint u1)
(define-data-var next-space-id uint u1)
(define-data-var next-directory-id uint u1)
(define-data-var total-practitioners uint u0)
(define-data-var total-service-providers uint u0)
(define-data-var total-resources uint u0)
(define-data-var total-safe-spaces uint u0)
(define-data-var community-wellness-score uint u0)
(define-data-var crisis-response-active bool false)

;; Private Functions
(define-private (is-valid-license-type (license-type (string-utf8 50)))
  (or (is-eq license-type u"licensed-therapist")
      (is-eq license-type u"clinical-psychologist")
      (is-eq license-type u"psychiatrist")
      (is-eq license-type u"clinical-social-worker")
      (is-eq license-type u"marriage-family-therapist")
      (is-eq license-type u"addiction-counselor")
      (is-eq license-type u"peer-support-specialist")
      (is-eq license-type u"wellness-coach")
      (is-eq license-type u"community-health-worker")
      (is-eq license-type u"other-certified"))
)

(define-private (is-valid-service-type (service-type (string-utf8 50)))
  (or (is-eq service-type u"mental-health-clinic")
      (is-eq service-type u"community-center")
      (is-eq service-type u"crisis-center")
      (is-eq service-type u"support-group-organization")
      (is-eq service-type u"wellness-center")
      (is-eq service-type u"telehealth-platform")
      (is-eq service-type u"educational-institution")
      (is-eq service-type u"peer-support-network")
      (is-eq service-type u"advocacy-organization")
      (is-eq service-type u"emergency-services"))
)

(define-private (is-valid-resource-type (resource-type (string-utf8 50)))
  (or (is-eq resource-type u"educational-article")
      (is-eq resource-type u"guided-meditation")
      (is-eq resource-type u"breathing-exercise")
      (is-eq resource-type u"coping-strategy")
      (is-eq resource-type u"crisis-plan")
      (is-eq resource-type u"self-assessment")
      (is-eq resource-type u"video-resource")
      (is-eq resource-type u"audio-guide")
      (is-eq resource-type u"interactive-tool")
      (is-eq resource-type u"workbook")
      (is-eq resource-type u"emergency-contacts")
      (is-eq resource-type u"support-directory"))
)

(define-private (is-valid-privacy-level (level (string-utf8 20)))
  (or (is-eq level u"public")
      (is-eq level u"community")
      (is-eq level u"members-only")
      (is-eq level u"private")
      (is-eq level u"anonymous"))
)

(define-private (calculate-wellness-score (participant principal))
  ;; Simplified wellness scoring - in practice would be more sophisticated
  (let
    (
      (practitioner-info (map-get? mental-health-practitioners { practitioner: participant }))
    )
    (if (is-some practitioner-info)
      (let
        (
          (info (unwrap-panic practitioner-info))
          (experience (get years-experience info))
          (rating (get community-rating info))
          (sessions (get total-sessions info))
        )
        (+ (* experience u5) (* rating u10) (* sessions u2))
      )
      u0
    )
  )
)

;; Public Functions
(define-public (register-mental-health-practitioner
    (name (string-utf8 100))
    (license-type (string-utf8 50))
    (license-number (string-utf8 50))
    (specializations (list 10 (string-utf8 100)))
    (years-experience uint)
    (education-background (string-utf8 500))
    (therapeutic-approaches (list 8 (string-utf8 100)))
    (languages-spoken (list 5 (string-utf8 50)))
    (service-areas (list 10 (string-utf8 100)))
    (availability (string-utf8 200))
    (contact-preferences (string-utf8 100))
    (accepts-crisis-calls bool)
    (sliding-scale-fees bool)
    (cultural-competencies (list 5 (string-utf8 100)))
  )
  (begin
    (asserts! (is-none (map-get? mental-health-practitioners { practitioner: tx-sender })) err-already-registered)
    (asserts! (is-valid-license-type license-type) err-invalid-specialization)
    
    (map-set mental-health-practitioners
      { practitioner: tx-sender }
      {
        name: name,
        license-type: license-type,
        license-number: license-number,
        specializations: specializations,
        years-experience: years-experience,
        education-background: education-background,
        therapeutic-approaches: therapeutic-approaches,
        languages-spoken: languages-spoken,
        service-areas: service-areas,
        availability: availability,
        contact-preferences: contact-preferences,
        verification-status: u"pending",
        verification-level: u0,
        community-rating: u0,
        total-ratings: u0,
        total-sessions: u0,
        registration-date: block-height,
        last-active: block-height,
        accepts-crisis-calls: accepts-crisis-calls,
        sliding-scale-fees: sliding-scale-fees,
        cultural-competencies: cultural-competencies
      }
    )
    
    (var-set total-practitioners (+ (var-get total-practitioners) u1))
    (ok true)
  )
)

(define-public (register-wellness-service-provider
    (organization-name (string-utf8 150))
    (service-type (string-utf8 50))
    (services-offered (list 15 (string-utf8 100)))
    (target-demographics (list 8 (string-utf8 100)))
    (accessibility-features (list 10 (string-utf8 100)))
    (location (string-utf8 200))
    (contact-info (string-utf8 200))
    (operating-hours (string-utf8 150))
    (cost-structure (string-utf8 100))
    (insurance-accepted (list 10 (string-utf8 50)))
    (emergency-services bool)
    (crisis-intervention bool)
    (accreditation (optional (string-utf8 100)))
    (website (optional (string-utf8 200)))
    (social-media (optional (string-utf8 200)))
  )
  (begin
    (asserts! (is-none (map-get? wellness-service-providers { provider: tx-sender })) err-already-registered)
    (asserts! (is-valid-service-type service-type) err-invalid-service-type)
    
    (map-set wellness-service-providers
      { provider: tx-sender }
      {
        organization-name: organization-name,
        service-type: service-type,
        services-offered: services-offered,
        target-demographics: target-demographics,
        accessibility-features: accessibility-features,
        location: location,
        contact-info: contact-info,
        operating-hours: operating-hours,
        cost-structure: cost-structure,
        insurance-accepted: insurance-accepted,
        emergency-services: emergency-services,
        crisis-intervention: crisis-intervention,
        community-rating: u0,
        total-ratings: u0,
        people-served: u0,
        registration-date: block-height,
        verification-status: u"pending",
        accreditation: accreditation,
        website: website,
        social-media: social-media
      }
    )
    
    (var-set total-service-providers (+ (var-get total-service-providers) u1))
    (ok true)
  )
)

(define-public (create-wellness-resource
    (resource-title (string-utf8 200))
    (resource-type (string-utf8 50))
    (description (string-utf8 1000))
    (content-hash (optional (string-utf8 64)))
    (target-audience (list 5 (string-utf8 100)))
    (wellness-categories (list 8 (string-utf8 100)))
    (difficulty-level uint)
    (estimated-duration (optional uint))
    (accessibility-notes (optional (string-utf8 300)))
    (trigger-warnings (optional (string-utf8 200)))
    (privacy-level (string-utf8 20))
    (languages-available (list 3 (string-utf8 50)))
  )
  (let
    (
      (resource-id (var-get next-resource-id))
    )
    (asserts! (is-valid-resource-type resource-type) err-invalid-service-type)
    (asserts! (is-valid-privacy-level privacy-level) err-invalid-privacy-level)
    (asserts! (and (>= difficulty-level u1) (<= difficulty-level u5)) (err u111))
    
    (map-set community-wellness-resources
      { resource-id: resource-id }
      {
        resource-title: resource-title,
        resource-type: resource-type,
        description: description,
        content-hash: content-hash,
        creator: tx-sender,
        target-audience: target-audience,
        wellness-categories: wellness-categories,
        difficulty-level: difficulty-level,
        estimated-duration: estimated-duration,
        accessibility-notes: accessibility-notes,
        trigger-warnings: trigger-warnings,
        professional-review: false,
        reviewer: none,
        evidence-based: false,
        creation-date: block-height,
        last-updated: block-height,
        usage-count: u0,
        helpful-votes: u0,
        total-votes: u0,
        privacy-level: privacy-level,
        languages-available: languages-available
      }
    )
    
    (var-set next-resource-id (+ resource-id u1))
    (var-set total-resources (+ (var-get total-resources) u1))
    
    (ok resource-id)
  )
)

(define-public (create-safe-space
    (space-name (string-utf8 100))
    (space-type (string-utf8 50))
    (description (string-utf8 800))
    (guidelines (string-utf8 500))
    (focus-areas (list 10 (string-utf8 100)))
    (meeting-schedule (string-utf8 150))
    (location-type (string-utf8 30))
    (location-details (optional (string-utf8 200)))
    (max-capacity uint)
    (privacy-level (string-utf8 20))
    (entry-requirements (optional (string-utf8 300)))
    (moderation-style (string-utf8 50))
    (crisis-protocols (string-utf8 300))
    (professional-oversight bool)
  )
  (let
    (
      (space-id (var-get next-space-id))
      (practitioner-info (map-get? mental-health-practitioners { practitioner: tx-sender }))
    )
    (asserts! (is-valid-privacy-level privacy-level) err-invalid-privacy-level)
    (asserts! (> max-capacity u0) err-capacity-exceeded)
    
    ;; Require verification for professional oversight spaces
    (if professional-oversight
      (asserts! (is-some practitioner-info) err-insufficient-credentials)
      true
    )
    
    (map-set safe-spaces
      { space-id: space-id }
      {
        space-name: space-name,
        facilitator: tx-sender,
        space-type: space-type,
        description: description,
        guidelines: guidelines,
        focus-areas: focus-areas,
        meeting-schedule: meeting-schedule,
        location-type: location-type,
        location-details: location-details,
        max-capacity: max-capacity,
        current-members: u1,
        member-list: (list tx-sender),
        privacy-level: privacy-level,
        entry-requirements: entry-requirements,
        moderation-style: moderation-style,
        crisis-protocols: crisis-protocols,
        creation-date: block-height,
        last-activity: block-height,
        space-rating: u0,
        rating-count: u0,
        space-status: u"active",
        professional-oversight: professional-oversight
      }
    )
    
    (var-set next-space-id (+ space-id u1))
    (var-set total-safe-spaces (+ (var-get total-safe-spaces) u1))
    
    (ok space-id)
  )
)

(define-public (join-safe-space (space-id uint))
  (let
    (
      (space (unwrap! (map-get? safe-spaces { space-id: space-id }) err-space-not-found))
      (current-members (get current-members space))
      (member-list (get member-list space))
    )
    (asserts! (< current-members (get max-capacity space)) err-capacity-exceeded)
    (asserts! (not (is-some (index-of member-list tx-sender))) (err u112))
    
    (map-set safe-spaces
      { space-id: space-id }
      (merge space {
        current-members: (+ current-members u1),
        member-list: (unwrap! (as-max-len? (append member-list tx-sender) u50) (err u113)),
        last-activity: block-height
      })
    )
    
    (ok true)
  )
)

(define-public (rate-practitioner
    (practitioner principal)
    (rating uint)
  )
  (let
    (
      (practitioner-info (unwrap! (map-get? mental-health-practitioners { practitioner: practitioner }) err-practitioner-not-found))
      (current-rating (get community-rating practitioner-info))
      (total-ratings (get total-ratings practitioner-info))
      (new-total-ratings (+ total-ratings u1))
      (new-rating (/ (+ (* current-rating total-ratings) rating) new-total-ratings))
    )
    (asserts! (and (>= rating u1) (<= rating u5)) (err u114))
    
    (map-set mental-health-practitioners
      { practitioner: practitioner }
      (merge practitioner-info {
        community-rating: new-rating,
        total-ratings: new-total-ratings
      })
    )
    
    ;; Update community wellness score
    (var-set community-wellness-score 
      (+ (var-get community-wellness-score) (calculate-wellness-score practitioner))
    )
    
    (ok true)
  )
)

(define-public (verify-practitioner
    (practitioner principal)
    (verification-level uint)
  )
  (let
    (
      (practitioner-info (unwrap! (map-get? mental-health-practitioners { practitioner: practitioner }) err-practitioner-not-found))
    )
    (asserts! (is-eq tx-sender contract-owner) err-unauthorized)
    (asserts! (and (>= verification-level u1) (<= verification-level u5)) err-invalid-verification-level)
    
    (map-set mental-health-practitioners
      { practitioner: practitioner }
      (merge practitioner-info {
        verification-status: u"verified",
        verification-level: verification-level
      })
    )
    
    (ok true)
  )
)

(define-public (activate-crisis-response)
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-unauthorized)
    (var-set crisis-response-active true)
    (ok true)
  )
)

;; Read Functions
(define-read-only (get-practitioner (practitioner principal))
  (map-get? mental-health-practitioners { practitioner: practitioner })
)

(define-read-only (get-service-provider (provider principal))
  (map-get? wellness-service-providers { provider: provider })
)

(define-read-only (get-wellness-resource (resource-id uint))
  (map-get? community-wellness-resources { resource-id: resource-id })
)

(define-read-only (get-safe-space (space-id uint))
  (map-get? safe-spaces { space-id: space-id })
)

(define-read-only (get-crisis-responder (responder principal))
  (map-get? crisis-response-network { responder: responder })
)

(define-read-only (get-wellness-stats)
  {
    total-practitioners: (var-get total-practitioners),
    total-service-providers: (var-get total-service-providers),
    total-resources: (var-get total-resources),
    total-safe-spaces: (var-get total-safe-spaces),
    community-wellness-score: (var-get community-wellness-score),
    crisis-response-active: (var-get crisis-response-active),
    next-resource-id: (var-get next-resource-id),
    next-space-id: (var-get next-space-id)
  }
)

