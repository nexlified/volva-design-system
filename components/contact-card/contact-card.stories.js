import ContactCard from './contact-card.twig';

export default { title: 'Molecules/Contact card', component: ContactCard, tags: ['autodocs'], parameters: { layout: 'padded' },
  args: { hours: 'Closes 18:00', open_now: true, address: '12 Craft Lane, Berlin 10115', phone: '+49 30 1234 5678', website: 'https://clayandco.example', cta_label: 'Send enquiry' } };

export const Playground = {};
export const Closed = { args: { open_now: false, hours: 'Opens Mon 09:00' } };
export const Minimal = { args: { hours: '', address: '', website: '', open_now: undefined } };
