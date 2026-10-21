# volva_ds (Drupal base theme)

Components live in `../../components` and are symlinked here as `components/`, so Drupal core's
Single Directory Components (10.3+) discovers them as `volva_ds:<name>` — the same ids Storybook uses.

Setup:
1. `npm run tokens` in the repo root (generates `dist/css/tokens.css`).
2. Place/symlink this folder into `web/themes/custom/volva_ds` and set it as base theme of your site theme.
   For deployments that can't follow symlinks, replace the three symlinks with real copies in your build step.

Use a component from any template:

    {% include 'volva_ds:vendor-card' with { name: node.label.value, rating: 4.5 } only %}

Overriding (in a sub-theme, no component edits needed):
- Brand-wide: redefine `--vds-color-brand-*`, `--vds-font-family-sans`, … on `:root`.
- Per component: redefine its tokens, e.g. `.my-section { --vds-button-radius: 999px; }`.
