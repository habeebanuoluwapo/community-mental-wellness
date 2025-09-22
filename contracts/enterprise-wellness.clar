;; Enterprise Wellness Management Contract
;; Provides advanced corporate wellness features, AI-driven recommendations, and enterprise analytics

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_ALREADY_EXISTS (err u409))
(define-constant ERR_INVALID_INPUT (err u400))
(define-constant ERR_CAPACITY_EXCEEDED (err u429))
(define-constant ERR_INSUFFICIENT_FUNDS (err u402))

;; Data Variables
(define-data-var next-organization-id uint u1)
(define-data-var next-program-id uint u1)
(define-data-var next-recommendation-id uint u1)
(define-data-var platform-fee-percentage uint u500) ;; 5% in basis points
(define-data-var enterprise-wellness-score uint u0)

;; Data Maps

;; Corporate Organizations
(define-map organizations
  uint
  {
    id: uint,
    admin: principal,
    organization-name: (string-utf8 200),
    industry-type: (string-utf8 100),
    employee-count: uint,
    wellness-budget: uint,
    subscription-tier: (string-utf8 50),
    registration-date: uint,
    is-active: bool,
    compliance-requirements: (list 10 (string-utf8 100)),
    wellness-goals: (list 8 (string-utf8 150)),
    contact-info: (string-utf8 300),
    billing-address: (string-utf8 500),
    tax-id: (string-utf8 50),
    authorized-admins: (list 5 principal),
    privacy-settings: (string-utf8 100),
    data-retention-policy: (string-utf8 200)
  }
)

;; Corporate Wellness Programs
(define-map wellness-programs
  uint
  {
    id: uint,
    organization-id: uint,
    creator: principal,
    program-name: (string-utf8 200),
    program-type: (string-utf8 100),
    description: (string-utf8 1000),
    target-employees: uint,
    duration-weeks: uint,
    start-date: uint,
    end-date: uint,
    budget-allocated: uint,
    participation-rate: uint,
    wellness-categories: (list 8 (string-utf8 100)),
    success-metrics: (list 10 (string-utf8 150)),
    incentive-structure: (string-utf8 300),
    professional-oversight: (optional principal),
    program-status: (string-utf8 50),
    roi-target: uint,
    compliance-level: (string-utf8 50),
    accessibility-features: (list 8 (string-utf8 100)),
    cultural-considerations: (optional (string-utf8 300))
  }
)

;; Employee Wellness Profiles (Privacy-Protected)
(define-map employee-wellness-profiles
  principal
  {
    employee-id: (string-utf8 100),
    organization-id: uint,
    wellness-score: uint,
    participation-level: (string-utf8 50),
    preferred-programs: (list 8 (string-utf8 100)),
    wellness-goals: (list 6 (string-utf8 150)),
    risk-factors: (list 5 (string-utf8 100)),
    intervention-history: (list 15 uint),
    privacy-consent: bool,
    anonymous-participation: bool,
    last-assessment: uint,
    improvement-trend: (string-utf8 50),
    engagement-score: uint,
    support-preferences: (list 8 (string-utf8 100)),
    accommodations-needed: (optional (string-utf8 300)),
    emergency-contacts: (list 2 (string-utf8 200))
  }
)

;; AI-Driven Wellness Recommendations
(define-map wellness-recommendations
  uint
  {
    id: uint,
    target-type: (string-utf8 50), ;; "individual", "organization", "group"
    target-id: (string-utf8 100),
    recommendation-type: (string-utf8 100),
    title: (string-utf8 200),
    description: (string-utf8 800),
    priority-level: uint, ;; 1-5 scale
    confidence-score: uint, ;; 1-100 percentage
    evidence-basis: (string-utf8 500),
    recommended-actions: (list 8 (string-utf8 200)),
    expected-outcomes: (list 5 (string-utf8 150)),
    implementation-timeline: (string-utf8 200),
    resource-requirements: (list 5 (string-utf8 150)),
    success-probability: uint,
    personalization-factors: (list 10 (string-utf8 100)),
    contraindications: (optional (string-utf8 300)),
    follow-up-schedule: (string-utf8 150),
    generated-date: uint,
    expiry-date: uint,
    status: (string-utf8 50),
    feedback-score: (optional uint)
  }
)

