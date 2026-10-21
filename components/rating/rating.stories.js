import Rating from './rating.twig';

export default { title: 'Atoms/Rating', component: Rating, tags: ['autodocs'], args: { value: 4.3, count: 128, compact: false },
  argTypes: { value: { control: { type: 'range', min: 0, max: 5, step: 0.1 } } } };

export const Playground = {};
export const Compact = { args: { compact: true } };
export const NoReviews = { args: { value: 0, count: 0 } };
