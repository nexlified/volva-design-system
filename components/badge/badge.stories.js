import Badge from './badge.twig';

export default {
  title: 'Atoms/Badge',
  component: Badge,
  tags: ['autodocs'],
  args: { label: 'Verified', tone: 'success' },
  argTypes: { tone: { control: 'select', options: ['neutral', 'brand', 'success', 'warning', 'danger', 'info'] } },
};

export const Playground = {};
export const Tones = {
  render: () => `<div style="display:flex;gap:8px">${['neutral', 'brand', 'success', 'warning', 'danger', 'info']
    .map((tone) => Badge({ label: tone, tone })).join('')}</div>`,
};
