# Volva Design System (VDS)

One design system for the Volva listing platform (vendors, vendor profiles, products, product detail, search, map search), consumed by:

- **Drupal** – Twig Single Directory Components (SDC) + CSS, exposed as the `volva_ds` base theme.
- **Flutter** – the `volva_ds_flutter` package (generated tokens, `ThemeData`, widgets).
- **Storybook** – living documentation, rendering the *same* Twig files Drupal uses.

Twig and Flutter can't share UI code, so what is shared is the **contract**:

1. **Design tokens** (`tokens/**`) – single source for color, type, spacing, radius, shadow, breakpoints, motion, plus per-component tokens.
2. **Component specs** (`components/<name>/<name>.component.yml`) – props, enums (variants/sizes) and slots. Flutter widgets mirror these names.

```
tokens/**  ──(Style Dictionary)──►  dist/css/tokens.css                          (Drupal, Storybook)
                                ►  packages/volva_ds_flutter/lib/src/tokens/vds_tokens.dart   (Flutter)
                                ►  dist/json/tokens.json                          (reference)

components/<name>/{.component.yml, .twig, .css, .stories.js}   ──►  Drupal SDC `volva_ds:<name>` + Storybook
```

> Generated files (`dist/**`, `vds_tokens.dart`) are never edited by hand. Change `tokens/**` and rebuild.

---

## Repository layout

```
tokens/
  global/       primitives: palette, space, radius, font, shadow, breakpoints, motion   ← GLOBAL config
  semantic/     intent aliases: color.brand.*, color.surface.*, color.text.*, color.status.*
  component/    per-component tokens: button, card, badge, input, chip, rating, map     ← COMPONENT config
components/     Twig + CSS + yml spec + stories, one folder per component
styles/base.css global reset/typography (tokens only)
.storybook/     Storybook config (twig plugin, viewports)
drupal/volva_ds/                 Drupal base theme (symlinks into components/, dist/, styles/)
packages/volva_ds_flutter/       Flutter package
scripts/check-components.mjs     contract check
scripts/build-drupal-theme.mjs   assembles the Composer-installable theme (build/volva_ds)
.github/workflows/               publishes the built theme to the `drupal-theme` branch
docs/parity.md                   Twig ↔ Flutter component map
```

## Quick start

Requires Node 20+ (developed on Node 26).

```bash
npm install
npm run tokens          # build CSS / Dart / JSON tokens (run after any token change)
npm run storybook       # http://localhost:6006
npm run build-storybook # static build -> storybook-static/
npm run check           # every component has yml + twig + css + stories, yml parses
npm run build:drupal    # build/volva_ds = symlink-free, Composer-installable Drupal theme
```

---

## Tokens: global vs component configuration

Three layers; each only references the layer above it.

| Layer | Folder | Example | Purpose |
|---|---|---|---|
| Global | `tokens/global` | `palette.brand.600`, `space.4`, `radius.md` | Raw values. Rebranding = edit here. |
| Semantic | `tokens/semantic` | `color.brand.default` → `{palette.brand.600}` | Meaning (brand, surface, text, status). |
| Component | `tokens/component` | `button.primary.bg` → `{color.brand.default}` | Per-component knobs. |

Files use the W3C DTCG format (`$value`, `$type`). Aliases use `{path.to.token}`.

Output naming:

| Token | CSS variable | Dart |
|---|---|---|
| `color.brand.default` | `--vds-color-brand-default` | `VdsColorTokens.brandDefault` |
| `space.4` | `--vds-space-4` | `VdsSpaceTokens.n4` |
| `button.primary.bg` | `--vds-button-primary-bg` | `VdsButtonTokens.primaryBg` |

### Changing the brand

Edit `tokens/global/palette.json` (e.g. the `brand` ramp) or `tokens/global/foundation.json` (font family, radii…), then `npm run tokens`. Both platforms update from the same edit. Current values are **placeholders** pending Volva brand assets.

### Colour themes (ocean, sunset, forest, plum, dusk)

`themes/<name>.json` overrides `palette.brand` and, where a palette calls for it, a few other palette values (`sunset` and `dusk` also set cream surfaces via `palette.neutral`; `sunset` sets the rating star via `palette.warning.500`). `npm run tokens` builds each into `dist/css/themes/<name>.css`, scoped to `[data-vds-theme="<name>"]`, containing just the tokens that change (the ramp and everything derived from it). With no attribute you get the default teal brand.

