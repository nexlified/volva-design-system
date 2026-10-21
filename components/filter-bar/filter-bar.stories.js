import FilterBar from './filter-bar.twig';

export default { title: 'Molecules/Filter bar', component: FilterBar, tags: ['autodocs'], parameters: { layout: 'padded' },
  args: { result_count: 248, filters: [{ label: 'Open now', active: true }, { label: 'Verified' }, { label: 'Top rated' }, { label: 'Within 10 km' }, { label: 'Free delivery' }] } };

export const Playground = {};
export const NoFilters = { args: { filters: [] } };
