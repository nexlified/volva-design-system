import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import twig from 'vite-plugin-twig-drupal';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');

export default {
  framework: '@storybook/html-vite',
  stories: ['../components/**/*.stories.js', '../stories/**/*.stories.js'],
  addons: ['@storybook/addon-docs', '@storybook/addon-a11y'],
  viteFinal: (config) => {
    config.plugins.push(
      // Same namespace Drupal SDC uses, so `include 'volva_ds:button'` works in Storybook and Drupal alike.
      twig({ namespaces: { volva_ds: join(root, 'components') } }),
    );
    return config;
  },
};
