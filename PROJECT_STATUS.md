# PROJECT_CONTEXT.md

# CozyVerse

**Version:** 0.1.0

---

# Vision

CozyVerse is a premium Flutter application designed for people who love books, movies, and TV series.

The app is not intended to be another recommendation platform.

It should feel like a cozy companion where users discover stories based on their mood, build memories around what they watch or read, and slowly create their own magical story universe.

Every interaction should feel warm, relaxing and delightful.

The goal is to make users excited to open the app every evening.

---

# Core Philosophy

CozyVerse is about emotions rather than content.

The app should answer questions like:

* What should I read tonight?
* What matches my current mood?
* What have I loved recently?
* Which stories changed me?
* What memories do I associate with those stories?

The app should encourage reflection, comfort and discovery.

---

# Target Audience

People who enjoy:

* Books
* Movies
* TV Series
* K-Dramas
* Turkish dramas
* Anime
* Cozy games
* Storytelling
* Journaling

Age:

16–35

---

# Design Language

Every screen should feel:

* Cozy
* Calm
* Minimal
* Magical
* Elegant
* Premium
* Warm
* Soft
* Whimsical

Never design screens that feel like dashboards.

Prefer breathing room over information density.

Less is more.

---

# Visual Style

Inspired by:

* Stardew Valley
* Animal Crossing
* Fantasy journals
* Cozy cafés
* Reading corners
* Pixel art
* Storybooks
* Pastel illustrations

Use:

* Soft gradients
* Rounded corners
* Floating cards
* Gentle shadows
* Cream backgrounds
* Lavender accents
* Pixel-art illustrations

Avoid:

* Harsh colors
* Sharp corners
* Busy layouts
* Corporate-looking UI
* Material dashboard appearance

---

# Illustration Rules

Only use original CozyVerse artwork.

Never use copyrighted posters.

Never recreate official artwork.

Illustrations should be inspired by the atmosphere of the story.

Examples:

Harry Potter

* castle
* owl
* wand
* floating spellbook

Gilmore Girls

* coffee
* autumn leaves
* gazebo

The Hobbit

* mountain trail
* backpack
* map
* sword

Indiana Jones

* temple
* compass
* whip
* treasure

Every illustration should use:

* pastel colors
* cozy pixel-art
* magical lighting
* clean composition

---

# Flutter Architecture

Flutter

Material 3

Reusable widgets

Modular structure

Clean separation between:

* Screens
* Widgets
* Models
* Data
* Theme

Avoid large build methods.

Refactor into reusable widgets whenever appropriate.

---

# Existing Features

✓ Home Screen

✓ Mood Selection

✓ Story Detail

✓ Bottom Navigation

✓ Hero Carousel

✓ Mood Recommendations

✓ Recommendation Cards

✓ Favorites

✓ Add To Library

✓ Monthly Progress

✓ Collections

---

# Features To Build

## Phase 1

* Premium Recommendation Cards
* Story Detail Redesign
* Library Screen
* Saved Screen

---

## Phase 2

* Story Journal
* Reading Timeline
* Watching Timeline
* Favorite Quotes

---

## Phase 3

* Story Memories
* Seasonal Recommendations
* Reading Challenges
* Watching Challenges
* Pixel Pet Companion

---

## Phase 4

* Community Reviews
* Public Ratings
* User Profiles
* Story Lists
* Friend Activity

---

# Home Screen Philosophy

The Home screen should answer:

"What should I experience today?"

Its purpose is inspiration.

It should never become cluttered.

The order should always be:

Greeting

↓

Hero Carousel

↓

Current Mood

↓

Mood-Based Recommendations

↓

Progress

↓

Collections

---

# Mood Screen Philosophy

The Mood screen is the emotional heart of CozyVerse.

It should immediately communicate emotion through illustrations.

Each mood should feel collectible.

Mood cards should resemble magical stickers.

---

# Story Detail Philosophy

