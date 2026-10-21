import Breadcrumb from './breadcrumb.twig';

export default { title: 'Molecules/Breadcrumb', component: Breadcrumb, tags: ['autodocs'], parameters: { layout: 'padded' },
  args: { items: [{ label: 'Home', href: '/' }, { label: 'Ceramics', href: '/c/ceramics' }, { label: 'Clay & Co', href: '/v/clay-co' }, { label: 'Stoneware mug' }] } };

export const Playground = {};
