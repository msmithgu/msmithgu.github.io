const turns = 'UDLRFBudlrfbMESXYZ'.split('')

const mods = ' \'2'.split('')

var line

for (turn in turns) {
  line = ' | '
  for (mod in mods) {
    line += turns[turn] + mods[mod] + ' :    | '
  }
  console.log(line)
}
