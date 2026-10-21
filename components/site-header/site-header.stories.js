import SiteHeader from './site-header.twig';

export default { title: 'Organisms/Site header', component: SiteHeader, tags: ['autodocs'], parameters: { layout: 'fullscreen' },
  args: { site_name: 'Volva', show_search: true, signed_in: false, nav: [{ label: 'Vendors', href: '/vendors', active: true }, { label: 'Products', href: '/products' }, { label: 'Map', href: '/map' }] } };

export const Playground = {};
export const SignedIn = { args: { signed_in: true } };
export const NoSearch = { args: { show_search: false } };
