var form = document.getElementById('design-gen-form');
var svgContainer = document.getElementById('svg-container');

const rect = (x1, y1, width, height) => {
  const p = document.createElementNS("http://www.w3.org/2000/svg", "path");
  p.setAttribute('d', [
    `M ${x1} ${y1}`,
    `v ${height}`,
    // `l ${10} ${10}`,
    `h ${width}`,
    `v ${-height}`,
    'z',
  ].join(''));
  p.setAttribute('fill', 'none');
  return p;
};

const redraw = () => {
  svgContainer.lastChild?.remove();

  // form values
  const material_thickness = parseFloat(form.elements['material_thickness'].value);
  const tolerance = parseFloat(form.elements['tolerance'].value);
  const stroke_width = parseFloat(form.elements['stroke_width'].value);
  const view_padding = parseFloat(form.elements['view_padding'].value);

  // computed values
  const view_width = 100;
  const view_height = 100;

  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute('id', 'design-svg');
  svg.setAttribute("aria-hidden", "true");
  svg.setAttribute('viewBox', `0 0 ${view_width} ${view_height}`);

  const r1 = rect(view_padding, view_padding, 20, 40);
  r1.setAttribute('stroke', 'red');
  r1.setAttribute('stroke-width', stroke_width);
  svg.appendChild(r1);

  const r2 = rect(view_padding, view_padding * 2 + 40, 20, 40);
  r2.setAttribute('stroke', 'red');
  r2.setAttribute('stroke-width', stroke_width);
  svg.appendChild(r2);

  const p = document.createElementNS("http://www.w3.org/2000/svg", "path");
  p.setAttribute('d', [
    `M ${view_padding * 2 + 20} ${view_padding}`,
    `v ${50}`,
    // `l ${10} ${10}`,
    `h ${40}`,
    `v ${-50}`,
    'z',
  ].join(''));
  p.setAttribute('fill', 'none');
  p.setAttribute('stroke', 'blue');
  p.setAttribute('stroke-width', stroke_width);
  svg.appendChild(p);

  svgContainer.appendChild(svg);
};

redraw();

form.addEventListener('submit', (e) => {
  e.preventDefault();
  redraw();
})

document.getElementById('export-svg-button').onclick = () => {
  const DOMURL = window.URL || window.webkitURL || window;
  const svg = document.getElementById("design-svg");
  const data = (new XMLSerializer()).serializeToString(svg);
  const svgBlob = new Blob([data], { type: 'image/svg+xml;charset=utf-8' });
  const url = DOMURL.createObjectURL(svgBlob);
  const a = document.body.appendChild(document.createElement("a"));
  a.setAttribute('download', 'display-stand.svg');
  a.setAttribute('href', url);
  a.setAttribute('target', '_blank');
  a.click();
}

