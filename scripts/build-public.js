const fs = require('fs');
const path = require('path');

const source = path.join(__dirname, '..', 'prototype');
const publicDir = path.join(__dirname, '..', 'public');
const root = path.join(__dirname, '..');

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const from = path.join(src, entry.name);
    const to = path.join(dest, entry.name);
    if (entry.isDirectory()) copyDir(from, to);
    else fs.copyFileSync(from, to);
  }
}

function rmDir(dir) {
  if (fs.existsSync(dir)) fs.rmSync(dir, { recursive: true, force: true });
}

function copyFile(src, dest) {
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  fs.copyFileSync(src, dest);
}

rmDir(publicDir);
copyDir(source, publicDir);

copyFile(path.join(source, 'index.html'), path.join(root, 'index.html'));
copyFile(path.join(source, 'theme.css'), path.join(root, 'theme.css'));

const assetsSrc = path.join(source, 'assets');
const assetsDest = path.join(root, 'assets');
rmDir(assetsDest);
copyDir(assetsSrc, assetsDest);

console.log('Deployed prototype -> public, index.html, theme.css, assets/');
