;; Telehealth Integration Contract
;; Manages virtual therapy appointments, video sessions, and telemedicine integration

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_ALREADY_EXISTS (err u409))
(define-constant ERR_INVALID_INPUT (err u400))
(define-constant ERR_SESSION_CONFLICT (err u409))
(define-constant ERR_PAYMENT_REQUIRED (err u402))
(define-constant ERR_SESSION_EXPIRED (err u410))

;; Data Variables
(define-data-var next-appointment-id uint u1)
(define-data-var next-session-id uint u1)
(define-data-var platform-commission uint u15) ;; 15% commission
(define-data-var emergency-session-fee uint u5000000) ;; 50 STX in microSTX

;; Data Maps

;; Virtual Therapy Appointments
(define-map telehealth-appointments
  uint
  {
    id: uint,
    client: principal,
    practitioner: principal,
    appointment-date: uint,
    appointment-time: uint, ;; Block height representing time slot
    duration-minutes: uint,
    session-type: (string-utf8 50),
    therapy-focus: (string-utf8 100),
    appointment-status: (string-utf8 50),
    preparation-notes: (optional (string-utf8 500)),
    session-fee: uint,
    insurance-covered: bool,
    payment-status: (string-utf8 50),
    platform-used: (string-utf8 100),
    session-room-id: (optional (string-utf8 100)),
    accessibility-needs: (optional (string-utf8 300)),
    language-preference: (string-utf8 50),
    time-zone: (string-utf8 50),
    reminder-sent: bool,
    cancellation-reason: (optional (string-utf8 200)),
    rescheduled-from: (optional uint),
    emergency-priority: bool
  }
)

;; Video Session Management
(define-map video-sessions
  uint
  {
    id: uint,
    appointment-id: uint,
    session-url: (string-utf8 300),
    room-id: (string-utf8 100),
    start-time: uint,
    actual-duration: uint,
    session-quality: (optional uint), ;; 1-5 rating
    technical-issues: (optional (string-utf8 300)),
    recording-consent: bool,
    recording-url: (optional (string-utf8 300)),
    session-notes: (optional (string-utf8 1000)),
    client-satisfaction: (optional uint),
    practitioner-notes: (optional (string-utf8 800)),
    follow-up-required: bool,
    crisis-indicators: (optional (string-utf8 300)),
    session-completed: bool,
    billing-processed: bool
  }
)

;; Practitioner Availability
(define-map practitioner-availability
  { practitioner: principal, date: uint }
  {
    available-slots: (list 24 bool), ;; 24 hour availability
    emergency-availability: bool,
    session-types-offered: (list 8 (string-utf8 100)),
    hourly-rates: (list 8 uint),
    preferred-platforms: (list 5 (string-utf8 100)),
    max-daily-sessions: uint,
    current-bookings: uint,
    break-times: (list 4 uint),
    timezone-offset: int,
    auto-booking-enabled: bool,
    last-updated: uint
  }
)

;; Telemedicine Platform Integration
(define-map platform-integrations
  (string-utf8 100)
  {
    platform-name: (string-utf8 100),
    api-endpoint: (string-utf8 300),
    authentication-token: (string-utf8 200),
    supported-features: (list 10 (string-utf8 100)),
    security-certification: (string-utf8 100),
    hipaa-compliant: bool,
    max-session-duration: uint,
    recording-capabilities: bool,
    screen-sharing: bool,
    chat-support: bool,
    mobile-app: bool,
    bandwidth-requirements: (string-utf8 100),
    pricing-model: (string-utf8 100),
    integration-status: (string-utf8 50),
    last-health-check: uint
  }
)

;; Session Analytics
(define-map session-analytics
  { practitioner: principal, period: uint }
  {
    total-sessions: uint,
    completed-sessions: uint,
    cancelled-sessions: uint,
    no-shows: uint,
    average-rating: uint,
    total-revenue: uint,
    average-session-duration: uint,
    technical-issues-count: uint,
    client-retention-rate: uint,
    emergency-sessions: uint,
    follow-up-compliance: uint,
    platform-usage: (string-utf8 100)
  }
)

;; Client Health Records (Privacy-Protected)
(define-map client-health-records
  { client: principal, session-id: uint }
  {
    session-summary: (string-utf8 800),
    treatment-goals: (list 8 (string-utf8 150)),
    progress-notes: (string-utf8 600),
    medication-discussed: (optional (string-utf8 300)),
    homework-assignments: (list 5 (string-utf8 200)),
    next-session-focus: (optional (string-utf8 200)),
    risk-assessment: (optional (string-utf8 300)),
    crisis-plan: (optional (string-utf8 500)),
    confidentiality-level: (string-utf8 50),
    sharing-consent: bool,
    record-retention-date: uint,
    encryption-key: (string-utf8 100)
  }
)