;; Enterprise Analytics and Reporting
(define-map wellness-analytics
  { organization-id: uint, metric-type: (string-utf8 100), period: uint }
  {
    metric-value: uint,
    baseline-value: uint,
    improvement-percentage: uint,
    trend-direction: (string-utf8 20),
    statistical-significance: uint,
    sample-size: uint,
    collection-date: uint,
    data-quality-score: uint,
    benchmarking-data: (optional uint),
    actionable-insights: (list 5 (string-utf8 200)),
    recommendations-generated: uint,
    cost-benefit-analysis: (optional (string-utf8 500))
  }
)

;; Wellness Program Outcomes
(define-map program-outcomes
  { program-id: uint, outcome-type: (string-utf8 100) }
  {
    baseline-measurement: uint,
    final-measurement: uint,
    improvement-percentage: uint,
    participants-completed: uint,
    participants-started: uint,
    completion-rate: uint,
    satisfaction-score: uint,
    clinical-significance: bool,
    cost-per-participant: uint,
    roi-achieved: uint,
    sustained-improvement: (optional uint),
    adverse-events: uint,
    dropout-reasons: (list 8 (string-utf8 100)),
    success-factors: (list 8 (string-utf8 150))
  }
)

;; Mental Health Risk Assessment
(define-map risk-assessments
  { employee: principal, assessment-date: uint }
  {
    overall-risk-score: uint,
    risk-categories: (list 8 (string-utf8 100)),
    protective-factors: (list 6 (string-utf8 100)),
    intervention-urgency: (string-utf8 50),
    recommended-level-of-care: (string-utf8 100),
    assessment-tool-used: (string-utf8 100),
    clinician-review: (optional principal),
    follow-up-date: uint,
    confidentiality-level: (string-utf8 50),
    consent-status: bool,
    action-plan: (list 6 (string-utf8 200)),
    referral-recommendations: (list 5 (string-utf8 150))
  }
)

;; Enterprise Integration APIs
(define-map api-integrations
  { organization-id: uint, integration-type: (string-utf8 100) }
  {
    integration-name: (string-utf8 150),
    api-endpoint: (string-utf8 300),
    authentication-method: (string-utf8 100),
    data-sync-frequency: (string-utf8 50),
    last-sync: uint,
    sync-status: (string-utf8 50),
    error-count: uint,
    data-mapping: (string-utf8 500),
    compliance-certification: (string-utf8 100),
    security-audit-date: uint,
    integration-admin: principal
  }
)

;; Read-Only Functions

;; Get organization information
(define-read-only (get-organization (organization-id uint))
  (map-get? organizations organization-id)
)

;; Get wellness program details
(define-read-only (get-wellness-program (program-id uint))
  (map-get? wellness-programs program-id)
)

;; Get employee wellness profile (privacy-protected)
(define-read-only (get-employee-wellness-profile (employee principal))
  (let ((profile (unwrap! (map-get? employee-wellness-profiles employee) (err u404))))
    (if (get privacy-consent profile)
        (ok (some profile))
        (ok none)
    )
  )
)

;; Get AI wellness recommendations
(define-read-only (get-wellness-recommendations (target-id (string-utf8 100)) (limit uint))
  (ok "recommendations-list") ;; Implementation would filter and return top recommendations
)

;; Get organization wellness analytics
(define-read-only (get-wellness-analytics (organization-id uint) (metric-type (string-utf8 100)) (period uint))
  (map-get? wellness-analytics { organization-id: organization-id, metric-type: metric-type, period: period })
)

;; Get program outcomes
(define-read-only (get-program-outcomes (program-id uint) (outcome-type (string-utf8 100)))
  (map-get? program-outcomes { program-id: program-id, outcome-type: outcome-type })
)

;; Calculate organizational wellness ROI
(define-read-only (calculate-wellness-roi (organization-id uint) (period-months uint))
  (let (
    (organization (unwrap! (get-organization organization-id) (err u404)))
    (wellness-budget (get wellness-budget organization))
    (productivity-gain u15) ;; Placeholder calculation
    (healthcare-cost-reduction u12) ;; Placeholder calculation
    (employee-retention-value u8) ;; Placeholder calculation
  )
    (ok {
      investment: wellness-budget,
      returns: (+ productivity-gain healthcare-cost-reduction employee-retention-value),
      roi-percentage: (/ (* (+ productivity-gain healthcare-cost-reduction employee-retention-value) u100) wellness-budget),
      payback-period-months: period-months
    })
  )
)

;; Public Functions

