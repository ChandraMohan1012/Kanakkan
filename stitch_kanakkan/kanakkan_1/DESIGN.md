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
  primary: '#005c55'
  on-primary: '#ffffff'
  primary-container: '#0f766e'
  on-primary-container: '#a3faef'
  inverse-primary: '#80d5cb'
  secondary: '#006a61'
  on-secondary: '#ffffff'
  secondary-container: '#86f2e4'
  on-secondary-container: '#006f66'
  tertiary: '#734700'
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

This design system establishes an adaptive, empathetic, and disciplined financial workspace crafted natively around Google's Material 3 (Material You) guidelines. Geared toward Indian salaried professionals and young earners, the interface discards high-friction, anxiety-inducing ledger patterns in favor of calm, organized clarity.

The emotional tone balances institutional banking trustworthiness with approachable personal stewardship. Financial clarity is achieved through gentle tonal surface layering, spacious layout breathing room, and strict accessibility benchmarks (minimum 48×48px interactive touch targets across every touchable surface).

Visual principles follow Modern Material 3:
- **Tonal Hierarchy Over Stark Contrast**: Surfaces stack intuitively with tonal tinting rather than harsh heavy drop shadows.
- **Human Financial Literacy**: Visual grouping isolates core budget structures (Needs vs. Wants vs. Savings) using distinct yet harmonious color roles.
- **Cultural & Regional Relevance**: Built from the ground up to render the Indian numbering system (`₹1,25,000`, `₹12,450`) with uncompromised tabular balance and optical weight.

## Colors

The palette leverages restorative teals and warm amber accents to frame financial health without alarmist visual noise.

### Functional Roles
- **Primary (`#0F766E`)**: Deep Teal serves as the structural foundation, key action triggers, primary tab indicators, and authoritative totals.
- **Primary Container (`#E6F4F2`)**: Soft teal wash used for active component states, primary badges, and key metric callout tiles.
- **Secondary / "Needs" (`#0D9488`)**: Dedicated categorical color representing essentials (Rent, EMIs, Utilities, Groceries).
- **Secondary Container (`#CCFBF1`)**: Backing tone for "Needs" categorical summaries.
- **Accent / "Wants" Warm Amber (`#F59E0B`)**: Evocative secondary hue highlighting discretionary spending (Dining, Subscriptions, Shopping).
- **Accent Container (`#FEF3C7`)**: Backing for "Wants" categorical summaries.
- **Background (`#F7F9F8`)**: Muted sage-tinted neutral surface minimizing eye fatigue across frequent daily logging sessions.
- **Surface (`#FFFFFF`)**: Pure crisp elevated planes for financial cards, sheets, and active dialogues.
- **Text & Content**:
  - `Text Primary` (`#111827`): Dominant copy, table entries, and bold currency figures (minimum 12:1 contrast against `#FFFFFF`).
  - `Text Secondary / Muted` (`#6B7280`): Timestamps, categorical subtitles, and secondary helper text (4.6:1 contrast against `#FFFFFF`).
- **Semantic Feedback**:
  - `Success Green` (`#16A34A` / Container `#DCFCE7`): Salary credits, positive cash flow, and fulfilled savings milestones.
  - `Warning / Critical Red` (`#DC2626` / Container `#FEE2E2`): Budget overshoots, pending EMI deadlines, and high-spend alerts.

## Typography

The type system is powered entirely by `Inter`, celebrated for its neutral grotesque proportions, open counters, and robust OpenType tabular lining figures (`tnum`).

### Rupee Formatting & Numerical Rules
- Enable tabular figures (`font-feature-settings: "tnum"`) across all monetary tables, spending summaries, and card balances to align decimal points and grouping commas.
- Strictly adhere to the Indian lakh and crore numbering system (e.g., `₹1,25,000` rather than `₹125,000`).
- The Rupee symbol (`₹`) is rendered in the same weight and font as the numerical figure, with no whitespace separating the symbol and the first digit.
- `display-currency` is reserved for total balance views, net disposable salary, and primary monthly run-rate metrics.

## Layout & Spacing

The layout is built for native mobile ergonomics using a fluid 4-column grid on standard handheld screens (360px–420px width), with 16px screen margins (`margin: 1rem`) and 16px column gutters (`gutter: 1rem`).

