---
name: Salary Tracker M3 Mobile
colors:
  surface: '#f9f9ff'
  surface-dim: '#d3daef'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f3ff'
  surface-container: '#e9edff'
  surface-container-high: '#e1e8fd'
  surface-container-highest: '#dce2f7'
  on-surface: '#141b2b'
  on-surface-variant: '#3e4947'
  inverse-surface: '#293040'
  inverse-on-surface: '#edf0ff'
  outline: '#6e7977'
  outline-variant: '#bdc9c6'
  surface-tint: '#006a63'
  primary: '#00433d'
  on-primary: '#ffffff'
  primary-container: '#0f766e'
  on-primary-container: '#a3faef'
  inverse-primary: '#80d5cb'
  secondary: '#016a61'
  on-secondary: '#ffffff'
  secondary-container: '#86f2e4'
  on-secondary-container: '#006f66'
  tertiary: '#553300'
  on-tertiary: '#ffffff'
  tertiary-container: '#945d00'
  on-tertiary-container: '#ffe6cc'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#9cf2e8'
  primary-fixed-dim: '#80d5cb'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#00504a'
  secondary-fixed: '#89f5e7'
  secondary-fixed-dim: '#6bd8cb'
  on-secondary-fixed: '#00201d'
  on-secondary-fixed-variant: '#005049'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#ffb95f'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#f9f9ff'
  on-background: '#141b2b'
  surface-variant: '#dce2f7'
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

This design system establishes an adaptive, empathetic, and disciplined financial workspace crafted natively around Google's Material 3 (Material You) guidelines. Geared toward salaried professionals and earners managing complex cash flows, the interface discards high-friction, anxiety-inducing ledger patterns in favor of calm, organized clarity.

The emotional tone balances institutional banking trustworthiness with approachable personal stewardship. Financial clarity is achieved through gentle tonal surface layering, spacious layout breathing room, and strict accessibility benchmarks (minimum 48×48px interactive touch targets across every touchable surface).

Visual principles follow Modern Material 3:
- **Tonal Hierarchy Over Stark Contrast**: Surfaces stack intuitively with tonal tinting rather than harsh heavy drop shadows.
- **Human Financial Literacy**: Visual grouping isolates core budget structures (Needs vs. Wants vs. Savings) using distinct yet harmonious color roles.
- **Cultural & Regional Relevance**: Built from the ground up to render the Indian numbering system (`₹1,25,000`, `₹12,450`) with uncompromised tabular balance and optical weight.

## Colors

The palette leverages restorative deep teals, sea-greens, and warm amber accents to frame financial health without alarmist visual noise.

### Functional Roles
- **Primary (`#005C55`) / Container (`#0F766E`)**: Anchors structural foundations, key action triggers, primary tab indicators, and authoritative totals.
- **Secondary (`#006A61`) / Container (`#86F2E4`)**: Dedicated categorical color representing essentials and operational needs (Rent, EMIs, Utilities, Groceries).
- **Tertiary (`#734700`) / Container (`#945D00`)**: Evocative warm amber tone highlighting discretionary spending and goals (Dining, Entertainment, Shopping, Milestones).
- **Surface & Background (`#F9F9FF`)**: Muted, light tonal plane minimizing eye fatigue across frequent daily logging sessions.
- **Surface Containers (`#FFFFFF` to `#DCE2F7`)**: Tinted tiers that separate interactive cards, navigation containers, and sheets without heavy borders.
- **Semantic Feedback**:
  - `Error / Alert` (`#BA1A1A` / Container `#FFDAD6`): Over-budget alerts, pending EMI deadlines, and high-spend warnings.
  - `Success` (`#0F766E` / Fixed `#9CF2E8`): Salary credits, positive cash flow, and fulfilled savings milestones.

## Typography

The type system is powered entirely by `Inter`, chosen for its grotesque proportions, open counters, and robust OpenType tabular lining figures (`tnum`).

### Rupee Formatting & Numerical Rules
- Tabular figures (`font-feature-settings: "tnum"`) are mandatory across all monetary tables, spending summaries, and card balances to align decimal points and grouping commas.
- Numbers follow the Indian grouping system (e.g., `₹1,25,000` rather than `₹125,000`).
- The Rupee symbol (`₹`) is rendered at the identical weight and font family as the numerical figure, with zero whitespace separating the symbol and the initial digit.
- `display-currency` and `display-currency-mobile` are strictly reserved for headline liquidity balances, total monthly run rates, and aggregate savings indicators.

## Layout & Spacing

The layout is built for native handheld ergonomics using a fluid 4-column grid on standard mobile viewports (360px–420px width), with 16px screen margins (`margin: 1rem`) and 16px column gutters (`gutter: 1rem`).

### Grid & Density Rules
- **Base Grid**: 8px spatial rhythm with an underlying 4px half-step for micro-alignments (icon-to-label offsets, badge padding, hairline divider spacing).
- **Touch Target Integrity**: All tap areas (navigation icons, list items, quick-add buttons) must evaluate to at least 48×48px physical bounds, regardless of the visual glyph size.
- **Safe Areas**: Top margins accommodate system status bars and the persistent AppHeader; bottom screen bounds reserve 80px for the persistent navigation bar and gesture indicators.

