import Chip from './chip.twig';

export default { title: 'Atoms/Chip', component: Chip, tags: ['autodocs'], args: { label: 'Open now', active: false, removable: false } };

export const Playground = {};
export const States = {
  render: () => `<div style="display:flex;gap:8px">${Chip({ label: 'Default' })}${Chip({ label: 'Active', active: true })}${Chip({ label: 'Removable', active: true, removable: true })}</div>`,
};