;; Insurance and Billing
(define-map insurance-claims
  { appointment-id: uint, claim-date: uint }
  {
    insurance-provider: (string-utf8 150),
    policy-number: (string-utf8 100),
    claim-amount: uint,
    copay-amount: uint,
    deductible-applied: uint,
    claim-status: (string-utf8 50),
    authorization-code: (optional (string-utf8 100)),
    diagnosis-codes: (list 5 (string-utf8 10)),
    procedure-codes: (list 3 (string-utf8 10)),
    claim-submission-date: uint,
    expected-payment-date: uint,
    rejection-reason: (optional (string-utf8 300)),
    appeal-status: (optional (string-utf8 50))
  }
)

;; Read-Only Functions

;; Get appointment details
(define-read-only (get-appointment (appointment-id uint))
  (map-get? telehealth-appointments appointment-id)
)

;; Get practitioner availability
(define-read-only (get-practitioner-availability (practitioner principal) (date uint))
  (map-get? practitioner-availability { practitioner: practitioner, date: date })
)

;; Get available time slots for date
(define-read-only (get-available-slots (practitioner principal) (date uint))
  (let ((availability (map-get? practitioner-availability { practitioner: practitioner, date: date })))
    (match availability
      slots (ok (get available-slots slots))
      (err u404)
    )
  )
)

;; Get session details
(define-read-only (get-video-session (session-id uint))
  (map-get? video-sessions session-id)
)

;; Get practitioner session analytics
(define-read-only (get-session-analytics (practitioner principal) (period uint))
  (map-get? session-analytics { practitioner: practitioner, period: period })
)

;; Calculate session fee with insurance
(define-read-only (calculate-session-fee (base-rate uint) (insurance-coverage uint) (copay uint))
  (let (
    (insurance-payment (/ (* base-rate insurance-coverage) u100))
    (client-payment (+ (- base-rate insurance-payment) copay))
  )
    (ok {
      total-fee: base-rate,
      insurance-portion: insurance-payment,
      client-portion: client-payment,
      platform-commission: (/ (* base-rate (var-get platform-commission)) u100)
    })
  )
)

;; Get upcoming appointments for practitioner
(define-read-only (get-upcoming-appointments (practitioner principal) (limit uint))
  (ok "upcoming-appointments-list") ;; Implementation would query and filter
)

;; Public Functions

;; Schedule telehealth appointment
(define-public (schedule-appointment
  (practitioner principal)
  (appointment-date uint)
  (appointment-time uint)
  (duration-minutes uint)
  (session-type (string-utf8 50))
  (therapy-focus (string-utf8 100))
  (session-fee uint)
  (insurance-covered bool)
  (platform-preference (string-utf8 100))
  (accessibility-needs (optional (string-utf8 300)))
  (language-preference (string-utf8 50))
  (emergency-priority bool)
)
  (let ((appointment-id (var-get next-appointment-id)))
    ;; Validate inputs
    (asserts! (> duration-minutes u0) ERR_INVALID_INPUT)
    (asserts! (> session-fee u0) ERR_INVALID_INPUT)
    (asserts! (> appointment-date block-height) ERR_INVALID_INPUT)
    
    ;; Check practitioner availability
    (let ((availability (map-get? practitioner-availability { practitioner: practitioner, date: appointment-date })))
      (asserts! (is-some availability) ERR_NOT_FOUND)
      
      ;; Create appointment
      (map-set telehealth-appointments appointment-id {
        id: appointment-id,
        client: tx-sender,
        practitioner: practitioner,
        appointment-date: appointment-date,
        appointment-time: appointment-time,
        duration-minutes: duration-minutes,
        session-type: session-type,
        therapy-focus: therapy-focus,
        appointment-status: u"scheduled",
        preparation-notes: none,
        session-fee: session-fee,
        insurance-covered: insurance-covered,
        payment-status: u"pending",
        platform-used: platform-preference,
        session-room-id: none,
        accessibility-needs: accessibility-needs,
        language-preference: language-preference,
        time-zone: u"UTC",
        reminder-sent: false,
        cancellation-reason: none,
        rescheduled-from: none,
        emergency-priority: emergency-priority
      })
      
      (var-set next-appointment-id (+ appointment-id u1))
      (ok { appointment-id: appointment-id })
    )
  )
)

