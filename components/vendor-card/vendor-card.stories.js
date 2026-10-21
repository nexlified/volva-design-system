import VendorCard from './vendor-card.twig';

export const vendor = {
  name: 'Clay & Co', href: '#', image: 'https://picsum.photos/id/1060/640/360', category: 'Ceramics & pottery', location: 'Berlin, DE',
  distance: '2.4 km', rating: 4.7, review_count: 213, verified: true, open_now: true, featured: false, orientation: 'vertical',
};

export default { title: 'Organisms/Vendor card', component: VendorCard, tags: ['autodocs'], parameters: { layout: 'padded' }, args: vendor,
  argTypes: { orientation: { control: 'inline-radio', options: ['vertical', 'horizontal'] } } };

export const Playground = {};
export const Featured = { args: { featured: true } };
export const Horizontal = { args: { orientation: 'horizontal' } };
export const Closed = { args: { open_now: false, verified: false } };
export const NoRating = { args: { rating: null, review_count: 0 } };
export const Skeleton = { args: { loading: true } };
