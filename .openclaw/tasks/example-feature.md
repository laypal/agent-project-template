# Feature: Example Feature

## Requirements (VERBATIM - implement exactly as written)

1. Component renders a greeting message with the user's name
2. Clicking the "Dismiss" button hides the greeting
3. Greeting reappears after page refresh (no persistence)

## Target Files

- CREATE: `src/features/example/components/greeting.tsx`
- CREATE: `src/features/example/components/__tests__/greeting.test.tsx`

## Context

- Use shadcn Card component for the greeting container
- Follow existing component patterns in src/features/

## Non-Goals (DO NOT implement)

- No localStorage persistence
- No animation on dismiss

## Acceptance Criteria

- `npx vitest run src/features/example/components/__tests__/greeting.test.tsx` passes
- `npm run lint` passes
- `npx tsc --noEmit` passes