## Elevation & Depth

Visual hierarchy is established using Material 3 tonal surface layering complemented by soft ambient shadows:

- **Level 0 (Base Canvas)**: `#F9F9FF` — Flat canvas layer with no shadow.
- **Level 1 (Cards, Feed Items, Banners)**: `#FFFFFF` or `surface-container-lowest` — `0px 1px 3px rgba(20, 27, 43, 0.05), 0px 1px 2px rgba(20, 27, 43, 0.03)` with a hairline boundary (`rgba(110, 121, 119, 0.12)`).
- **Level 2 (Bottom Bar, Sticky Bars, Bottom Sheets)**: `surface-container-low` / `#F1F3FF` — `0px 4px 6px -1px rgba(20, 27, 43, 0.07), 0px 2px 4px -2px rgba(20, 27, 43, 0.04)`.
- **Level 3 (FAB, Dialogs, Floating Overlays)**: `#0F766E` or `#FFFFFF` — `0px 10px 15px -3px rgba(0, 92, 85, 0.20), 0px 4px 6px -4px rgba(20, 27, 43, 0.06)`. Diffuse primary tint creates focused pop-out depth.

## Shapes

The interface balances tactile touch points with modern container geometry:
- **Cards & Primary Modules**: 16px (`1rem` / `rounded-lg`). Provides an approachable rhythm for modular spends and summaries.
- **Input Fields & Small Containers**: 8px–12px corner rounding for legible entry boundaries.
- **Badges, Filter Chips, Navigation Indicators & Primary Buttons**: Fully rounded pill shapes (`9999px`) to distinguish actionable controls from static container cards.

## Components

### Screen Top-Level Structure Rules

#### 1. Tab Screens (Bottom Navigation Active)
Screens hosting the persistent 5-tab bottom navigation bar (`Home`, `Spends`, `Recurring`, `Analytics`, `Goals`) must **NOT** display a screen title headline below the `AppHeader`. The active bottom navigation pill already communicates the current view. 

Instead, the first element immediately below the `AppHeader` must be contextual, data-dense, and immediately useful:
- **Home**: Greeting + salary cycle status line (e.g., `Good afternoon, Aditi • Cycle resets in 18 days`).
- **Spends**: Month selector dropdown paired directly with the total spent summary header block.
- **Recurring**: "Due this month" total commitments and billing summary card.
- **Analytics**: Period toggle (`Month` | `3M` | `Year`) directly followed by the high-level financial snapshot.
- **Goals**: Aggregate "Total saved across all goals" hero banner / metric summary.

#### 2. Stack Sub-Screens (Bottom Navigation Absent)
Screens without bottom navigation (including `Add Goal`, `Goal Detail`, `Transaction Detail`, `Profile & Settings`, `Unreadable Messages`, `Setup`, `SMS Permission`) **ALWAYS** feature a prominent screen title headline (`headline-lg-mobile` or `headline-md`) immediately below the `AppHeader`.

---

### Core UI Components

#### Buttons
- **Filled Primary**: `#005C55` background with `#FFFFFF` text, 48px height, pill radius (`9999px`).
- **Tonal Button**: `#E9EDFF` container with `#005C55` text, used for auxiliary utilities such as statement export or filter clearing.
- **Floating Action Button (FAB)**: 56×56px with 16px corner radius, rendered in `#005C55` or `#0F766E` with high-contrast icon.

#### Chips & Segmented Controls
- **Filter & Category Chips**: 32px height, pill-shaped (`9999px`). Inactive chips use a 1px border (`#BDC9C6`) on transparent background. Active chips use `#0F766E` background with `#FFFFFF` text.
- **Segmented Period Switcher (Analytics)**: Full-width container in `surface-container-high` (`#E1E8FD`), housing segmented tab pills that animate into `#FFFFFF` surface on active selection.

#### Lists & Transaction Rows
- **Height & Layout**: Minimum 64px row height.
- **Structure**:
  - Leading: 40×40px circular category container tinted with the category color.
  - Middle: Merchant/Description (`title-md`) stacked over timestamp/category subtitle (`body-sm`).
  - Trailing: Tabular currency total (`title-md`), green for credits (`#005C55`) or neutral for debits (`#141B2B`).

#### Input Fields
- **Amount Input**: Prominent numeric display with tabular digits and leading `₹` glyph.
- **Form Controls**: 52px height, 8px–12px radius, bounded by `outline-variant` (`#BDC9C6`) at rest and `primary` (`#005C55`) when focused.

#### Bottom Navigation Bar
- **Dimensions & Placement**: Fixed 80px height anchored to the bottom edge, backed by `surface-container-low` (`#F1F3FF`) with a 1px top divider (`#BDC9C6`).
- **Distribution**: 5 equal slots (`Home`, `Spends`, `Recurring`, `Analytics`, `Goals`).
- **Active State**: 64×32px pill indicator in `primary-container` (`#0F766E`) or `secondary-container` (`#86F2E4`) framing the active icon, with `label-sm` text.