;; Register corporate organization
(define-public (register-organization 
  (organization-name (string-utf8 200))
  (industry-type (string-utf8 100))
  (employee-count uint)
  (wellness-budget uint)
  (subscription-tier (string-utf8 50))
  (compliance-requirements (list 10 (string-utf8 100)))
  (wellness-goals (list 8 (string-utf8 150)))
  (contact-info (string-utf8 300))
  (billing-address (string-utf8 500))
  (tax-id (string-utf8 50))
)
  (let ((organization-id (var-get next-organization-id)))
    (asserts! (> employee-count u0) ERR_INVALID_INPUT)
    (asserts! (> wellness-budget u0) ERR_INVALID_INPUT)
    
    (map-set organizations organization-id {
      id: organization-id,
      admin: tx-sender,
      organization-name: organization-name,
      industry-type: industry-type,
      employee-count: employee-count,
      wellness-budget: wellness-budget,
      subscription-tier: subscription-tier,
      registration-date: block-height,
      is-active: true,
      compliance-requirements: compliance-requirements,
      wellness-goals: wellness-goals,
      contact-info: contact-info,
      billing-address: billing-address,
      tax-id: tax-id,
      authorized-admins: (list tx-sender),
      privacy-settings: u"enterprise-compliant",
      data-retention-policy: u"7-years-minimum"
    })
    
    (var-set next-organization-id (+ organization-id u1))
    (ok { organization-id: organization-id })
  )
)

;; Create corporate wellness program
(define-public (create-wellness-program
  (organization-id uint)
  (program-name (string-utf8 200))
  (program-type (string-utf8 100))
  (description (string-utf8 1000))
  (target-employees uint)
  (duration-weeks uint)
  (budget-allocated uint)
  (wellness-categories (list 8 (string-utf8 100)))
  (success-metrics (list 10 (string-utf8 150)))
  (incentive-structure (string-utf8 300))
  (professional-oversight (optional principal))
)
  (let (
    (program-id (var-get next-program-id))
    (organization (unwrap! (get-organization organization-id) ERR_NOT_FOUND))
  )
    ;; Verify authorization
    (asserts! (is-eq tx-sender (get admin organization)) ERR_NOT_AUTHORIZED)
    (asserts! (get is-active organization) ERR_NOT_AUTHORIZED)
    
    ;; Input validation
    (asserts! (> target-employees u0) ERR_INVALID_INPUT)
    (asserts! (> duration-weeks u0) ERR_INVALID_INPUT)
    (asserts! (<= budget-allocated (get wellness-budget organization)) ERR_INSUFFICIENT_FUNDS)
    
    (map-set wellness-programs program-id {
      id: program-id,
      organization-id: organization-id,
      creator: tx-sender,
      program-name: program-name,
      program-type: program-type,
      description: description,
      target-employees: target-employees,
      duration-weeks: duration-weeks,
      start-date: (+ block-height u1),
      end-date: (+ block-height (* duration-weeks u1008)), ;; Approximate blocks per week
      budget-allocated: budget-allocated,
      participation-rate: u0,
      wellness-categories: wellness-categories,
      success-metrics: success-metrics,
      incentive-structure: incentive-structure,
      professional-oversight: professional-oversight,
      program-status: u"planning",
      roi-target: u150, ;; 150% target ROI
      compliance-level: u"enterprise",
      accessibility-features: (list u"screen-reader-compatible" u"multi-language" u"mobile-optimized"),
      cultural-considerations: none
    })
    
    (var-set next-program-id (+ program-id u1))
    (ok { program-id: program-id })
  )
)

;; Create employee wellness profile
(define-public (create-employee-wellness-profile
  (employee-id (string-utf8 100))
  (organization-id uint)
  (preferred-programs (list 8 (string-utf8 100)))
  (wellness-goals (list 6 (string-utf8 150)))
  (privacy-consent bool)
  (anonymous-participation bool)
  (support-preferences (list 8 (string-utf8 100)))
  (accommodations-needed (optional (string-utf8 300)))
  (emergency-contacts (list 2 (string-utf8 200)))
)
  (let ((organization (unwrap! (get-organization organization-id) ERR_NOT_FOUND)))
    ;; Verify organization is active
    (asserts! (get is-active organization) ERR_NOT_AUTHORIZED)
    
    ;; Prevent duplicate profiles
    (asserts! (is-none (map-get? employee-wellness-profiles tx-sender)) ERR_ALREADY_EXISTS)
    
    (map-set employee-wellness-profiles tx-sender {
      employee-id: employee-id,
      organization-id: organization-id,
      wellness-score: u50, ;; Baseline score
      participation-level: u"new",
      preferred-programs: preferred-programs,
      wellness-goals: wellness-goals,
      risk-factors: (list),
      intervention-history: (list),
      privacy-consent: privacy-consent,
      anonymous-participation: anonymous-participation,
      last-assessment: block-height,
      improvement-trend: u"baseline",
      engagement-score: u0,
      support-preferences: support-preferences,
      accommodations-needed: accommodations-needed,
      emergency-contacts: emergency-contacts
    })
    
    (ok { employee: tx-sender })
  )
)

