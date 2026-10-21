# Platform parity

Shared contract: tokens (`tokens/**`) + each `components/<name>/<name>.component.yml` (props, enums, slots).
Twig/CSS is the reference; Flutter widgets mirror prop names (snake_case -> camelCase).

| Component | Twig (Drupal SDC `volva_ds:*`) | Flutter |
|---|---|---|
| button | yes | `VdsButton` (+ `.icon`) |
| badge | yes | `VdsBadge` |
| chip | yes | `VdsChip` |
| rating | yes | `VdsRating` |
| price | yes | `VdsPrice` |
| avatar | yes | `VdsAvatar` |
| input | yes | via `VolvaTheme` `InputDecorationTheme` |
| textarea, select, checkbox, radio, switch | yes | not ported yet |
| search-bar | yes | `VdsSearchBar` |
| empty-state | yes | `VdsEmptyState` |
| vendor-card | yes | `VdsVendorCard` (+ `.skeleton`) |
| product-card | yes | `VdsProductCard` |
| map-pin | yes | `VdsMapPin` |
| filter-bar, contact-card, image-gallery, listing-grid, vendor-header, product-detail, map-popup-card, map-search-layout | yes | not ported yet |
| pagination, breadcrumb, site-header, site-footer | yes | web only |

Tokens: `npm run tokens` writes `dist/css/tokens.css` (Drupal/Storybook) and
`packages/volva_ds_flutter/lib/src/tokens/vds_tokens.dart` (`Vds<Group>Tokens` classes). Both are generated; edit `tokens/**` only.
