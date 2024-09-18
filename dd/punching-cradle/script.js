var form = document.getElementById('design-gen-form');
var svgContainer = document.getElementById('svg-container');
var stroke_width = parseFloat(form.elements['stroke_width'].value);
var view_padding = parseFloat(form.elements['view_padding'].value);
var material_thickness = parseFloat(form.elements['material_thickness'].value);
var tolerance = parseFloat(form.elements['tolerance'].value);
var svg;

const rect0 = (x1, y1, width, height) => {
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

const rect = (x, y, width, height, rotation = 0) => {
  const r = document.createElementNS("http://www.w3.org/2000/svg", "rect");
  r.setAttribute('x', x);
  r.setAttribute('y', y);
  r.setAttribute('width', width);
  r.setAttribute('height', height);
  r.setAttribute('transform', `rotate(${rotation})`);
  r.setAttribute('fill', 'none');
  r.setAttribute('stroke', 'red');
  r.setAttribute('stroke-width', stroke_width);
  svg.appendChild(r);
};

const redraw = () => {
  svgContainer.lastChild?.remove();

  // form values
  material_thickness = parseFloat(form.elements['material_thickness'].value);
  tolerance = parseFloat(form.elements['tolerance'].value);
  stroke_width = parseFloat(form.elements['stroke_width'].value);
  view_padding = parseFloat(form.elements['view_padding'].value);
  const support_height = 80;
  const support_width = 180;
  const slat_width = 20;
  const slat_length = 40;
  const slat_thickness = 5;

  // computed values
  const view_width = 300;
  const view_height = 100;

  svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute('id', 'design-svg');
  svg.setAttribute("aria-hidden", "true");
  svg.setAttribute('viewBox', `0 0 ${view_width} ${view_height}`);

  // rear support
  rect(view_padding, view_padding, support_width, support_height);
  // left slit
  rect(view_padding + support_width / 2, view_padding + support_height / 2, slat_width, slat_thickness, 30);

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

