---
name: brand-guidelines
description: Brand guidelines for the product -- color palette, typography, spacing, component states, and voice. Loaded by the Designer agent when producing mocks to ensure visual consistency across features.
---

# Brand Guidelines

**Keywords**: brand, branding, visual identity, design tokens, color palette, typography, spacing, component states, voice and tone, brand compliance, style guide, design system

This file is the single source of truth for visual consistency. The Designer reads it before producing any mocks. Fill in each section after install -- even partial definitions (just colors + typography) are better than none.

---

## Color palette

Define all colors as tokens. Use these token names in mocks and CSS -- never raw hex values.

| Token | Hex | Usage |
|---|---|---|
| `color-primary` | `#______` | Primary actions, links, active states |
| `color-primary-hover` | `#______` | Hover state for primary |
| `color-primary-subtle` | `#______` | Backgrounds, badges using primary color |
| `color-secondary` | `#______` | Secondary actions |
| `color-neutral-900` | `#______` | Body text, headings |
| `color-neutral-600` | `#______` | Secondary text, labels |
| `color-neutral-300` | `#______` | Borders, dividers |
| `color-neutral-100` | `#______` | Subtle backgrounds |
| `color-neutral-0` | `#ffffff` | White / card backgrounds |
| `color-success` | `#______` | Success states, confirmations |
| `color-warning` | `#______` | Warnings, caution states |
| `color-error` | `#______` | Errors, destructive actions |
| `color-info` | `#______` | Informational states |
| `color-surface` | `#______` | Page background |

---

## Typography

| Token | Font family | Weight | Size | Line height | Usage |
|---|---|---|---|---|---|
| `text-display` | ________ | __ | __px | __ | Hero headings |
| `text-h1` | ________ | __ | __px | __ | Page titles |
| `text-h2` | ________ | __ | __px | __ | Section headings |
| `text-h3` | ________ | __ | __px | __ | Card headings, subsections |
| `text-body-lg` | ________ | __ | __px | __ | Primary body text |
| `text-body` | ________ | __ | __px | __ | Default body text |
| `text-body-sm` | ________ | __ | __px | __ | Secondary body, captions |
| `text-label` | ________ | __ | __px | __ | Form labels, tags |
| `text-code` | ________ | __ | __px | __ | Code snippets |

Font stack: `________` (primary), `________` (fallback)

---

## Spacing system

Base unit: `__px` (typically 4px or 8px)

| Token | Value | Usage |
|---|---|---|
| `space-1` | __px | Tight gaps (icon + label) |
| `space-2` | __px | Inner padding (compact) |
| `space-3` | __px | Inner padding (default) |
| `space-4` | __px | Component gaps |
| `space-6` | __px | Section gaps (small) |
| `space-8` | __px | Section gaps (medium) |
| `space-12` | __px | Layout gaps |
| `space-16` | __px | Page sections |

---

## Shape and elevation

| Token | Value | Usage |
|---|---|---|
| `radius-sm` | __px | Inputs, tags |
| `radius-md` | __px | Cards, buttons, modals |
| `radius-lg` | __px | Sheets, large surfaces |
| `radius-full` | 9999px | Pills, avatars |
| `shadow-sm` | ________ | Subtle lift (dropdowns) |
| `shadow-md` | ________ | Cards, popovers |
| `shadow-lg` | ________ | Modals, dialogs |

---

## Core component states

Every interactive component must handle all states. Use the color tokens above -- do not introduce new colors.

| State | Visual treatment |
|---|---|
| Default | ________ |
| Hover | ________ |
| Active / pressed | ________ |
| Focus (keyboard) | `color-primary` outline, 2px offset |
| Disabled | 40% opacity, no pointer events |
| Loading | Skeleton or spinner using `color-neutral-300` |
| Error | `color-error` border + message below field |
| Success | `color-success` indicator |

---

## Button hierarchy

| Variant | When to use | Background | Text | Border |
|---|---|---|---|---|
| Primary | Main CTA, one per view | `color-primary` | white | none |
| Secondary | Supporting action | white | `color-primary` | `color-primary` |
| Tertiary / ghost | Low-emphasis action | transparent | `color-primary` | none |
| Destructive | Irreversible action | `color-error` | white | none |
| Disabled | Any unavailable action | `color-neutral-100` | `color-neutral-300` | none |

---

## Iconography

Icon library: `________` (e.g. Lucide, Heroicons, Material Icons)
Default size: `__px`
Color: inherits from text color unless specified

Rules:
- Never use icons without a text label or tooltip (accessibility)
- Use filled variants for active/selected state, outline for default

---

## Voice and tone

| Situation | Tone | Example |
|---|---|---|
| Empty state | Helpful, action-oriented | "No items yet. [Create your first one]" |
| Error message | Clear, non-blaming | "Something went wrong. Try again or contact support." |
| Success confirmation | Brief, positive | "Saved." / "Changes applied." |
| Destructive confirmation | Direct, consequence-first | "Delete this item? This can't be undone." |
| Loading | Minimal | "Loading..." or no text if under 1s |

Writing rules:
- Sentence case for all UI text (not Title Case)
- No exclamation marks except onboarding
- Avoid technical jargon in user-facing copy

---

## What the Designer must do with this

Before producing any mock:
1. Use only tokens defined above -- no ad-hoc colors, sizes, or fonts
2. Include all component states in every mock (hover, disabled, error, loading)
3. If a new pattern is needed that isn't covered here, flag it explicitly -- do not invent ad-hoc styles silently
4. After completing mocks, note any token gaps discovered (patterns needed but not defined)
