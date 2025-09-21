/**
 * Test utilities and helper functions for Community Mental Wellness platform testing
 */

import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

export class MentalWellnessTestSuite {
  chain: Chain;
  accounts: Map<string, Account>;
  deployer: Account;
  user1: Account;
  user2: Account;
  practitioner: Account;

  constructor(chain: Chain, accounts: Map<string, Account>) {
    this.chain = chain;
    this.accounts = accounts;
    this.deployer = accounts.get('deployer')!;
    this.user1 = accounts.get('wallet_1')!;
    this.user2 = accounts.get('wallet_2')!;
    this.practitioner = accounts.get('wallet_3')!;
  }

  /**
   * Helper to register a mental health practitioner
   */
  registerPractitioner(
    account: Account,
    name: string = "Dr. Test Practitioner",
    licenseNumber: string = "PSY12345",
    specializations: string[] = ["anxiety", "depression"]
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'wellness-registry',
        'register-practitioner',
        [
          types.utf8(name),
          types.utf8(licenseNumber),
          types.list(specializations.map(s => types.utf8(s))),
          types.uint(5), // years experience
          types.utf8("PhD Psychology"),
          types.list([types.utf8("CBT"), types.utf8("DBT")]),
          types.list([types.utf8("English")]),
          types.list([types.utf8("Individual therapy"), types.utf8("Group therapy")]),
          types.utf8("Weekdays 9-5"),
          types.utf8("Email preferred"),
          types.some(types.utf8("Sliding scale available")),
          types.list([types.utf8("LGBTQ+ affirming"), types.utf8("Trauma-informed")])
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to create a support group
   */
  createSupportGroup(
    account: Account,
    groupName: string = "Test Support Group",
    focusArea: string = "anxiety",
    meetingFormat: string = "online"
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'support-networks',
        'create-support-group',
        [
          types.utf8(groupName),
          types.uint(1), // facilitator-id
          types.utf8(focusArea),
          types.utf8("A supportive group for testing"),
          types.utf8(meetingFormat),
          types.utf8("Weekly Tuesdays 7pm"),
          types.utf8("virtual"),
          types.some(types.utf8("18+")),
          types.some(types.utf8("Safe space guidelines")),
          types.none(),
          types.uint(20), // max capacity
          types.utf8("Peer-led discussions and support"),
          types.some(types.utf8("18-65")),
          types.none()
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to add a wellness resource
   */
  addWellnessResource(
    account: Account,
    title: string = "Test Wellness Resource",
    category: string = "meditation",
    duration: number = 10
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'mindful-resources',
        'add-resource',
        [
          types.utf8(title),
          types.uint(1), // creator-id
          types.utf8(category),
          types.utf8("A test wellness resource"),
          types.none(), // content-hash
          types.uint(1), // difficulty level
          types.uint(duration),
          types.list([types.utf8("adults"), types.utf8("beginners")]),
          types.list([types.utf8("stress relief"), types.utf8("mindfulness")]),
          types.none(), // prerequisites
          types.list([types.utf8("Develop awareness"), types.utf8("Reduce stress")]),
          types.list([types.utf8("Audio descriptions available")]),
          types.none(), // trigger warnings
          types.uint(1), // quality rating
          types.uint(5), // evidence level
          types.list([types.utf8("English")]),
          types.utf8("All ages")
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to schedule a meditation session
   */
  scheduleMeditationSession(
    account: Account,
    title: string = "Test Meditation",
    sessionType: string = "guided",
    date: number = 1703980800 // Unix timestamp
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'mindful-resources',
        'schedule-meditation-session',
        [
          types.utf8(title),
          types.uint(1), // facilitator-id
          types.utf8(sessionType),
          types.utf8("mindfulness"),
          types.utf8("A guided mindfulness meditation"),
          types.uint(date),
          types.uint(20), // duration
          types.uint(15), // max participants
          types.bool(false), // requires registration
          types.utf8("virtual"),
          types.none(), // location
          types.utf8("beginner"),
          types.utf8("Present moment awareness"),
          types.list([types.utf8("breath awareness"), types.utf8("body scan")]),
          types.some(types.utf8("Calming music")),
          types.some(types.utf8("Comfortable seated position")),
          types.uint(1), // accessibility level
          types.list([types.utf8("breathing exercises"), types.utf8("mindful observation")])
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to create a wellness journey
   */
  createWellnessJourney(
    account: Account,
    journeyName: string = "Test Wellness Journey",
    journeyType: string = "self-guided",
    targetDays: number = 30
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'mindful-resources',
        'create-wellness-journey',
        [
          types.utf8(journeyName),
          types.uint(1), // creator-id
          types.utf8(journeyType),
          types.list([types.utf8("Reduce stress"), types.utf8("Improve focus")]),
          types.uint(1), // difficulty level
          types.uint(targetDays),
          types.uint(1703980800), // start date
          types.uint(5), // total milestones
          types.bool(false), // requires mentorship
          types.list([
            types.utf8("daily meditation"),
            types.utf8("gratitude journaling"),
            types.utf8("mindful walking")
          ]),
          types.some(types.utf8("Evidence-based mindfulness practices")),
          types.none() // professional guidance
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to submit a wellness check-in
   */
  submitWellnessCheckin(
    account: Account,
    energyLevel: number = 7,
    stressLevel: number = 4,
    sleepQuality: number = 8
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'support-networks',
        'submit-wellness-checkin',
        [
          types.uint(energyLevel),
          types.uint(stressLevel),
          types.uint(sleepQuality),
          types.uint(6), // social connection
          types.uint(7), // coping effectiveness
          types.uint(1703980800), // checkin date
          types.some(types.utf8("Feeling good today")),
          types.some(types.uint(80)), // goal progress
          types.none(), // challenges faced
          types.some(types.utf8("Completed morning meditation")),
          types.some(types.utf8("Continue daily practice"))
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to log a wellness activity
   */
  logWellnessActivity(
    account: Account,
    activityName: string = "Meditation",
    activityType: string = "mindfulness",
    duration: number = 15
  ) {
    return this.chain.mineBlock([
      Tx.contractCall(
        'mindful-resources',
        'log-wellness-activity',
        [
          types.utf8(activityName),
          types.utf8(activityType),
          types.uint(1703980800), // activity date
          types.uint(duration),
          types.uint(6), // intensity level
          types.some(types.uint(1)), // journey id
          types.some(types.uint(1)), // session id
          types.uint(7), // stress before
          types.uint(3), // stress after
          types.uint(8), // focus level
          types.uint(9), // enjoyment rating
          types.some(types.utf8("Very relaxing session")),
          types.some(types.utf8("Living room")),
          types.list([]) // companions
        ],
        account.address
      )
    ]);
  }

  /**
   * Helper to verify test results
   */
  assertSuccess(result: any, message?: string) {
    assertEquals(result.success, true, message || 'Transaction should succeed');
    return result;
  }

  assertError(result: any, expectedError: string, message?: string) {
    assertEquals(result.success, false, message || 'Transaction should fail');
    assertEquals(result.error, expectedError, message || `Should fail with error: ${expectedError}`);
    return result;
  }

  /**
   * Helper to check contract state
   */
  getContractState(contractName: string, mapName: string, key: any) {
    return this.chain.getMapEntry(contractName, mapName, key);
  }

  /**
   * Helper to get current block height for time-based testing
   */
  getCurrentBlockHeight(): number {
    return this.chain.blockHeight;
  }

  /**
   * Helper to advance blockchain time for testing time-dependent features
   */
  advanceTime(blocks: number = 1) {
    const emptyBlocks = Array(blocks).fill(Tx.transferSTX(1, this.deployer.address, this.user1.address));
    return this.chain.mineBlock(emptyBlocks);
  }
}

/**
 * Common test data generators
 */
export const TestData = {
  practitioners: {
    psychologist: {
      name: "Dr. Sarah Johnson",
      license: "PSY12345",
      specializations: ["anxiety", "depression", "trauma"],
      experience: 8,
      education: "PhD Clinical Psychology, Harvard",
      approaches: ["CBT", "EMDR", "DBT"],
      languages: ["English", "Spanish"],
      services: ["Individual therapy", "Group therapy", "Crisis intervention"]
    },
    counselor: {
      name: "Maria Rodriguez, LMHC",
      license: "LMHC67890",
      specializations: ["family therapy", "addiction", "grief"],
      experience: 5,
      education: "MA Counseling Psychology, NYU",
      approaches: ["Family Systems", "Motivational Interviewing", "Grief Therapy"],
      languages: ["English", "Spanish"],
      services: ["Family counseling", "Addiction counseling", "Support groups"]
    }
  },

  resources: {
    meditation: {
      title: "Mindfulness for Anxiety",
      category: "meditation",
      description: "A guided meditation specifically designed to help manage anxiety symptoms",
      duration: 15,
      targetAudience: ["adults", "anxiety sufferers"],
      focusAreas: ["anxiety relief", "breathing techniques"]
    },
    educational: {
      title: "Understanding Depression",
      category: "education",
      description: "Comprehensive guide to understanding depression symptoms and treatment options",
      duration: 30,
      targetAudience: ["adults", "caregivers"],
      focusAreas: ["mental health literacy", "depression awareness"]
    }
  },

  supportGroups: {
    anxietySupport: {
      name: "Anxiety Support Circle",
      focusArea: "anxiety",
      description: "A safe space for individuals managing anxiety to share experiences and coping strategies",
      format: "online",
      schedule: "Tuesdays 7:00 PM EST"
    },
    depressionSupport: {
      name: "Depression Recovery Group",
      focusArea: "depression", 
      description: "Peer support group for those on their depression recovery journey",
      format: "hybrid",
      schedule: "Thursdays 6:30 PM EST"
    }
  },

  wellnessJourneys: {
    stressManagement: {
      name: "30-Day Stress Relief Journey",
      type: "structured",
      goals: ["Reduce daily stress", "Improve coping skills", "Build resilience"],
      duration: 30,
      practices: ["daily meditation", "stress tracking", "breathing exercises"]
    },
    mindfulnessBasics: {
      name: "Mindfulness for Beginners",
      type: "self-guided",
      goals: ["Learn mindfulness basics", "Establish daily practice", "Increase awareness"],
      duration: 21,
      practices: ["guided meditations", "mindful eating", "walking meditation"]
    }
  }
};

/**
 * Integration test helpers for complex workflows
 */
export class IntegrationTestHelpers {
  testSuite: MentalWellnessTestSuite;

  constructor(testSuite: MentalWellnessTestSuite) {
    this.testSuite = testSuite;
  }

  /**
   * Complete practitioner onboarding workflow
   */
  completePractitionerOnboarding(account: Account) {
    // Register practitioner
    let block = this.testSuite.registerPractitioner(account);
    this.testSuite.assertSuccess(block.receipts[0].result);

    // Create a safe space
    block = this.testSuite.chain.mineBlock([
      Tx.contractCall(
        'wellness-registry',
        'create-safe-space',
        [
          types.utf8("Professional Support Space"),
          types.utf8("professional"),
          types.utf8("A space for professional mental health support"),
          types.utf8("Professional guidelines apply"),
          types.list([types.utf8("therapy"), types.utf8("counseling")]),
          types.utf8("Mondays and Wednesdays 10-12"),
          types.utf8("virtual"),
          types.none(),
          types.uint(25),
          types.none(),
          types.utf8("moderated"),
          types.utf8("Escalation to crisis team if needed")
        ],
        account.address
      )
    ]);
    this.testSuite.assertSuccess(block.receipts[0].result);

    return { practitionerId: 1, safeSpaceId: 1 };
  }

  /**
   * Complete user wellness journey workflow
   */
  completeUserWellnessJourney(account: Account) {
    // Create wellness journey
    let block = this.testSuite.createWellnessJourney(account);
    this.testSuite.assertSuccess(block.receipts[0].result);

    // Log several activities
    for (let i = 0; i < 5; i++) {
      block = this.testSuite.logWellnessActivity(
        account, 
        `Day ${i + 1} Meditation`, 
        "mindfulness", 
        15 + i * 2
      );
      this.testSuite.assertSuccess(block.receipts[0].result);
    }

    // Submit wellness check-ins
    for (let i = 0; i < 3; i++) {
      block = this.testSuite.submitWellnessCheckin(account, 7 + i, 5 - i, 8);
      this.testSuite.assertSuccess(block.receipts[0].result);
    }

    return { journeyId: 1, activitiesLogged: 5, checkinsSubmitted: 3 };
  }

  /**
   * Crisis response workflow test
   */
  testCrisisResponse(account: Account) {
    // Submit crisis support request
    let block = this.testSuite.chain.mineBlock([
      Tx.contractCall(
        'support-networks',
        'request-crisis-support',
        [
          types.utf8("anxiety-attack"),
          types.some(types.utf8("Home")),
          types.utf8("Experiencing severe anxiety, need immediate support")
        ],
        account.address
      )
    ]);
    this.testSuite.assertSuccess(block.receipts[0].result);

    // Verify crisis request was logged
    const crisisRequest = this.testSuite.getContractState(
      'support-networks',
      'crisis-support-requests',
      types.uint(1)
    );
    
    return { requestId: 1, crisisRequest };
  }
}