import Select from './select.twig';

const options = [{ value: 'wedding', label: 'Wedding' }, { value: 'corporate', label: 'Corporate' }, { value: 'birthday', label: 'Birthday' }];

export default { title: 'Atoms/Select', component: Select, tags: ['autodocs'], args: { name: 'event', label: 'Event type', placeholder: 'Choose one', options } };

export const Playground = {};
export const Selected = { args: { value: 'corporate' } };
export const WithHelp = { args: { help: 'Used to suggest vendors.' } };
export const WithError = { args: { error: 'Select an event type.' } };
export const Disabled = { args: { disabled: true } };
