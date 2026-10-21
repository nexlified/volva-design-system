import Checkbox from './checkbox.twig';

export default { title: 'Atoms/Checkbox', component: Checkbox, tags: ['autodocs'], args: { name: 'checkbox', label: 'Email me vendor updates' } };

export const Playground = {};
export const Checked = { args: { checked: true } };
export const WithHelp = { args: { help: 'Optional helper text.' } };
export const WithError = { args: { error: 'This field is required.' } };
export const Disabled = { args: { disabled: true } };