;; Generate AI wellness recommendation
(define-public (generate-wellness-recommendation
  (target-type (string-utf8 50))
  (target-id (string-utf8 100))
  (recommendation-type (string-utf8 100))
  (title (string-utf8 200))
  (description (string-utf8 800))
  (priority-level uint)
  (confidence-score uint)
  (evidence-basis (string-utf8 500))
  (recommended-actions (list 8 (string-utf8 200)))
  (expected-outcomes (list 5 (string-utf8 150)))
)
  (let ((recommendation-id (var-get next-recommendation-id)))
    ;; Input validation
    (asserts! (and (>= priority-level u1) (<= priority-level u5)) ERR_INVALID_INPUT)
    (asserts! (and (>= confidence-score u1) (<= confidence-score u100)) ERR_INVALID_INPUT)
    
    (map-set wellness-recommendations recommendation-id {
      id: recommendation-id,
      target-type: target-type,
      target-id: target-id,
      recommendation-type: recommendation-type,
      title: title,
      description: description,
      priority-level: priority-level,
      confidence-score: confidence-score,
      evidence-basis: evidence-basis,
      recommended-actions: recommended-actions,
      expected-outcomes: expected-outcomes,
      implementation-timeline: u"2-4 weeks",
      resource-requirements: (list u"time" u"engagement" u"support"),
      success-probability: confidence-score,
      personalization-factors: (list u"individual-history" u"preferences" u"risk-profile"),
      contraindications: none,
      follow-up-schedule: u"weekly-check-in",
      generated-date: block-height,
      expiry-date: (+ block-height u4320), ;; 30 days
      status: u"active",
      feedback-score: none
    })
    
    (var-set next-recommendation-id (+ recommendation-id u1))
    (ok { recommendation-id: recommendation-id })
  )
)

;; Record wellness analytics
(define-public (record-wellness-analytics
  (organization-id uint)
  (metric-type (string-utf8 100))
  (period uint)
  (metric-value uint)
  (baseline-value uint)
  (sample-size uint)
  (data-quality-score uint)
  (actionable-insights (list 5 (string-utf8 200)))
)
  (let (
    (organization (unwrap! (get-organization organization-id) ERR_NOT_FOUND))
    (improvement-percentage (if (> baseline-value u0)
      (/ (* (- metric-value baseline-value) u100) baseline-value)
      u0
    ))
    (trend-direction (if (> metric-value baseline-value) u"improving" u"declining"))
  )
    ;; Verify authorization
    (asserts! (is-eq tx-sender (get admin organization)) ERR_NOT_AUTHORIZED)
    
    ;; Input validation
    (asserts! (and (>= data-quality-score u1) (<= data-quality-score u100)) ERR_INVALID_INPUT)
    (asserts! (> sample-size u0) ERR_INVALID_INPUT)
    
    (map-set wellness-analytics 
      { organization-id: organization-id, metric-type: metric-type, period: period }
      {
        metric-value: metric-value,
        baseline-value: baseline-value,
        improvement-percentage: improvement-percentage,
        trend-direction: trend-direction,
        statistical-significance: (if (> sample-size u30) u95 u80), ;; Simplified calculation
        sample-size: sample-size,
        collection-date: block-height,
        data-quality-score: data-quality-score,
        benchmarking-data: none,
        actionable-insights: actionable-insights,
        recommendations-generated: u0,
        cost-benefit-analysis: none
      }
    )
    
    ;; Update enterprise wellness score
    (var-set enterprise-wellness-score 
      (+ (var-get enterprise-wellness-score) (/ improvement-percentage u10))
    )
    
    (ok { analytics-recorded: true })
  )
)

