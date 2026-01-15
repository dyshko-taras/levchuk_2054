# Visual Style Guide - Flutter Android App

## Overview
This design system is extracted from Figma frames for a sports team management application. Use these tokens and guidelines to maintain visual consistency across the Flutter Android app.

## Color Palette

### Primary Colors

#### Primary Blue
- **Hex:** `#276aa5`
- **Flutter:** `Color(0xFF276AA5)`
- **Usage:**
  - Primary buttons
  - Active states
  - Interactive elements
  - Links and CTAs

#### Dark Navy
- **Hex:** `#0a1628`
- **Flutter:** `Color(0xFF0A1628)`
- **Usage:**
  - App background
  - Card backgrounds
  - Modal overlays

#### Lime Green
- **Hex:** `#9fef00`
- **Flutter:** `Color(0xFF9FEF00)`
- **Usage:**
  - Success states
  - Positive actions
  - Active indicators
  - Success messages

#### Dark Red
- **Hex:** `#7f0000`
- **Flutter:** `Color(0xFF7F0000)`
- **Usage:**
  - Error states
  - Required field indicators
  - Delete actions
  - Warning messages

#### White
- **Hex:** `#ffffff`
- **Flutter:** `Color(0xFFFFFFFF)`
- **Usage:**
  - Primary text
  - Icons
  - Borders
  - Button text

### Overlay Colors (Transparency)

#### White Overlay 10%
- **RGBA:** `rgba(255, 255, 255, 0.1)`
- **Flutter:** `Color(0x1AFFFFFF)`
- **Usage:**
  - Subtle backgrounds
  - Disabled states
  - Glassmorphism effects

#### White Overlay 20%
- **RGBA:** `rgba(255, 255, 255, 0.2)`
- **Flutter:** `Color(0x33FFFFFF)`
- **Usage:**
  - Input backgrounds
  - Button backgrounds
  - Card accents
  - Borders

#### White Overlay 70%
- **RGBA:** `rgba(255, 255, 255, 0.7)`
- **Flutter:** `Color(0xB3FFFFFF)`
- **Usage:**
  - Placeholder text
  - Secondary text
  - Disabled text

## Typography

### Font Family
- **Primary Font:** Open Sans
- **Flutter Implementation:**
```dart
TextStyle(
  fontFamily: 'OpenSans',
)
```

### Font Sizes
- **Small:** 12.6px (~13sp in Flutter)
- **Medium:** 16.8px (~17sp in Flutter)

### Font Weights
- **Regular:** 400
- **SemiBold:** 600

## Spacing Scale

Use these spacing values for consistent padding and margins:
- **Level 1:** 3.5px (~4dp)
- **Level 2:** 7px (~7dp)
- **Level 3:** 12.6px (~13dp)
- **Level 4:** 17.5px (~18dp)
- **Level 5:** 25.2px (~25dp)

## Border Radius

- **Buttons:** 35px (rounded pill shape)
- **Cards:** 14px (slightly rounded corners)

## Effects

### Shadows
- **Standard Shadow:** 0px 1.4px 1.4px 0px rgba(0, 0, 0, 0.25)
- **Flutter BoxShadow:**
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.25),
  offset: Offset(0, 1.4),
  blurRadius: 1.4,
)
```

### Backdrop Blur
- **Range:** 0.7px - 1.75px
- **Flutter:** Use `BackdropFilter` widget with `ImageFilter.blur`

## Component Patterns

### Buttons
- **Border:** 1.05px with rgba(255,255,255,0.2)
- **Padding:** 3.5px to 12.6px
- **Border Radius:** 35px (pill shape)
- **Background:** Primary blue or white overlays
- **States:** Use opacity and backdrop blur for hover/active states

### Input Fields
- **Background:** rgba(255,255,255,0.2) with backdrop blur
- **Border:** 1.05px rgba(255,255,255,0.2)
- **Border Radius:** 35px
- **Placeholder Color:** rgba(255,255,255,0.7)
- **Icon Position:** Right-aligned edit icons

### Cards
- **Background:** Dark navy with subtle overlay
- **Border Radius:** 14px
- **Shadow:** Standard shadow (0px 1.4px 1.4px rgba(0,0,0,0.25))
- **Padding:** 17.5px

## LLM Usage Guidelines

When generating Flutter code based on this design system:

1. **Color References:** Always use the defined Color values from this guide
2. **Spacing:** Use the spacing scale for all padding/margin values
3. **Typography:** Apply Open Sans font family with specified weights
4. **Components:** Follow the component patterns for consistency
5. **States:** Implement hover, active, and disabled states using opacity overlays
6. **Accessibility:** Ensure sufficient contrast ratios for text readability
7. **Responsive:** Design should adapt to different Android screen sizes

## Flutter Theme Setup

```dart
ThemeData(
  primaryColor: Color(0xFF276AA5),
  scaffoldBackgroundColor: Color(0xFF0A1628),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF276AA5),
    secondary: Color(0xFF9FEF00),
    error: Color(0xFF7F0000),
    background: Color(0xFF0A1628),
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 13,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
)
```