The Story Detail screen should feel like opening the first page of a beautiful journal.

Large cover illustration.

Beautiful typography.

Soft spacing.

Encourage users to start their next story.

---

# Recommendation Philosophy

Recommendations should feel personal.

Always explain WHY a recommendation appears.

Every recommendation should communicate:

"This story fits how you're feeling today."

Never recommend randomly.

---

# Future Signature Features

Story Journal

Allow users to record:

* thoughts
* favorite moments
* emotions

Favorite Quotes

Allow users to save memorable lines.

Story Memories

Remember:

When they watched

Where they watched

Who they watched with

Favorite scenes

Timeline

Display the user's reading and watching journey across months and years.

Pixel Pet

A companion that grows as the user reads and watches stories.

---

# Coding Rules

Never redesign unrelated screens.

Never change navigation unless requested.

Never remove functionality.

Never change the color palette without permission.

Never modify business logic unless explicitly asked.

Only edit the files necessary.

Preserve animations whenever possible.

Prefer reusable widgets.

Keep the project modular.

---

# Asset Structure

assets/

illustrations/

moods/

recommendations/

icons/

pets/

empty_states/

backgrounds/

---

# Naming Conventions

snake_case

Examples:

harry_potter.png

story_detail_screen.dart

recommendation_card.dart

home_carousel.dart

---

# Long-Term Goal

The goal is not simply to build a Flutter application.

The goal is to build a memorable product.

A user should feel:

"This app understands my love for stories."

Every feature should strengthen that feeling.


---

# Current Development Status (June 2026)

## Current Phase

The project is currently in the **UI/UX polishing phase**.

No backend or APIs have been integrated yet.

All screens currently use static demo data.

The priority is to perfect the experience before connecting any real data.

Do **not** introduce Firebase, Supabase, authentication, databases, state management refactors, or API integrations unless explicitly requested.

---

# Completed Screens

The following screens already exist:

* Home
* Mood Selection
* Story Detail
* Library
* Saved Stories
* Profile

Future work should improve these screens rather than redesign them from scratch.

---

# Library Philosophy

The Library is **not** a reading tracker.

CozyVerse does **not** track reading progress, pages, episodes, or watch percentage.

Stories exist in only two states:

* Wishlist
* Completed

The Library should feel like a personal story collection rather than a productivity tool.

---

# Saved Screen Philosophy

The Saved screen only stores favorite stories.

It does **not** contain:

* Quotes
* Reviews
* Collections
* Journals

Only stories the user has favorited.

---

# Rating Philosophy

Personal ratings are one of the most important features of CozyVerse.

Every completed story should allow the user to leave a personal star rating.

Ratings represent the user's emotional experience rather than an objective review.

Community ratings may be shown on Story Detail pages but should never overwhelm the interface.

---

# Current Product Direction

CozyVerse is evolving into an app about **identity**, not consumption.

The goal is not simply helping users find stories.

The goal is helping users understand what kinds of stories they love.

Every feature should answer questions like:

* What stories make me happiest?
* What moods do I return to?
* What genres feel like home?
* What memories do I associate with stories?

The experience should feel reflective, personal, and emotionally meaningful.

---

# Development Priorities

Priority 1

* Polish every existing screen
* Improve illustrations
* Improve animations
* Improve empty states
* Improve micro-interactions

Priority 2

* Story Personality
* Story Memories
* Seasonal Recommendations
* Challenge System

Priority 3

* Backend
* APIs
* Database
* User Accounts
* Sync

Always finish UI and UX before implementing backend functionality.

---

# Cursor Development Rules

When modifying the project:

* Never redesign completed screens unless requested.
* Prefer improving existing components.
* Reuse widgets whenever possible.
* Keep the CozyVerse aesthetic consistent.
* Preserve spacing, typography, colors, and animations.
* Explain which files will be modified before making changes.
* Avoid unnecessary refactoring.
* Keep changes focused on the requested task only.