```html
<html data-vds-theme="sunset">   <!-- or any wrapper element, to theme just a region -->
```

- **Storybook**: use the *Theme* toolbar dropdown.
- **Drupal**: all four stylesheets ship in the `global` library; set the attribute from your sub-theme (e.g. `$variables['attributes']['data-vds-theme']` in `hook_preprocess_html`).
- **New theme**: add `themes/<name>.json` with a `palette.brand` ramp (50–900; keep 600/700 at ≥4.5:1 on white), then list its CSS in `volva_ds.libraries.yml` and `.storybook/preview.js`.
- **Flutter** is not themed yet; it still builds from the default ramp.

### Adding a component token

1. Create or edit `tokens/component/<name>.json`, referencing semantic tokens.
2. `npm run tokens`.
3. Use `var(--vds-<name>-…)` in the component CSS and `Vds<Name>Tokens.…` in the Flutter widget.

---

## Using VDS in Drupal

### Requirements

Drupal **10.3+** (SDC in core). Node is only needed at build time to generate tokens.

### Install

1. Build tokens: `npm run tokens` (generates `dist/css/tokens.css`).
2. Put the theme in your Drupal codebase as `web/themes/custom/volva_ds` — preferably via Composer (next section); for a manual install use the output of `npm run build:drupal` (`build/volva_ds/`).
3. Create a sub-theme (recommended) with `base theme: volva_ds` in its `.info.yml`, enable and set as default:

   ```yaml
   # my_site_theme.info.yml
   name: My Site Theme
   type: theme
   base theme: volva_ds
   core_version_requirement: ^10.3 || ^11
   ```

   ```bash
   drush theme:install my_site_theme && drush config-set system.theme default my_site_theme -y && drush cr
   ```

`volva_ds.libraries.yml` attaches `tokens.css` and `base.css` globally. **Component CSS is attached automatically** by SDC when a component renders.

### Install via Composer

`drupal/volva_ds/` in this repo is a dev layout (it uses symlinks), so Drupal projects install a **built package** instead. The GitHub Action `.github/workflows/publish-drupal-theme.yml` builds it on every push to `main` (when tokens, components, styles or theme files change) and commits the result to the **`drupal-theme`** branch (a normal commit per change, so history is kept and tags stay valid). That branch has `composer.json` at its root, a real `volva_ds.info.yml`, the generated `dist/css/tokens.css`, `styles/` and `components/` (no stories, no symlinks).

**1. Cut a release (manual).** Tag the built branch, not `main`:

```bash
git fetch origin drupal-theme
git tag v0.1.0 origin/drupal-theme
git push origin v0.1.0
```

**2. Require it in the Drupal project's `composer.json`:**

```json
{
  "repositories": [
    { "type": "vcs", "url": "git@github.com:nexlified/volva-design-system.git" }
  ],
  "extra": {
    "installer-paths": {
      "web/themes/custom/{$name}": ["vendor:volva"]
    }
  }
}
```

```bash
composer require volva/volva_ds:^0.1     # tagged release
composer require volva/volva_ds:dev-drupal-theme   # latest build, for testing before a tag exists
```

`installer-paths` places the theme in `web/themes/custom/volva_ds` rather than `contrib`. Private repositories need Composer credentials (`composer config github-oauth.github.com <token>` or an SSH key on the build/deploy host).

