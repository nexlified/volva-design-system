import SearchBar from './search-bar.twig';

export default { title: 'Molecules/Search bar', component: SearchBar, tags: ['autodocs'], parameters: { layout: 'padded' }, args: { show_location: true, size: 'md' } };

export const Playground = {};
export const Large = { args: { size: 'lg' } };
export const KeywordOnly = { args: { show_location: false } };
export const Prefilled = { args: { query: 'handmade ceramics', location: 'Berlin' } };
