import MapPin from './map-pin.twig';

export default { title: 'Map search/Map pin', component: MapPin, tags: ['autodocs'], args: { label: '₹32', variant: 'default', active: false, visited: false },
  argTypes: { variant: { control: 'inline-radio', options: ['default', 'cluster'] } } };

export const Playground = {};
export const States = { render: () => `<div style="display:flex;gap:12px;align-items:center">${MapPin({ label: '₹32' })}${MapPin({ label: '₹32', active: true })}${MapPin({ label: '₹32', visited: true })}${MapPin({ label: '12', variant: 'cluster' })}</div>` };
