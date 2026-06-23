# Final Shark Tank Scroll Cleanup Handoff - 2026-06-22

## Purpose

This handoff is for a new Codex conversation to make a final local-only cleanup pass on the finalized Shark Tank presentation files before they are handed to the presenter.

The work should happen in the user's finalized desktop folder, not as a repo-tracked source change.

## Finalized Presentation Folder

User-provided folder:

```text
C:\Users\gzxvand\OneDrive - CSAA IG\Desktop\Agent Accelerator - shark tank
```

Observed files in that folder:

```text
backup\
agent-readiness-accelerator-final-pitch-script-2026-06.md
agent-readiness-accelerator-premium-scroll.html
agent-readiness-accelerator-premium-scroll.js
Doc_Steward_demo_highlighted_clean.png
Release_Health_Analyst_demo_highlighted_clean.png
Rovo_Design_Agent_demo_highlighted_clean.png
```

## User Goal

Create an edited version of the finalized HTML/JS presentation while preserving the original files.

The user is doing a final sweep before handing off the HTML and JavaScript to the presenter. They will share their screen separately for showing the agents and the Release Health Analyst report.

## Requested Changes

### 1. Remove First-Slide Jump Button Functionality

On the first slide, there are two buttons:

- `Get to the deal`
- `Show the pattern`

The user wants this functionality removed because the presenter will scroll through the slides one by one.

Preferred implementation:

- Remove the two visible buttons from the first slide entirely, or convert the hero area so no jump CTAs appear.
- Remove or safely leave unused any JS handlers for those button targets, depending on the least risky local change.
- Preserve normal slide/scroll behavior.

Do not remove the ability to progress through the presentation normally.

### 2. Improve First-Slide Infographic

The right-side first-slide infographic currently has:

- `Agent Readiness Accelerator` in the middle
- surrounding labels such as `Fit Intake`, `Source Review`, `Human Launch`, and `Measurement`

The user feels the graphic is unclear and could look better.

Recommended direction:

- Make the graphic more plainly represent the readiness flow.
- Suggested visual concept:
  - Center: `Agent Readiness Accelerator`
  - Four clearer surrounding stages:
    - `Intake`
    - `Source + Risk Review`
    - `Readiness Evidence`
    - `Human Approval`
  - Optional footer label: `Guided support today -> approved Agent Lab path next`
- Make it visually cleaner and easier for an audience to understand at a glance.
- Avoid adding technical detail or process clutter.

Keep the tone consistent with the existing Shark Tank / executive design.

## File Handling Requirements

Do **not** overwrite the original finalized files directly.

Recommended approach:

1. Copy:
   - `agent-readiness-accelerator-premium-scroll.html`
   - `agent-readiness-accelerator-premium-scroll.js`
2. Create edited copies in the same desktop folder, for example:
   - `agent-readiness-accelerator-premium-scroll-edited.html`
   - `agent-readiness-accelerator-premium-scroll-edited.js`
3. Update the edited HTML to reference the edited JS if the JS is copied or changed.
4. Leave the originals untouched.

The folder already contains a `backup` directory, but still create a clearly named edited copy rather than relying only on backup.

## Boundaries

- This is a local presentation-file cleanup, not a repo governance content change.
- Do not publish to Confluence.
- Do not update ROVO Studio.
- Do not update Jira.
- Do not add raw screenshots or local desktop assets to Git.
- Do not change the presenter script unless explicitly requested.

## Suggested Implementation Steps

1. Inspect the finalized HTML and JS in the desktop folder.
2. Identify the first slide markup and the two jump buttons.
3. Copy the HTML/JS to edited filenames.
4. Remove the first-slide jump buttons from the edited HTML.
5. Update or remove any matching JS click handlers if needed.
6. Rework the first-slide infographic markup/CSS in the edited HTML.
7. Open the edited HTML in a browser and verify:
   - first slide has no jump buttons,
   - normal slide scrolling/navigation still works,
   - revised infographic is visually clear,
   - no clipping at presentation size,
   - linked image assets still render.
8. Keep the original files untouched.

## Validation Checklist

Run or manually verify:

- `git status --short` from the repo to confirm no accidental repo changes unless the handoff itself is being tracked.
- Browser preview of the edited desktop HTML.
- First slide visual check at fullscreen or presenter resolution.
- Keyboard/scroll progression through the deck.
- No missing images or broken JS references.
- Original desktop HTML/JS still exist unchanged.

## Suggested Final Response For Next Session

When complete, report:

- Edited file names created.
- Whether original files were preserved.
- What changed on slide 1.
- How the infographic was revised.
- What validation was performed.
- Any remaining caveats for the presenter.

## Notes For Next Session

This cleanup should be treated as a presentation polish pass. The user is not asking to redesign the whole deck, change the pitch strategy, or update the repo source deck. Keep the change narrow and presenter-safe.
