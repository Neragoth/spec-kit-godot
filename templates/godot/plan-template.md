# Implementation Plan - [Feature Name]

This plan outlines the technical implementation of [Feature Name] using Godot 4.5 best practices (Clean Architecture, Data-Driven Design).

## User Review Required

> [!IMPORTANT]
> Critical technical decisions or breaking changes.

## Proposed Architecture

### Scene Structure
<!--
  Define the Node hierarchy for new scenes.
  Use composition with Components where possible.
-->

#### [Scene Name].tscn
- `RootNode` ([Type])
    - `Visuals` (Node3D/Node2D)
        - `MeshInstance` / `Sprite`
    - `Collision` (CollisionShape)
    - `Components` (Node)
        - `[Name]Component` (Node)

### Resources (Data-Driven)
<!--
  Define custom Resources for configuration and data.
-->

#### [Resource Name].gd (extends Resource)
- `export var [property]: [Type]`
- `export var [property]: [Type]`

### Signals & Events
<!--
  Define communication flow.
-->

- **Signal**: `[signal_name](args)` emitted by `[Source]` when `[Condition]`.
- **Connection**: `[Source]` -> `[Target].on_[signal_name]`

## Proposed Changes

### [Component/System Name]

#### [NEW] [File Name]
- **Path**: `src/[feature]/[filename]`
- **Description**: [Brief description of responsibility]

#### [MODIFY] [File Name]
- **Path**: `src/[feature]/[filename]`
- **Change**: [Description of change]

## Verification Plan

### Automated Tests (GUT)
- `test_[feature].gd`:
    - `test_[scenario_1]`: Verify [outcome].
    - `test_[scenario_2]`: Verify [outcome].

### Manual Verification
- Run Scene: `[Path to Scene]`
- Action: [Step-by-step instructions]
- Expected: [Visual/Audio confirmation]
