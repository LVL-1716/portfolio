import React from 'react';
import { render, screen } from '@testing-library/react';
import Projects from './Projects';

test('renders projects heading and cards', () => {
  render(<Projects />);
  const heading = screen.getByRole('heading', { name: /Projetos/i });
  expect(heading).toBeInTheDocument();
  const cards = screen.getAllByRole('img');
  expect(cards.length).toBeGreaterThanOrEqual(1);
});
