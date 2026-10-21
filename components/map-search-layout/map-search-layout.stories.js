import MapSearchLayout from './map-search-layout.twig';
import FilterBar from '../filter-bar/filter-bar.twig';
import VendorCard from '../vendor-card/vendor-card.twig';
import MapPin from '../map-pin/map-pin.twig';
import MapPopupCard from '../map-popup-card/map-popup-card.twig';
import { vendor } from '../vendor-card/vendor-card.stories.js';

// Static stand-in for the host's map canvas.
const fakeMap = `<div style="position:absolute;inset:0;background:url(https://picsum.photos/id/1031/1200/800) center/cover;filter:saturate(.4)">
  <div style="position:absolute;top:30%;left:25%">${MapPin({ label: '$32' })}</div>
  <div style="position:absolute;top:50%;left:55%">${MapPin({ label: '$48', active: true })}</div>
  <div style="position:absolute;top:65%;left:35%">${MapPin({ label: '7', variant: 'cluster' })}</div>
  <div style="position:absolute;top:calc(50% + 44px);left:calc(55% - 100px)">${MapPopupCard({ title: 'Clay & Co', subtitle: 'Ceramics · 2.4 km', image: 'https://picsum.photos/id/1060/144/144', rating: 4.7, review_count: 213 })}</div>
</div>`;

const filters = FilterBar({ result_count: 24, filters: [{ label: 'Open now', active: true }, { label: 'Verified' }, { label: 'Top rated' }] });
const results = Array.from({ length: 4 }, (_, i) => VendorCard({ ...vendor, name: `Vendor ${i + 1}`, orientation: 'horizontal', image: `https://picsum.photos/id/${1060 + i}/320/240` })).join('');

export default { title: 'Map search/Map search layout', component: MapSearchLayout, tags: ['autodocs'], parameters: { layout: 'fullscreen' },
  args: { view: 'list', filters, results, map: fakeMap }, argTypes: { view: { control: 'inline-radio', options: ['list', 'map'] } } };

export const Desktop = { parameters: { viewport: { defaultViewport: 'desktop' } } };
export const MobileList = { parameters: { viewport: { defaultViewport: 'mobile' } } };
export const MobileMap = { args: { view: 'map' }, parameters: { viewport: { defaultViewport: 'mobile' } } };
