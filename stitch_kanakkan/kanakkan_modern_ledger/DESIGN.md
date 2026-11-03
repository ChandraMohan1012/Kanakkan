---
name: Kanakkan Modern Ledger
colors:
  surface: '#f9f9ff'
  surface-dim: '#d3daef'
  surface-bright: '#faf9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f3ff'
  surface-container: '#e9edff'
  surface-container-high: '#e1e8fd'
  surface-container-highest: '#dce2f7'
  on-surface: '#141b2b'
  on-surface-variant: '#3f4947'
  inverse-surface: '#293041'
  inverse-on-surface: '#edf0ff'
  outline: '#6e7977'
  outline-variant: '#bdc9c6'
  surface-tint: '#1a6962'
  primary: '#00433d'
  on-primary: '#ffffff'
  primary-container: '#005c55'
  on-primary-container: '#8ad2c8'
  inverse-primary: '#8cd4ca'
  secondary: '#016a61'
  on-secondary: '#ffffff'
  secondary-container: '#9defe3'
  on-secondary-container: '#0d6f66'
  tertiary: '#553300'
  on-tertiary: '#ffffff'
  tertiary-container: '#744801'
  on-tertiary-container: '#f8b96d'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#a7f0e6'
  primary-fixed-dim: '#8cd4ca'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#00504a'
  secondary-fixed: '#a0f1e6'
  secondary-fixed-dim: '#84d5ca'
  on-secondary-fixed: '#00201d'
  on-secondary-fixed-variant: '#005049'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#f9bb6e'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#faf9ff'
  on-background: '#141b2b'
  surface-variant: '#dce2f9'
  brand-crimson: '#ba1a1a'
  brand-teal: '#0f766e'
  success-green: '#16a34a'
  success-container: '#dcfce7'
  warning-amber: '#f59e0b'
  warning-container: '#fef3c7'
typography:
  display-currency:
    fontFamily: Inter
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  display-currency-mobile:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 26px
    fontWeight: '600'
    lineHeight: 34px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  title-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  title-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 14px
    letterSpacing: 0.02em
  section-kicker:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.08em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system is tailored for personal accounting, income-expense logging, and financial goal tracking built natively around modern Material 3 conventions with an Indian financial focus. The interface departs from anxious, institutional banking patterns to offer an approachable, disciplined, and private personal ledger.

### Core Philosophy & Brand Persona
- **Sovereign & Local-First**: The system embodies absolute user privacy. Financial intelligence operates 100% on-device (local SQLite storage) without cloud surveillance, trackers, or hidden analytics.
- **Calm Stewardship**: Restorative deep teals paired with crimson accenting communicate precision, stability, and cultural resonance across day-to-day transaction records.
- **Ergonomic Clarity**: Clear visual hierarchy, generous touch targets (minimum 48×48px), and thoughtful surface layering relieve cognitive fatigue during daily spend logging.

### Design Movement
**Modern Material 3 with Tactile Warmth**: Tonal surface containers, balanced pill-shaped interactive triggers, crisp border framing, and deliberate typographic rhythm across currency and numerical states.

## Colors

The color palette employs restorative deep teals, crisp neutral container tiers, and purposeful crimson and amber accents to guide attention without alarmist friction.

### Key Roles
- **Primary (`#005c55` / `#0f766e`)**: Anchors primary navigation glyphs, main interactive actions, confirmed transactions, and active pill indicators.
- **Secondary (`#006a61`)**: Categorical anchor for recurring necessities and committed expenditures (EMIs, rent, essential utilities).
- **Brand Crimson (`#ba1a1a`)**: Serves dual functions as the identity accent in the global header mark alongside teal, and as the clear indicator for expense alerts, budget threshold breaches, and destructive actions.
- **Tertiary Amber (`#734700` / `#f59e0b`)**: Highlights discretionary spending ("Wants"), milestone progress, and warnings.
- **Neutral Base (`#141b2b`)**: Deep tone ensuring high-contrast legibility (`12:1`+) across text copy and tabular ledger rows.

### Surface Tiers
- **Canvas (`surface`, `#f9f9ff`)**: Cool base canvas setting up comfortable visual separation.
- **Elevated Cards (`surface-container-lowest`, `#ffffff`)**: Crisp white surface reserved for transaction cards, setting groups, and interactive sheets.
- **Group Containers (`surface-container-low` to `surface-container`, `#f1f3ff` - `#e9edff`)**: Provides structured backdrops for grouped settings, segmented filters, and active tab pillows.

## Typography

The typographic hierarchy is powered completely by `Inter`, leveraging its crisp geometry, neutral counters, and OpenType tabular numbers.

### Indian Financial Notation Rules
- Apply tabular figures (`font-feature-settings: "tnum"`) to all monetary numbers, balance summaries, and table cells to preserve decimal alignment and clean vertical scanning.
- Currency notation strictly adheres to the Indian numbering standard (e.g., `₹1,25,000.00` and `₹18,450.00`).
- The Rupee glyph (`₹`) shares the font weight and sizing of the immediate numerical value without intervening whitespace.
- Section headers within grouped cards use `section-kicker`: small caps, uppercase, with deliberate letter tracking (`0.08em`) in a muted tonal shade (`#6e7977`).

## Layout & Spacing

Layout geometry follows a disciplined mobile-first 4-column grid (360px–420px standard screen width) built on an 8px rhythmic increments with a 4px sub-grid for badge and icon alignments.

