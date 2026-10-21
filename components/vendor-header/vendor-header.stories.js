import VendorHeader from './vendor-header.twig';

export const header = {
  name: 'Clay & Co', cover: 'https://picsum.photos/id/1067/1600/400', tagline: 'Small-batch stoneware, thrown and glazed in Berlin since 2014.',
  category: 'Ceramics & pottery', location: 'Berlin, DE', rating: 4.7, review_count: 213, verified: true, cta_label: 'Contact vendor', cta_href: '#',
};

export default { title: 'Organisms/Vendor header', component: VendorHeader, tags: ['autodocs'], parameters: { layout: 'fullscreen' }, args: header };

export const Playground = {};
export const WithLogo = { args: { logo: 'https://picsum.photos/id/1025/200/200' } };
export const NoCoverNoRating = { args: { cover: '', rating: null, verified: false } };
