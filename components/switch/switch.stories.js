import Switch from './switch.twig';

export default { title: 'Atoms/Switch', component: Switch, tags: ['autodocs'], args: { name: 'switch', label: 'Show prices incl. tax' } };

export const Playground = {};
export const Checked = { args: { checked: true } };
export const WithHelp = { args: { help: 'Optional helper text.' } };
export const WithError = { args: { error: 'This field is required.' } };
export const Disabled = { args: { disabled: true } };
