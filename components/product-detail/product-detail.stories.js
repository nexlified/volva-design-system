import ProductDetail from './product-detail.twig';

export const detail = {
  title: 'Hand-thrown stoneware mug', badge: 'New', price: '$32.00', rating: 4.8, review_count: 96, available: true,
  description: 'A 350 ml mug thrown on the wheel and finished in a satin speckled glaze. Dishwasher and microwave safe.',
  images: [1080, 1081, 1082].map((id, i) => ({ src: `https://picsum.photos/id/${id}/800/600`, alt: `Mug view ${i + 1}` })),
  specs: [{ label: 'Material', value: 'Stoneware' }, { label: 'Capacity', value: '350 ml' }, { label: 'Care', value: 'Dishwasher safe' }],
  vendor_name: 'Clay & Co', vendor_href: '#', vendor_rating: 4.7, cta_label: 'Contact vendor',
};

export default { title: 'Organisms/Product detail', component: ProductDetail, tags: ['autodocs'], parameters: { layout: 'padded' }, args: detail };

export const Playground = {};
export const OnSale = { args: { compare_at: '$40.00', price: '$32.00' } };
export const PriceOnRequest = { args: { on_request: true } };
export const Unavailable = { args: { available: false } };
