import MapPopupCard from './map-popup-card.twig';

export default { title: 'Map search/Map popup card', component: MapPopupCard, tags: ['autodocs'],
  args: { title: 'Clay & Co', subtitle: 'Ceramics · 2.4 km', image: 'https://picsum.photos/id/1060/144/144', rating: 4.7, review_count: 213 } };

export const Playground = {};
export const WithPrice = { args: { title: 'Stoneware mug', price: '$32.00', subtitle: 'Clay & Co' } };
