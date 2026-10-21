import ProductCard from './product-card.twig';

export const product = {
  title: 'Hand-thrown stoneware mug', href: '#', image: 'https://picsum.photos/id/1080/480/480', vendor_name: 'Clay & Co',
  price: '$32.00', rating: 4.8, review_count: 96, orientation: 'vertical', available: true,
};

export default { title: 'Organisms/Product card', component: ProductCard, tags: ['autodocs'], parameters: { layout: 'padded' }, args: product,
  argTypes: { orientation: { control: 'inline-radio', options: ['vertical', 'horizontal'] } } };

export const Playground = {};
export const OnSale = { args: { badge: 'Sale', badge_tone: 'danger', price: '$24.00', compare_at: '$32.00' } };
export const New = { args: { badge: 'New' } };
export const PriceOnRequest = { args: { on_request: true } };
export const Unavailable = { args: { available: false } };
export const Horizontal = { args: { orientation: 'horizontal' } };
export const Skeleton = { args: { loading: true } };
