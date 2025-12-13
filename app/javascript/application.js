import React from 'react';
import { createRoot } from 'react-dom/client';
import HelloWorld from './components/HelloWorld';

const mountReact = () => {
  const rootElement = document.getElementById('react-root');
  if (rootElement) {
    const root = createRoot(rootElement);
    root.render(<HelloWorld />);
  }
}

document.addEventListener('DOMContentLoaded', mountReact);
document.addEventListener('turbo:load', mountReact);