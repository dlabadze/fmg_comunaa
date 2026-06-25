const fs = require('fs');
const path = require('path');

const source = path.join(__dirname, '..', 'prototype');
const target = path.join(__dirname, '..', 'public');

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const from = path.join(src, entry.name);
    const to = path.join(dest, entry.name);
    if (entry.isDirectory()) copyDir(from, to);
    else fs.copyFileSync(from, to);
  }
}

if (fs.existsSync(target)) fs.rmSync(target, { recursive: true, force: true });
copyDir(source, target);
console.log('Copied prototype -> public');
