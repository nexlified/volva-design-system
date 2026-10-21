import Avatar from './avatar.twig';

export default { title: 'Atoms/Avatar', component: Avatar, tags: ['autodocs'], args: { initials: 'VL', size: 'md', shape: 'circle' },
  argTypes: { size: { control: 'inline-radio', options: ['sm', 'md', 'lg', 'xl'] }, shape: { control: 'inline-radio', options: ['circle', 'square'] } } };

export const Playground = {};
export const Sizes = { render: () => `<div style="display:flex;gap:12px;align-items:center">${['sm', 'md', 'lg', 'xl'].map((size) => Avatar({ initials: 'VL', size })).join('')}</div>` };
export const WithImage = { args: { src: 'https://picsum.photos/id/1025/200/200', alt: 'Vendor logo', size: 'lg', shape: 'square' } };