### Boundaries and Viewports
- **Canvas Margins (`margin: 1rem`)**: 16px side boundaries across all core views.
- **Top Safe Area**: Dynamic status bar inset + 8px spacing prior to rendering the fixed global `AppHeader`.
- **Bottom Clearance**: Dedicated 80px fixed elevation clearance for the persistent 5-tab bottom navigation bar, preventing bottom card content overlap.

## Elevation & Depth

Visual depth is achieved through Material 3 tonal stacking accompanied by light, diffused ambient drop shadows rather than stark silhouettes.

- **Level 0 (Canvas Surface)**: `#f9f9ff` — Flat baseline canvas.
- **Level 1 (Cards, Ledger Tiles, Settings Containers)**: `#ffffff` — `0px 1px 3px rgba(20, 27, 43, 0.04), 0px 1px 2px rgba(20, 27, 43, 0.02)`, bounded by a subtle `1px solid rgba(110, 121, 119, 0.12)`.
- **Level 2 (Persistent Headers, Bottom Navigation)**: `#ffffff` — `0px 4px 6px -1px rgba(20, 27, 43, 0.05), 0px 2px 4px -2px rgba(20, 27, 43, 0.03)`.
- **Level 3 (Quick Add Action Triggers, Floating Modals)**: `#0f766e` / `#ffffff` — `0px 10px 15px -3px rgba(15, 118, 110, 0.18), 0px 4px 6px -4px rgba(20, 27, 43, 0.06)`.

## Shapes

The design system applies friendly, modern roundedness:
- **Grouped Setting Blocks & Cards**: 16px (`1rem` / `rounded-lg`).
- **Profile Avatar (Header)**: Circular `9999px` full round (40×40px) with a 1.5px subtle outline ring.
- **Profile Avatar (Settings Card)**: Circular `9999px` full round (72×72px) with interactive tap-to-change overlay.
- **Action Buttons, Badges, and Navigation Pills**: Fully rounded pill shapes (`9999px`).
- **Input Fields & Text Cells**: 12px (`0.75rem`) smooth corners.

## Components

### 1. Global AppHeader Component
- **Universal Placement**: Fixed at the top of every screen.
- **Left Side**: App title "Kanakkan" rendered in brand font typography, styled with the established crimson/teal accent treatment.
  - *Stack Navigation Sub-Screens*: Displays a 24px left navigation back chevron immediately to the left of "Kanakkan" with a minimum 48×48px tap area.
- **Right Side**: Circular profile avatar (40×40px) bounded by a 1.5px outline ring (`#bdc9c6`). Tapping the avatar unconditionally pushes/navigates to the Profile & Settings view.
- **Screen Titles**: Dedicated screen titles (e.g., "Monthly Spends", "Recurring Commitments") render *below* the global header in the screen body, never embedded inside the header itself.

### 2. Profile & Settings Screen
- **Profile Header Card**:
  - Elevated container card (`surface-container-lowest`) with 16px inner padding.
  - Large 72×72px circular avatar centered or top-aligned with an interactive edit camera badge ("tap to change photo").
  - Inline editable display name field paired with a pencil icon button.
  - Trust badge / Privacy callout placed prominently:
    > "Your data stays on your phone • 100% on-device SQLite ledger • No cloud sync, no tracking"
    Rendered in `body-sm`, neutral muted tone (`#6e7977`), framed inside a subtle container with an on-device security shield icon.
- **Grouped Settings Blocks**:
  - Organized into distinct rounded container cards (`rounded-lg`, 16px radius) separated by 16px gaps.
  - Card rows separated by hairline 1px dividers (`#e9edff` or `#bdc9c6` at 30% opacity).
  - Each item includes a leading 24px functional icon, setting title (`title-md`), optional state helper/badge (`body-sm`), and a trailing chevron or switch toggle.
  - **Group Headings**: Placed immediately above each container card, formatted using `section-kicker` (uppercase, tracked, muted color):
    - `PREFERENCES`: Currency (₹ INR default), Language, Theme (Light).
    - `SECURITY`: App lock / PIN, Biometric Unlock.
    - `DATA & STORAGE`: Backup, Export (CSV/JSON), Import, Reset all data (styled with `brand-crimson` alert accent).
    - `ABOUT & TRUST`: App Version, Privacy Manifesto, Feedback.

### 3. Persistent Bottom Navigation Bar
- **Tab Layout**: Fixed 80px bar anchored to the bottom containing strictly 5 destination tabs:
  1. `Home`: Overview, net balance, disposable runway.
  2. `Spends`: Transaction stream, daily expenses, category tagging.
  3. `Recurring`: Fixed commitments, rent, SIPs, EMIs, and utility schedules.
  4. `Analytics`: Budget distributions (Needs vs. Wants), trends, breakdowns.
  5. `Goals`: Sinking funds, emergency buffers, target milestones.
- *Notice*: There is no Settings tab in bottom navigation; access to settings is exclusively through the persistent header avatar.
- **Active State**: Pill-shaped container highlight (`#e9edff` or `#0f766e` tint) encompassing the active icon and 12px label.

### 4. Financial Cards & Metric Modules
- **Overview Card**: White surface (`#ffffff`), 16px radius, containing primary net balance formatted with `display-currency`, accompanied by month-to-date income and outflow metrics.
- **Category Progress Row**: Displays category icon, category name, spent amount against budgeted limit, and a split progress track using `#006a61` ("Needs") and `#f59e0b` ("Wants").

### 5. Input Fields & Selectors
- **Currency Field**: Dedicated numeric input displaying leading Indian Rupee symbol (`₹`), supporting localized decimal and comma insertion automatically.
- **Text Inputs**: 52px height, 12px radius, bounded by `#6e7977` border, transitioning to a 2px `#005c55` border when active.