import ImageGallery from './image-gallery.twig';

const images = [1011, 1015, 1016, 1018].map((id, i) => ({ src: `https://picsum.photos/id/${id}/800/600`, alt: `Product image ${i + 1}` }));

export default { title: 'Molecules/Image gallery', component: ImageGallery, tags: ['autodocs'], parameters: { layout: 'padded' }, args: { images } };

export const Playground = {};
export const SingleImage = { args: { images: images.slice(0, 1) } };
export const Empty = { args: { images: [] } };
