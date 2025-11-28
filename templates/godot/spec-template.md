# Feature Specification: [FEATURE NAME]

**Feature Branch**: `[###-feature-name]`
**Created**: [DATE]
**Status**: Draft
**Input**: User description: "$ARGUMENTS"

## Gameplay Scenarios & Testing *(mandatory)*

<!--
  IMPORTANT: Define the player experience.
  Each scenario should be a playable slice of the feature.
-->

### Scenario 1 - [Brief Title] (Priority: P1)

[Describe the gameplay experience in plain language]

**Why this priority**: [Explain why this is critical for the game loop]

**Independent Test**: [Describe how to verify this in-game, e.g., "Run scene X, press Space, observe Y"]

**Acceptance Criteria**:

1. **Given** [Game State/Scene], **When** [Player Input/Event], **Then** [Visual/Audio Feedback & State Change]
2. **Given** [Game State/Scene], **When** [Player Input/Event], **Then** [Visual/Audio Feedback & State Change]

---

### Scenario 2 - [Brief Title] (Priority: P2)

[Describe the gameplay experience]

**Acceptance Criteria**:

1. **Given** [Game State], **When** [Action], **Then** [Outcome]

---

## Core Mechanics *(mandatory)*

<!--
  Define the rules and interactions.
-->

### Mechanics
- **M-001**: [Input] triggers [Action] resulting in [Feedback].
- **M-002**: [Entity A] interacts with [Entity B] by [Interaction Rule].
- **M-003**: System manages [Resource/State] by [Logic].

### Controls
- **Action**: [Input Mapping] (e.g., "Jump": Spacebar / A button)
- **Action**: [Input Mapping]

## Assets Required *(include if applicable)*

<!--
  List new assets needed for this feature.
-->

### Visuals
- **[Model/Sprite]**: [Description]
- **[VFX]**: [Description]
- **[UI]**: [Description]

### Audio
- **[SFX]**: [Description]
- **[Music]**: [Description]

## Success Criteria *(mandatory)*

### Measurable Outcomes
- **SC-001**: [Performance Metric, e.g., "Maintains 60 FPS during particle effect"]
- **SC-002**: [Gameplay Metric, e.g., "Player can complete action in < 1s"]
