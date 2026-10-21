import Button from './button.twig';

export default {
  title: 'Atoms/Button',
  component: Button,
  tags: ['autodocs'],
  args: { label: 'Contact vendor', variant: 'primary', size: 'md', disabled: false, loading: false, full_width: false, icon_only: false },
  argTypes: {
    variant: { control: 'select', options: ['primary', 'secondary', 'ghost', 'danger'] },
    size: { control: 'inline-radio', options: ['sm', 'md', 'lg'] },
  },
};

export const Playground = {};
export const Variants = {
  render: () => ['primary', 'secondary', 'ghost', 'danger']
    .map((variant) => `<div style="display:flex;gap:12px;margin-bottom:12px;align-items:center">${['sm', 'md', 'lg']
      .map((size) => Button({ label: variant, variant, size })).join('')}
      ${Button({ label: 'Disabled', variant, disabled: true })}${Button({ label: 'Loading', variant, loading: true })}</div>`).join(''),
};
export const AsLink = { args: { label: 'View profile', href: '#', variant: 'secondary' } };
export const IconOnly = { args: { label: 'Save to favourites', icon_only: true, variant: 'secondary' }, render: (args) => Button({ ...args, label: 'Save to favourites' }) };
export const FullWidth = { args: { full_width: true, size: 'lg' } };
