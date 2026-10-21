import Pagination from './pagination.twig';

export default { title: 'Molecules/Pagination', component: Pagination, tags: ['autodocs'], parameters: { layout: 'padded' }, args: { current: 3, total: 12 } };

export const Playground = {};
export const FirstPage = { args: { current: 1 } };
export const LastPage = { args: { current: 12 } };
export const FewPages = { args: { current: 1, total: 3 } };
