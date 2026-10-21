// Global config for every story: tokens + base styles + every component stylesheet.
import '../dist/css/tokens.css';
import '../styles/base.css';

// Components are authored as SDC (css next to twig); Drupal auto-attaches them, Storybook loads them all here.
const styles = import.meta.glob('../components/**/*.css', { eager: true });
void styles;

export default {
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
