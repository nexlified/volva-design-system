import SiteFooter from './site-footer.twig';

export default { title: 'Organisms/Site footer', component: SiteFooter, tags: ['autodocs'], parameters: { layout: 'fullscreen' },
  args: { site_name: 'Volva', tagline: 'Find trusted local vendors.', copyright: '© 2026 Volva',
    columns: [{ title: 'Discover', links: [{ label: 'Vendors', href: '#' }, { label: 'Products', href: '#' }, { label: 'Map', href: '#' }] },
              { title: 'Company', links: [{ label: 'About', href: '#' }, { label: 'Contact', href: '#' }] },
              { title: 'Vendors', links: [{ label: 'List your business', href: '#' }, { label: 'Pricing', href: '#' }] }] } };

export const Playground = {};
