var form = document.getElementById('design-gen-form');
var svgContainer = document.getElementById('svg-container');

const redraw = () => {
  svgContainer.lastChild?.remove();

  // form values
  const item_width = parseFloat(form.elements['item_width'].value);
  const item_depth = parseFloat(form.elements['item_depth'].value);
  const item_height = parseFloat(form.elements['item_height'].value);
  const piece_thickness = parseFloat(form.elements['piece_thickness'].value);
  const tolerance = parseFloat(form.elements['tolerance'].value);
  const back_rise = parseFloat(form.elements['back_rise'].value);
  const base_height = parseFloat(form.elements['base_height'].value);
  const front_side_buffer = parseFloat(form.elements['front_side_buffer'].value);
  const support_thickness = parseFloat(form.elements['support_thickness'].value);
  const support_height = parseFloat(form.elements['support_height'].value);
  const stroke_width = parseFloat(form.elements['stroke_width'].value);
  const view_padding = parseFloat(form.elements['view_padding'].value);

  // computed values
  const piece_slot_width = piece_thickness + tolerance;
  const stand_inner_width = item_width - 2*front_side_buffer;
  const stand_inner_depth = Math.sqrt(item_depth**2 - back_rise**2);
  const piece_inner_rise = back_rise;
  const piece_inner_diagonal_length = Math.sqrt(stand_inner_width**2 + stand_inner_depth**2 + back_rise**2);
  const piece_inner_width = Math.sqrt(piece_inner_diagonal_length**2 - piece_inner_rise**2);
  const interlock_height = ((piece_inner_width/2 - piece_slot_width/2)*(piece_inner_rise / piece_inner_width) + base_height)/2 + tolerance;
  const interlock_position = piece_inner_width/2 + support_thickness + support_height * (piece_inner_rise / piece_inner_width);
  const view_width = piece_inner_width + piece_thickness + support_thickness + 2*tolerance + 2*view_padding;
  const view_height = 2*(back_rise + base_height) + 3*view_padding;

  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute('id', 'design-svg');
  svg.setAttribute("aria-hidden","true");
  svg.setAttribute('viewBox', `0 0 ${view_width} ${view_height}`);

  var path1 = document.createElementNS("http://www.w3.org/2000/svg", 'path');
  path1.setAttribute('d', [
    `M ${view_padding} ${view_padding + piece_inner_rise}`,
    `v ${-piece_inner_rise}`,
    `l ${piece_inner_width} ${piece_inner_rise}`,
    `l ${support_height * (piece_inner_rise / piece_inner_width)} ${-support_height}`,
    `l ${support_thickness} ${support_thickness * (piece_inner_rise / piece_inner_width)}`,
    `v ${base_height + support_height - support_thickness * (piece_inner_rise / piece_inner_width)}`,
    `h ${-interlock_position + piece_slot_width/2}`,
    `v ${-interlock_height}`,
    `h ${-piece_slot_width}`,
    `v ${interlock_height}`,
    `h ${-piece_inner_width/2 + piece_slot_width/2}`,
    'z',
  ].join(''));
  path1.setAttribute('fill', 'none');
  path1.setAttribute('stroke', 'red');
  path1.setAttribute('stroke-width', stroke_width);

  var path2 = document.createElementNS("http://www.w3.org/2000/svg", 'path');
  path2.setAttribute('d', [
    `M ${view_padding} ${2*view_padding + back_rise + base_height + piece_inner_rise}`,
    `v ${-piece_inner_rise}`,
    `l ${piece_inner_width/2 - piece_slot_width/2} ${(piece_inner_width/2 - piece_slot_width/2)*(piece_inner_rise / piece_inner_width)}`,
    `v ${interlock_height + (piece_inner_rise / piece_inner_width)*piece_slot_width}`,
    `h ${piece_slot_width/2}`,
    `h ${piece_slot_width/2}`,
    `v ${-interlock_height}`,
    `l ${piece_inner_width/2 - piece_slot_width/2} ${(piece_inner_width/2 - piece_slot_width/2)*(piece_inner_rise / piece_inner_width)}`,
    `l ${support_height * (piece_inner_rise / piece_inner_width)} ${-support_height}`,
    `l ${support_thickness} ${support_thickness * (piece_inner_rise / piece_inner_width)}`,
    `v ${base_height + support_height - support_thickness * (piece_inner_rise / piece_inner_width)}`,
    `h ${-interlock_position - piece_inner_width/2}`,
    'z',
  ].join(''));
  path2.setAttribute('fill', 'none');
  path2.setAttribute('stroke', 'blue');
  path2.setAttribute('stroke-width', stroke_width);

  svg.appendChild(path1);
  svg.appendChild(path2);
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
  const svgBlob = new Blob([data], {type: 'image/svg+xml;charset=utf-8'});
  const url = DOMURL.createObjectURL(svgBlob);
  const a = document.body.appendChild(document.createElement("a"));
  a.setAttribute('download', 'display-stand.svg');
  a.setAttribute('href', url);
  a.setAttribute('target', '_blank');
  a.click();
}

