import Price from './price.twig';

export default { title: 'Atoms/Price', component: Price, tags: ['autodocs'], args: { amount: '$49.00', unit: '/ unit', size: 'md' } };

export const Playground = {};
export const Discounted = { args: { amount: '$39.00', compare_at: '$49.00' } };
export const Large = { args: { size: 'lg' } };
export const OnRequest = { args: { on_request: true } };
