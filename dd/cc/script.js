var form = document.getElementById('design-gen-form');
var svgContainer = document.getElementById('svg-container');
const title = 'Calendar Puzzle';

const redraw = () => {
  svgContainer.lastChild?.remove();

  // form values
  const puzzle_width = 80;
  const puzzle_height = 90;
  const split = form.elements['split'].checked;
  const stroke_width = parseFloat(form.elements['stroke_width'].value);
  const rounding_radius = 5;
  const font_size = 4;
  const offset = split ? puzzle_width : 0;

  // computed values
  const view_width = puzzle_width + offset + 15;
  const view_height = puzzle_height + 15;

  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute('id', 'design-svg');
  svg.setAttribute("aria-hidden","true");
  svg.setAttribute('viewBox', `0 0 ${view_width} ${view_height}`);

  // Etch Group

  var etch = document.createElementNS("http://www.w3.org/2000/svg", 'g');
  etch.setAttribute('font-family', 'monospace');
  etch.setAttribute('fill', 'blue');
  etch.setAttribute('stroke', 'blue');
  etch.setAttribute('stroke-width', stroke_width);
  etch.setAttribute('text-anchor', 'middle');

  // Date Text

  [
    { x: 20, y: 21.5, t: `Jan` },
    { x: 30, y: 21.5, t: `Feb` },
    { x: 40, y: 21.5, t: `Mar` },
    { x: 50, y: 21.5, t: `Apr` },
    { x: 60, y: 21.5, t: `May` },
    { x: 70, y: 21.5, t: `Jun` },
    { x: 20, y: 31.5, t: `Jul` },
    { x: 30, y: 31.5, t: `Aug` },
    { x: 40, y: 31.5, t: `Sep` },
    { x: 50, y: 31.5, t: `Oct` },
    { x: 60, y: 31.5, t: `Nov` },
    { x: 70, y: 31.5, t: `Dec` },
    { x: 20, y: 41.5, t: `1` },
    { x: 30, y: 41.5, t: `2` },
    { x: 40, y: 41.5, t: `3` },
    { x: 50, y: 41.5, t: `4` },
    { x: 60, y: 41.5, t: `5` },
    { x: 70, y: 41.5, t: `6` },
    { x: 80, y: 41.5, t: `7` },
    { x: 20, y: 51.5, t: `8` },
    { x: 30, y: 51.5, t: `9` },
    { x: 40, y: 51.5, t: `10` },
    { x: 50, y: 51.5, t: `11` },
    { x: 60, y: 51.5, t: `12` },
    { x: 70, y: 51.5, t: `13` },
    { x: 80, y: 51.5, t: `14` },
    { x: 20, y: 61.5, t: `15` },
    { x: 30, y: 61.5, t: `16` },
    { x: 40, y: 61.5, t: `17` },
    { x: 50, y: 61.5, t: `18` },
    { x: 60, y: 61.5, t: `19` },
    { x: 70, y: 61.5, t: `20` },
    { x: 80, y: 61.5, t: `21` },
    { x: 20, y: 71.5, t: `22` },
    { x: 30, y: 71.5, t: `23` },
    { x: 40, y: 71.5, t: `24` },
    { x: 50, y: 71.5, t: `25` },
    { x: 60, y: 71.5, t: `26` },
    { x: 70, y: 71.5, t: `27` },
    { x: 80, y: 71.5, t: `28` },
    { x: 20, y: 81.5, t: `29` },
    { x: 30, y: 81.5, t: `30` },
    { x: 40, y: 81.5, t: `31` },
    { x: 50, y: 81.5, t: `Sun` },
    { x: 60, y: 81.5, t: `Mon` },
    { x: 70, y: 81.5, t: `Tue` },
    { x: 80, y: 81.5, t: `Wed` },
    { x: 60, y: 91.5, t: `Thu` },
    { x: 70, y: 91.5, t: `Fri` },
    { x: 80, y: 91.5, t: `Sat` },
  ].map(t => {
    const txt = document.createElementNS("http://www.w3.org/2000/svg", 'text');
    const s = document.createTextNode(t.t);
    txt.appendChild(s);
    txt.setAttribute('x', t.x + offset);
    txt.setAttribute('y', t.y);
    txt.setAttribute('font-size', font_size);
    etch.appendChild(txt);
  });

  // Cut Group

  var cut = document.createElementNS("http://www.w3.org/2000/svg", 'g');
  cut.setAttribute('fill', 'none');
  cut.setAttribute('stroke', 'red');
  cut.setAttribute('stroke-width', stroke_width);

  var top_border = document.createElementNS("http://www.w3.org/2000/svg", 'rect');
  top_border.setAttribute('x', 10);
  top_border.setAttribute('y', 10);
  top_border.setAttribute('width', puzzle_width);
  top_border.setAttribute('height', puzzle_height);
  top_border.setAttribute('rx', rounding_radius);
  cut.appendChild(top_border);

  var bottom_border = document.createElementNS("http://www.w3.org/2000/svg", 'rect');
  bottom_border.setAttribute('x', 10 + offset);
  bottom_border.setAttribute('y', 10);
  bottom_border.setAttribute('width', puzzle_width);
  bottom_border.setAttribute('height', puzzle_height);
  bottom_border.setAttribute('rx', rounding_radius);
  cut.appendChild(bottom_border);

  var containing_edge = document.createElementNS("http://www.w3.org/2000/svg", 'path');
  containing_edge.setAttribute('d', [
    `M 15 15`,
    `h 60`,
    `v 20`,
    `h 10`,
    `v 60`,
    `h -30`,
    `v -10`,
    `h -40`,
    `z`,
  ].join(''));
  cut.appendChild(containing_edge);

  // Pieces

  const optimized_paths = [
    ' M 45 15 v 10 h -20 v 20 h -10 ',
    ' M 35 25 v 10 h 10 v 20 h -10 v -10 h -10 ',
    ' M 45 55 h 10 v 10 h -30 v -10 h -10 ',
    ' M 45 65 v 10 h -30 ',
    ' M 55 65 v 10 h -10 ',
    ' M 55 75 v 10 ',
    ' M 55 55 h 20 v 10 h -10 v 30 ',
    ' M 85 75 h -10 v 10 h 10 ',
    ' M 85 65 h -10 ',
    ' M 65 55 v -20 h 10 ',
    ' M 65 35 v -10 h 10 ',
    ' M 65 45 h -10 v -20 h -10 ',
  ];

  optimized_paths.map(path => {
    const p = document.createElementNS("http://www.w3.org/2000/svg", 'path');
    p.setAttribute('d', path);
    cut.appendChild(p);
  });

  svg.appendChild(etch);
  svg.appendChild(cut);
  svgContainer.appendChild(svg);
};

redraw();

form.elements.split.onchange = redraw;
form.addEventListener('submit', (e) => {
  e.preventDefault();
  redraw();
})

document.getElementById('export-svg-button').onclick = () => {
  const DOMURL = window.URL || window.webkitURL || window;
  const svg = document.getElementById("design-svg");
  const data = (new XMLSerializer()).serializeToString(svg);
  const svgBlob = new Blob([data], {type: 'image/svg+xml;charset=utf-8'});
  const url = DOMURL.createObjectURL(svgBlob);
  const a = document.body.appendChild(document.createElement("a"));
  a.setAttribute('download', `${title}.svg`);
  a.setAttribute('href', url);
  a.setAttribute('target', '_blank');
  a.click();
}

