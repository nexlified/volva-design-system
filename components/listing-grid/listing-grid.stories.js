import ListingGrid from './listing-grid.twig';
import VendorCard from '../vendor-card/vendor-card.twig';
import ProductCard from '../product-card/product-card.twig';
import { vendor } from '../vendor-card/vendor-card.stories.js';
import { product } from '../product-card/product-card.stories.js';

const wrap = (args, items) => ListingGrid({ ...args, items });
const vendors = (o = {}) => Array.from({ length: 6 }, (_, i) => VendorCard({ ...vendor, name: `Vendor ${i + 1}`, image: `https://picsum.photos/id/${1060 + i}/640/360`, ...o })).join('');
const products = () => Array.from({ length: 8 }, (_, i) => ProductCard({ ...product, title: `Product ${i + 1}`, image: `https://picsum.photos/id/${1080 + i}/480/480` })).join('');

export default { title: 'Organisms/Listing grid', component: ListingGrid, tags: ['autodocs'], parameters: { layout: 'padded' }, args: { layout: 'grid', min_column: '260px' },
  argTypes: { layout: { control: 'inline-radio', options: ['grid', 'list'] } } };

export const Vendors = { render: (args) => wrap(args, vendors()) };
export const VendorsList = { args: { layout: 'list' }, render: (args) => wrap(args, vendors({ orientation: 'horizontal' })) };
export const Products = { args: { min_column: '200px' }, render: (args) => wrap(args, products()) };
export const Loading = { render: (args) => wrap(args, vendors({ loading: true })) };