;; Conduct mental health risk assessment
(define-public (conduct-risk-assessment
  (employee principal)
  (overall-risk-score uint)
  (risk-categories (list 8 (string-utf8 100)))
  (protective-factors (list 6 (string-utf8 100)))
  (intervention-urgency (string-utf8 50))
  (recommended-level-of-care (string-utf8 100))
  (assessment-tool-used (string-utf8 100))
  (action-plan (list 6 (string-utf8 200)))
  (referral-recommendations (list 5 (string-utf8 150)))
)
  (let ((employee-profile (unwrap! (map-get? employee-wellness-profiles employee) ERR_NOT_FOUND)))
    ;; Verify privacy consent
    (asserts! (get privacy-consent employee-profile) ERR_NOT_AUTHORIZED)
    
    ;; Input validation
    (asserts! (and (>= overall-risk-score u0) (<= overall-risk-score u100)) ERR_INVALID_INPUT)
    
    (map-set risk-assessments
      { employee: employee, assessment-date: block-height }
      {
        overall-risk-score: overall-risk-score,
        risk-categories: risk-categories,
        protective-factors: protective-factors,
        intervention-urgency: intervention-urgency,
        recommended-level-of-care: recommended-level-of-care,
        assessment-tool-used: assessment-tool-used,
        clinician-review: none,
        follow-up-date: (+ block-height u1008), ;; One week
        confidentiality-level: u"high",
        consent-status: true,
        action-plan: action-plan,
        referral-recommendations: referral-recommendations
      }
    )
    
    ;; Trigger immediate intervention if high risk
    (if (> overall-risk-score u80)
      (ok { risk-level: u"high", immediate-intervention: true, monitoring-required: false })
      (ok { risk-level: u"manageable", monitoring-required: true, immediate-intervention: false })
    )
  )
)

;; Update program outcomes
(define-public (update-program-outcomes
  (program-id uint)
  (outcome-type (string-utf8 100))
  (final-measurement uint)
  (participants-completed uint)
  (participants-started uint)
  (satisfaction-score uint)
  (cost-per-participant uint)
  (adverse-events uint)
  (success-factors (list 8 (string-utf8 150)))
)
  (let (
    (program (unwrap! (get-wellness-program program-id) ERR_NOT_FOUND))
    (completion-rate (if (> participants-started u0)
      (/ (* participants-completed u100) participants-started)
      u0
    ))
  )
    ;; Verify authorization
    (asserts! (is-eq tx-sender (get creator program)) ERR_NOT_AUTHORIZED)
    
    ;; Get baseline or set default
    (let ((existing-outcome (map-get? program-outcomes { program-id: program-id, outcome-type: outcome-type })))
      (let ((baseline-measurement (match existing-outcome
        outcome (get baseline-measurement outcome)
        u50 ;; Default baseline
      )))
        (let ((improvement-percentage (if (> baseline-measurement u0)
          (/ (* (- final-measurement baseline-measurement) u100) baseline-measurement)
          u0
        )))
          (map-set program-outcomes
            { program-id: program-id, outcome-type: outcome-type }
            {
              baseline-measurement: baseline-measurement,
              final-measurement: final-measurement,
              improvement-percentage: improvement-percentage,
              participants-completed: participants-completed,
              participants-started: participants-started,
              completion-rate: completion-rate,
              satisfaction-score: satisfaction-score,
              clinical-significance: (> improvement-percentage u10),
              cost-per-participant: cost-per-participant,
              roi-achieved: (if (> cost-per-participant u0)
                (/ (* improvement-percentage u100) cost-per-participant)
                u0
              ),
              sustained-improvement: none,
              adverse-events: adverse-events,
              dropout-reasons: (list),
              success-factors: success-factors
            }
          )
        )
      )
    )
    
    (ok { program-id: program-id, outcomes-updated: true })
  )
)

;; Private Functions

;; Calculate personalized wellness score
(define-private (calculate-personalized-wellness-score (employee principal) (factors (list 10 uint)))
  (let ((base-score u50))
    (fold calculate-weighted-factor factors base-score)
  )
)

;; Calculate weighted factor for wellness scoring
(define-private (calculate-weighted-factor (factor uint) (current-score uint))
  (+ current-score (/ factor u10))
)

;; Validate enterprise compliance
(define-private (validate-enterprise-compliance (organization-id uint))
  (match (get-organization organization-id)
    organization (and
      (get is-active organization)
      (> (len (get compliance-requirements organization)) u0)
      (is-eq (get subscription-tier organization) u"enterprise")
    )
    false
  )
)
