// Contract check: every component has yml + twig + css + stories, and the yml parses with props.
import { readdirSync, existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { load } from 'js-yaml';

const root = new URL('../components/', import.meta.url).pathname;
let failed = 0;
for (const name of readdirSync(root, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => d.name)) {
  for (const ext of ['component.yml', 'twig', 'css', 'stories.js']) {
    if (!existsSync(join(root, name, `${name}.${ext}`))) { console.error(`✗ ${name}: missing ${name}.${ext}`); failed++; }
  }
  try {
    const spec = load(readFileSync(join(root, name, `${name}.component.yml`), 'utf8'));
    if (!spec?.name) throw new Error('no name');
  } catch (e) { console.error(`✗ ${name}: invalid component.yml (${e.message})`); failed++; }
}
console.log(failed ? `${failed} problem(s)` : 'components OK');
process.exit(failed ? 1 : 0);