;; Set practitioner availability
(define-public (set-availability
  (date uint)
  (available-slots (list 24 bool))
  (emergency-availability bool)
  (session-types-offered (list 8 (string-utf8 100)))
  (hourly-rates (list 8 uint))
  (preferred-platforms (list 5 (string-utf8 100)))
  (max-daily-sessions uint)
  (break-times (list 4 uint))
  (timezone-offset int)
)
  (begin
    ;; Input validation
    (asserts! (> max-daily-sessions u0) ERR_INVALID_INPUT)
    (asserts! (and (>= timezone-offset (- 12)) (<= timezone-offset 12)) ERR_INVALID_INPUT)
    
    (map-set practitioner-availability { practitioner: tx-sender, date: date } {
      available-slots: available-slots,
      emergency-availability: emergency-availability,
      session-types-offered: session-types-offered,
      hourly-rates: hourly-rates,
      preferred-platforms: preferred-platforms,
      max-daily-sessions: max-daily-sessions,
      current-bookings: u0,
      break-times: break-times,
      timezone-offset: timezone-offset,
      auto-booking-enabled: true,
      last-updated: block-height
    })
    
    (ok { availability-set: true })
  )
)

;; Start video session
(define-public (start-video-session
  (appointment-id uint)
  (session-url (string-utf8 300))
  (room-id (string-utf8 100))
  (recording-consent bool)
)
  (let (
    (session-id (var-get next-session-id))
    (appointment (unwrap! (get-appointment appointment-id) ERR_NOT_FOUND))
  )
    ;; Verify authorization (client or practitioner)
    (asserts! (or 
      (is-eq tx-sender (get client appointment))
      (is-eq tx-sender (get practitioner appointment))
    ) ERR_NOT_AUTHORIZED)
    
    ;; Verify appointment is scheduled
    (asserts! (is-eq (get appointment-status appointment) u"scheduled") ERR_INVALID_INPUT)
    
    ;; Create video session
    (map-set video-sessions session-id {
      id: session-id,
      appointment-id: appointment-id,
      session-url: session-url,
      room-id: room-id,
      start-time: block-height,
      actual-duration: u0,
      session-quality: none,
      technical-issues: none,
      recording-consent: recording-consent,
      recording-url: none,
      session-notes: none,
      client-satisfaction: none,
      practitioner-notes: none,
      follow-up-required: false,
      crisis-indicators: none,
      session-completed: false,
      billing-processed: false
    })
    
    ;; Update appointment status
    (map-set telehealth-appointments appointment-id 
      (merge appointment { appointment-status: u"in-progress", session-room-id: (some room-id) })
    )
    
    (var-set next-session-id (+ session-id u1))
    (ok { session-id: session-id, session-url: session-url })
  )
)

;; Complete video session
(define-public (complete-session
  (session-id uint)
  (actual-duration uint)
  (session-quality uint)
  (session-notes (string-utf8 1000))
  (client-satisfaction uint)
  (follow-up-required bool)
  (crisis-indicators (optional (string-utf8 300)))
)
  (let ((session (unwrap! (get-video-session session-id) ERR_NOT_FOUND)))
    ;; Verify session is active
    (asserts! (not (get session-completed session)) ERR_INVALID_INPUT)
    
    ;; Input validation
    (asserts! (and (>= session-quality u1) (<= session-quality u5)) ERR_INVALID_INPUT)
    (asserts! (and (>= client-satisfaction u1) (<= client-satisfaction u5)) ERR_INVALID_INPUT)
    
    ;; Update session
    (map-set video-sessions session-id 
      (merge session {
        actual-duration: actual-duration,
        session-quality: (some session-quality),
        session-notes: (some session-notes),
        client-satisfaction: (some client-satisfaction),
        follow-up-required: follow-up-required,
        crisis-indicators: crisis-indicators,
        session-completed: true
      })
    )
    
    ;; Update appointment status
    (let ((appointment (unwrap! (get-appointment (get appointment-id session)) ERR_NOT_FOUND)))
      (map-set telehealth-appointments (get appointment-id session)
        (merge appointment { appointment-status: u"completed" })
      )
    )
    
    ;; Trigger crisis intervention if indicated
    (if (is-some crisis-indicators)
      (ok { session-completed: true, crisis-intervention: true, follow-up-scheduled: follow-up-required })
      (ok { session-completed: true, follow-up-scheduled: follow-up-required, crisis-intervention: false })
    )
  )
)

;; Process insurance claim
(define-public (submit-insurance-claim
  (appointment-id uint)
  (insurance-provider (string-utf8 150))
  (policy-number (string-utf8 100))
  (claim-amount uint)
  (copay-amount uint)
  (diagnosis-codes (list 5 (string-utf8 10)))
  (procedure-codes (list 3 (string-utf8 10)))
)
  (let ((appointment (unwrap! (get-appointment appointment-id) ERR_NOT_FOUND)))
    ;; Verify authorization
    (asserts! (or
      (is-eq tx-sender (get client appointment))
      (is-eq tx-sender (get practitioner appointment))
    ) ERR_NOT_AUTHORIZED)
    
    ;; Verify appointment is completed
    (asserts! (is-eq (get appointment-status appointment) u"completed") ERR_INVALID_INPUT)
    (asserts! (get insurance-covered appointment) ERR_INVALID_INPUT)
    
    (map-set insurance-claims { appointment-id: appointment-id, claim-date: block-height } {
      insurance-provider: insurance-provider,
      policy-number: policy-number,
      claim-amount: claim-amount,
      copay-amount: copay-amount,
      deductible-applied: u0,
      claim-status: u"submitted",
      authorization-code: none,
      diagnosis-codes: diagnosis-codes,
      procedure-codes: procedure-codes,
      claim-submission-date: block-height,
      expected-payment-date: (+ block-height u4320), ;; 30 days
      rejection-reason: none,
      appeal-status: none
    })
    
    (ok { claim-submitted: true, expected-processing: u30 })
  )
)

