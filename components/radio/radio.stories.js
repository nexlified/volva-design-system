import Radio from './radio.twig';

export default { title: 'Atoms/Radio', component: Radio, tags: ['autodocs'], args: { name: 'radio', label: 'Photography', value: 'photo' } };

export const Playground = {};
export const Checked = { args: { checked: true } };
export const WithHelp = { args: { help: 'Optional helper text.' } };
export const WithError = { args: { error: 'This field is required.' } };
export const Disabled = { args: { disabled: true } };
