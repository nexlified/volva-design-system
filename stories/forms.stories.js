import Input from '../components/input/input.twig';
import Textarea from '../components/textarea/textarea.twig';
import Select from '../components/select/select.twig';
import Checkbox from '../components/checkbox/checkbox.twig';
import Radio from '../components/radio/radio.twig';
import Switch from '../components/switch/switch.twig';

export default { title: 'Foundations/Form example', parameters: { layout: 'padded' } };

export const Form = { render: () => `
  <form style="display:grid;gap:var(--vds-space-4);max-width:420px">
    ${Input({ name: 'name', label: 'Name', required: true })}
    ${Select({ name: 'type', label: 'Event type', placeholder: 'Choose one', options: [{ value: 'a', label: 'Wedding' }, { value: 'b', label: 'Corporate' }] })}
    ${Textarea({ name: 'msg', label: 'Message' })}
    ${Radio({ name: 'contact', value: 'email', label: 'Contact by email', checked: true })}
    ${Radio({ name: 'contact', value: 'phone', label: 'Contact by phone' })}
    ${Checkbox({ name: 'terms', label: 'I agree to the terms' })}
    ${Switch({ name: 'news', label: 'Newsletter' })}
  </form>` };