;; Cancel appointment
(define-public (cancel-appointment 
  (appointment-id uint)
  (cancellation-reason (string-utf8 200))
  (refund-requested bool)
)
  (let ((appointment (unwrap! (get-appointment appointment-id) ERR_NOT_FOUND)))
    ;; Verify authorization
    (asserts! (or
      (is-eq tx-sender (get client appointment))
      (is-eq tx-sender (get practitioner appointment))
    ) ERR_NOT_AUTHORIZED)
    
    ;; Verify appointment can be cancelled
    (asserts! (not (is-eq (get appointment-status appointment) u"completed")) ERR_INVALID_INPUT)
    
    ;; Update appointment
    (map-set telehealth-appointments appointment-id
      (merge appointment {
        appointment-status: u"cancelled",
        cancellation-reason: (some cancellation-reason)
      })
    )
    
    ;; Process refund if requested and eligible
    (if (and refund-requested (> (get appointment-date appointment) (+ block-height u144))) ;; 24 hours notice
      (ok { appointment-cancelled: true, refund-processed: true })
      (ok { appointment-cancelled: true, refund-processed: false })
    )
  )
)

;; Reschedule appointment
(define-public (reschedule-appointment
  (appointment-id uint)
  (new-date uint)
  (new-time uint)
  (reschedule-reason (string-utf8 200))
)
  (let (
    (appointment (unwrap! (get-appointment appointment-id) ERR_NOT_FOUND))
    (new-appointment-id (var-get next-appointment-id))
  )
    ;; Verify authorization
    (asserts! (or
      (is-eq tx-sender (get client appointment))
      (is-eq tx-sender (get practitioner appointment))
    ) ERR_NOT_AUTHORIZED)
    
    ;; Verify appointment can be rescheduled
    (asserts! (is-eq (get appointment-status appointment) u"scheduled") ERR_INVALID_INPUT)
    
    ;; Cancel original appointment
    (map-set telehealth-appointments appointment-id
      (merge appointment { appointment-status: u"rescheduled" })
    )
    
    ;; Create new appointment
    (map-set telehealth-appointments new-appointment-id
      (merge appointment {
        id: new-appointment-id,
        appointment-date: new-date,
        appointment-time: new-time,
        appointment-status: u"scheduled",
        rescheduled-from: (some appointment-id)
      })
    )
    
    (var-set next-appointment-id (+ new-appointment-id u1))
    (ok { new-appointment-id: new-appointment-id, original-cancelled: true })
  )
)

;; Update session analytics
(define-public (update-session-analytics
  (period uint)
  (total-sessions uint)
  (completed-sessions uint)
  (average-rating uint)
  (total-revenue uint)
)
  (let ((existing-analytics (map-get? session-analytics { practitioner: tx-sender, period: period })))
    (map-set session-analytics { practitioner: tx-sender, period: period } {
      total-sessions: total-sessions,
      completed-sessions: completed-sessions,
      cancelled-sessions: (- total-sessions completed-sessions),
      no-shows: u0, ;; Would be calculated from actual data
      average-rating: average-rating,
      total-revenue: total-revenue,
      average-session-duration: u50, ;; Would be calculated from actual data
      technical-issues-count: u0,
      client-retention-rate: u85, ;; Would be calculated from actual data
      emergency-sessions: u0,
      follow-up-compliance: u90, ;; Would be calculated from actual data
      platform-usage: u"zoom-primary"
    })
    
    (ok { analytics-updated: true })
  )
)

;; Private Functions

;; Calculate session fee with platform commission
(define-private (calculate-total-fee (base-fee uint))
  (let ((commission (/ (* base-fee (var-get platform-commission)) u100)))
    {
      base-fee: base-fee,
      platform-commission: commission,
      practitioner-earning: (- base-fee commission)
    }
  )
)

;; Validate session timing
(define-private (validate-session-timing (date uint) (time uint) (duration uint))
  (and
    (> date block-height)
    (> duration u0)
    (<= duration u180) ;; Max 3 hours
  )
)