export default { title: 'Foundations/Typography', parameters: { layout: 'padded' } };

export const Headings = { render: () => `
  <h1>Heading 1</h1><h2>Heading 2</h2><h3>Heading 3</h3><h4>Heading 4</h4><h5>Heading 5</h5><h6>Heading 6</h6>` };

export const Body = { render: () => `
  <p class="vds-overline">Overline</p>
  <p class="vds-lead">Lead paragraph for introductions and page summaries.</p>
  <p>Body text for most content. Find <a href="#">trusted vendors</a> for your next event, compare <strong>prices</strong> and read reviews.</p>
  <p class="vds-body-sm">Small body text.</p>
  <p class="vds-caption">Caption text</p>
  <blockquote>A quoted testimonial.</blockquote>
  <ul><li>List item</li><li>List item</li></ul>
  <p>Inline <code>code</code> and <kbd>Ctrl</kbd>.</p>` };

export const Links = { render: () => `<p><a href="#">Default link</a> · <a class="vds-link" href="#">Utility link</a></p>` };