### Grid & Density Rules
- **Base Grid**: 8px spatial grid with an underlying 4px half-step for micro-alignments (such as icon-to-label offsets and badge padding).
- **Touch Target Integrity**: All tap areas (navigation icons, list items, quick-add buttons) must evaluate to at least 48×48px physical bounds, regardless of the visual glyph size.
- **Safe Areas**: Top margins accommodate status bars dynamically with 12px additional padding; bottom screen bounds reserve 80px for the persistent navigation bar and device gesture indicators.

## Elevation & Depth

This system utilizes Material 3 surface container tiers and diffuse, ambient ambient shadows to distinguish layers without visual heaviness.

- **Level 0 (Base Canvas)**: `#F7F9F8` — No shadow, edge-to-edge canvas.
- **Level 1 (Cards & Feed Items)**: `#FFFFFF` — `0px 1px 3px rgba(17, 24, 39, 0.05), 0px 1px 2px rgba(17, 24, 39, 0.03)`. Subtle boundary complemented by a 1px border using `rgba(17, 24, 39, 0.06)`.
- **Level 2 (Active Sheets & Bottom Bar)**: `#FFFFFF` — `0px 4px 6px -1px rgba(17, 24, 39, 0.06), 0px 2px 4px -2px rgba(17, 24, 39, 0.04)`.
- **Level 3 (Modals & Floating Action Trigger)**: `#FFFFFF` or `#0F766E` — `0px 10px 15px -3px rgba(15, 118, 110, 0.15), 0px 4px 6px -4px rgba(17, 24, 39, 0.05)`. Tinted teal diffusion for high-priority transaction entry.

## Shapes

The design system embraces Material 3's friendly, protective curves:
- **Cards & Primary Modules**: 16px (`1rem` / rounded-2xl). Provides an approachable, card-centric rhythm for modular spends.
- **Input Fields & Action Trays**: 12px (`0.75rem`) corner rounding.
- **Badges, Filter Chips & Primary Buttons**: Fully rounded pill shapes (`9999px`) to invite thumb interaction and distinguish controls from structural content cards.

## Components

### Buttons
- **Filled Primary**: `#0F766E` background with `#FFFFFF` text, 48px height, full-pill corner radius (`9999px`). Pressed state activates a 12% black overlay.
- **Tonal Button**: `#E6F4F2` container with `#0F766E` text, used for secondary flows such as "Split Spend" or "Download Statement".
- **Floating Action Button (FAB)**: 56×56px square with 16px rounded corners, rendered in `#0F766E` with a white plus glyph for instantaneous expense addition.

### Cards
- **Spend & Summary Cards**: `#FFFFFF` background, 16px border-radius, 16px inner padding, bounded by a 1px outline of `#E5E7EB`.
- **Category Comparison Cards**: Split-tone headers pairing `#0D9488` ("Needs") and `#F59E0B` ("Wants") progress indicators against a neutral track (`#E5E7EB`).

### Inputs & Transaction Fields
- **Amount Input**: Giant tabular display field with leading `₹` glyph, underline or filled container with `#E6F4F2` active tint, clear button, and contextual category pickers.
- **Dropdown & Text Fields**: 52px height, 12px corner radius, outline style with `#6B7280` dormant and `#0F766E` active borders.

### Chips & Badges
- **Category Chips**: 32px height, pill-shaped. Inactive chips have a 1px border (`#E5E7EB`) on transparent fill; selected chips receive `#E6F4F2` background with `#0F766E` text and a trailing check icon.

### List Items
- **Transaction Row**: Minimum 64px height. Left: 40×40px circular category icon container (tinted with category color). Center: Merchant/Title (`title-md`) and subtext date/category (`body-sm`). Right: Bold Indian format rupee total (`title-md`) colored green for credit or dark grey for debit.

### Bottom Navigation Bar (5 Tabs)
- **Bar Specification**: Fixed 80px height anchored to the bottom viewport edge, `#FFFFFF` background with a subtle top border (`1px solid #E5E7EB`).
- **Structure**: 5 equal distribution slots:
  1. `Home`: Dashboard, net salary status, quick glance.
  2. `Spends`: Chronological and categorical transaction feed.
  3. `Recurring`: Fixed EMIs, rent, SIPs, and automated bills.
  4. `Analytics`: Needs vs. Wants distribution, monthly delta.
  5. `Goals`: Target tracking, emergency fund, and savings buckets.
- **Active State**: Pill-shaped container indicator (`#E6F4F2`) framing an `#0F766E` icon, accompanied by a 12px medium label. Inactive tabs display `#6B7280` icon and text.