**Local development.** Use a `path` repository so edits in this repo show up in Drupal immediately (the dev theme's symlinks resolve because it is symlinked, not copied):

```json
{ "type": "path", "url": "../vds/drupal/volva_ds", "options": { "symlink": true } }
```

Run `npm run tokens` in this repo to refresh `dist/css/tokens.css`.

**Build the package locally** (what CI runs): `npm run build:drupal` writes `build/volva_ds/`.

### Render a component

Components are addressed as `volva_ds:<name>`. In any Twig template:

```twig
{# Atom #}
{% include 'volva_ds:button' with { label: 'Contact vendor', variant: 'primary', size: 'lg', href: path('entity.node.canonical', {node: 5}) } only %}

{# Vendor card from a node #}
{% include 'volva_ds:vendor-card' with {
  name: node.label,
  href: path('entity.node.canonical', {node: node.id}),
  image: file_url(node.field_cover.entity.fileuri),
  category: node.field_category.entity.label,
  location: node.field_city.value,
  rating: node.field_rating.value,
  review_count: node.field_review_count.value,
  verified: node.field_verified.value,
} only %}
```

Use `only` so templates receive just the props you pass. Props, enum values and defaults for each component are in its `components/<name>/<name>.component.yml`. Components take **already-formatted strings** for things like price and distance — currency/locale formatting stays in Drupal.

### Slots (`embed`)

Components with slots (`listing-grid`, `map-search-layout`) use Twig blocks:

```twig
{% embed 'volva_ds:listing-grid' with { layout: 'grid', min_column: '260px' } only %}
  {% block items %}
    {% for node in nodes %}
      {% include 'volva_ds:product-card' with { title: node.label, price: node.price } only %}
    {% endfor %}
  {% endblock %}
{% endembed %}
```

```twig
{% embed 'volva_ds:map-search-layout' with { view: 'list' } only %}
  {% block filters %}{% include 'volva_ds:filter-bar' with { filters: filters } only %}{% endblock %}
  {% block results %}{# cards #}{% endblock %}
  {% block map %}<div id="map"></div>{# Leaflet / Google Maps / Mapbox attaches here #}{% endblock %}
{% endembed %}
```

The design system provides map **chrome** only (`map-pin`, `map-popup-card`, `map-search-layout`). The map canvas and clustering come from your map library; render markers with `volva_ds:map-pin`.

### Theming and overrides (in your sub-theme CSS, no component edits)

```css
/* Brand-wide */
:root { --vds-color-brand-default: #7c3aed; --vds-font-family-sans: "Poppins", sans-serif; }

/* Scoped to a region or a single component */
.region-hero { --vds-button-radius: 999px; --vds-card-radius: 20px; }
```

Overriding the *semantic* tokens re-themes every component using them; overriding a *component* token affects only that component.

### Mapping Drupal data → props

Keep mapping in preprocess or entity view-mode templates, not in the design system:

```php
function my_site_theme_preprocess_node__vendor__teaser(array &$variables): void {
  $node = $variables['node'];
  $variables['vds'] = [
    'name' => $node->label(),
    'rating' => (float) $node->get('field_rating')->value,
  ];
}
```

```twig
{# node--vendor--teaser.html.twig #}
{% include 'volva_ds:vendor-card' with vds|merge({ href: url }) only %}
```

### Troubleshooting

| Symptom | Fix |
|---|---|
| Unstyled / missing colors | `npm run tokens` was not run, or `dist/` symlink is broken; `drush cr`. |
| `volva_ds:button` not found | Theme not enabled/installed as `volva_ds`, or `components/` symlink broken; Drupal < 10.3. |
| Component renders but no CSS | Component not rendered through SDC (`include`/`embed` with the `volva_ds:` id); clear caches. |

---

## Using VDS in Flutter

### Requirements

Flutter **3.22+** / Dart 3.3+.

### Install

The package is local to this repo. In the app's `pubspec.yaml`:

```yaml
dependencies:
  volva_ds_flutter:
    path: ../vds/packages/volva_ds_flutter   # or a git: dependency with `path: packages/volva_ds_flutter`
```

If tokens changed, run `npm run tokens` in the VDS repo **before** building the app — `vds_tokens.dart` is generated and committed with the package.

### Apply the theme

```dart
import 'package:volva_ds_flutter/volva_ds_flutter.dart';

MaterialApp(
  theme: VolvaTheme.light(),   // ThemeData built only from generated tokens
  home: const HomeScreen(),
);
```

`VolvaTheme` maps tokens to `ColorScheme`, `TextTheme` and `InputDecorationTheme`, so plain `TextField`s and `Theme.of(context)` already follow the design system. The font family defaults to `Inter`; bundle the font in your app's `pubspec.yaml` (or change the `font.family` token).

### Widgets

Widget names and props mirror the Twig components (snake_case → camelCase).

```dart
VdsButton(label: 'Contact vendor', variant: VdsButtonVariant.primary, size: VdsButtonSize.lg, fullWidth: true, onPressed: _contact);
const VdsButton.icon(label: 'Save', icon: Icons.favorite_border); // icon_only

VdsVendorCard(
  name: 'Clay & Co', image: url, category: 'Ceramics', location: 'Berlin', distance: '2.4 km',
  rating: 4.7, reviewCount: 213, verified: true, openNow: true, onTap: _openVendor,
);
const VdsVendorCard.skeleton();                       // loading placeholder

VdsProductCard(title: 'Stoneware mug', price: r'$32.00', compareAt: r'$40.00', badge: 'Sale', badgeTone: VdsBadgeTone.danger, onTap: _openProduct);

VdsSearchBar(queryController: q, locationController: loc, onSubmitted: _search);
VdsChip(label: 'Open now', active: true, onTap: _toggle);
VdsMapPin(label: r'$32', active: selected, onTap: _select);   // marker child for your map widget
VdsMapPin(label: '12', cluster: true);
```

Available: `VdsButton`, `VdsBadge`, `VdsChip`, `VdsRating`, `VdsPrice`, `VdsAvatar`, `VdsSearchBar`, `VdsEmptyState`, `VdsVendorCard`, `VdsProductCard`, `VdsMapPin`. Components not yet ported (filter-bar, contact-card, image-gallery, listing-grid, vendor-header, product-detail, map-popup-card, map-search-layout) are listed in [`docs/parity.md`](docs/parity.md) — build them in-app from tokens and the matching `component.yml`, or add them to the package.

As with Drupal, widgets take **pre-formatted strings** for price/distance; format with `intl` in the app.

### Using tokens directly

```dart
Container(
  padding: const EdgeInsets.all(VdsSpaceTokens.n4),
  decoration: BoxDecoration(
    color: VdsColorTokens.surfaceSubtle,
    borderRadius: BorderRadius.circular(VdsRadiusTokens.lg),
    boxShadow: const [VdsShadowTokens.md],
  ),
  child: Text('Hello', style: TextStyle(fontSize: VdsFontTokens.sizeLg, color: VdsColorTokens.textDefault)),
);
```

Breakpoints are `VdsBpTokens.sm/md/lg/xl` (640/768/1024/1280), matching the CSS media queries.

### Maps

The package ships marker chrome only. Use your map package (`google_maps_flutter`, `flutter_map`, …) and render `VdsMapPin` as the marker widget; on small screens show the selected item as a bottom sheet using the `map-popup-card` spec.

---

## Adding or changing a component

1. Add/modify tokens in `tokens/component/<name>.json` → `npm run tokens`.
2. Create `components/<name>/` with:
   - `<name>.component.yml` – props, enums, slots (the cross-platform contract). **Quote any `description` containing commas or colons** — Drupal's loader rejects invalid YAML.
   - `<name>.twig` – starts with `{% set attrs = attributes ?: create_attribute() %}` and renders `attrs.addClass([...])`. Include other components via `{% include 'volva_ds:<other>' with {...} only %}`.
   - `<name>.css` – uses only `var(--vds-…)` tokens and `.vds-<name>` classes (no hard-coded colors/sizes).
   - `<name>.stories.js` – a `Playground` story plus one story per variant/state (disabled, loading, empty, error, skeleton…).
3. Add the Flutter widget in `packages/volva_ds_flutter/lib/src/widgets/` (same prop names), export it from `lib/volva_ds_flutter.dart`, and update `docs/parity.md`.
4. Verify: `npm run check && npm run build-storybook`; in the Flutter package `dart analyze`.

Conventions: BEM-ish `vds-<component>__element--modifier`; accessibility is part of the component (labels, `aria-*`, focus styles, `prefers-reduced-motion`); no component reads another component's CSS variables.

## Known limitations

- Brand tokens (colors, `Inter` font, logo) are placeholders.
- Light theme only; no dark mode.
- Flutter package has not yet been compiled/analyzed in this repo's environment — run `flutter pub get && dart analyze` before first use.
- Partial Flutter widget coverage (see `docs/parity.md`).
- Page-level Storybook compositions (vendor list, vendor profile, product page, search) are not yet written.
