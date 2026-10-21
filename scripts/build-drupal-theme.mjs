// Assemble a self-contained, symlink-free Drupal theme package in build/volva_ds/.
// Requires dist/css/tokens.css (run `npm run tokens` first, or use `npm run build:drupal`).
import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';

const repo = new URL('../', import.meta.url).pathname;
const src = join(repo, 'drupal/volva_ds');
const out = join(repo, 'build/volva_ds');

if (!existsSync(join(repo, 'dist/css/tokens.css'))) {
  console.error('dist/css/tokens.css missing - run `npm run tokens` first.');
  process.exit(1);
}

rmSync(out, { recursive: true, force: true });
mkdirSync(join(out, 'dist/css'), { recursive: true });
mkdirSync(join(out, 'styles'), { recursive: true });

// Theme metadata (the symlinks in drupal/volva_ds are dev-only and are skipped).
for (const f of ['volva_ds.info.yml', 'volva_ds.libraries.yml', 'composer.json', 'README.md']) {
  cpSync(join(src, f), join(out, f));
}
cpSync(join(repo, 'dist/css/tokens.css'), join(out, 'dist/css/tokens.css'));
cpSync(join(repo, 'styles/base.css'), join(out, 'styles/base.css'));
cpSync(join(repo, 'styles/typography.css'), join(out, 'styles/typography.css'));
// Components: twig + css + yml only; stories are Storybook-only.
cpSync(join(repo, 'components'), join(out, 'components'), {
  recursive: true,
  filter: (p) => !p.endsWith('.stories.js'),
});

console.log(`Drupal theme package written to ${out}`);
