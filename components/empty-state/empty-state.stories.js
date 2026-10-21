import EmptyState from './empty-state.twig';

export default { title: 'Molecules/Empty state', component: EmptyState, tags: ['autodocs'], parameters: { layout: 'padded' },
  args: { title: 'No vendors found', description: 'Try removing some filters or searching a wider area.', action_label: 'Clear filters', action_href: '#' } };

export const Playground = {};
export const NoAction = { args: { action_label: '' } };
