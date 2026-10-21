// Global config for every story: tokens + base styles + every component stylesheet.
import '../dist/css/tokens.css';
// One stylesheet per colour theme, scoped to [data-vds-theme="<name>"] (see themes/).
import '../dist/css/themes/ocean.css';
import '../dist/css/themes/sunset.css';
import '../dist/css/themes/forest.css';
import '../dist/css/themes/plum.css';
import '../dist/css/themes/dusk.css';
import '../styles/base.css';
import '../styles/typography.css';

// Components are authored as SDC (css next to twig); Drupal auto-attaches them, Storybook loads them all here.
const styles = import.meta.glob('../components/**/*.css', { eager: true });
void styles;

export default {
  initialGlobals: { theme: 'default' },
  globalTypes: {
    theme: {
      description: 'Colour theme',
      toolbar: {
        title: 'Theme',
        icon: 'paintbrush',
        items: ['default', 'ocean', 'sunset', 'forest', 'plum', 'dusk'],
        dynamicTitle: true,
      },
    },
  },
  decorators: [
    (story, { globals }) => {
      // Set on <html> so it also themes the docs page and anything portalled outside the story root.
      if (globals.theme === 'default') document.documentElement.removeAttribute('data-vds-theme');
      else document.documentElement.setAttribute('data-vds-theme', globals.theme);
      return story();
    },
  ],
  parameters: {
    layout: 'centered',
    controls: { expanded: true },
    viewport: {
      options: {
        mobile: { name: 'Mobile', styles: { width: '375px', height: '812px' } },
        tablet: { name: 'Tablet (md)', styles: { width: '768px', height: '1024px' } },
        desktop: { name: 'Desktop (lg)', styles: { width: '1280px', height: '800px' } },
      },
    },
    a11y: { test: 'todo' },
  },
};
