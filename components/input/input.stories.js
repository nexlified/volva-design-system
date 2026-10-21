import Input from './input.twig';

export default { title: 'Atoms/Input', component: Input, tags: ['autodocs'], args: { name: 'email', label: 'Email', placeholder: 'you@example.com', type: 'email' } };

export const Playground = {};
export const WithHelp = { args: { help: "We'll never share your email." } };
export const WithError = { args: { error: 'Enter a valid email address.', value: 'nope' } };
export const Required = { args: { required: true } };
export const Disabled = { args: { disabled: true } };
