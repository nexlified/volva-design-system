import Textarea from './textarea.twig';

export default { title: 'Atoms/Textarea', component: Textarea, tags: ['autodocs'], args: { name: 'message', label: 'Message', placeholder: 'Tell us more…' } };

export const Playground = {};
export const WithHelp = { args: { help: 'Up to 500 characters.' } };
export const WithError = { args: { error: 'Message is required.' } };
export const Required = { args: { required: true } };
export const Disabled = { args: { disabled: true, value: 'Not editable' } };
