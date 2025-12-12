import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { act } from 'react';
import Header from './Header';

test('renders navigation links', () => {
  render(<Header />);
  const inicio = screen.getByText(/Início/i);
  expect(inicio).toBeInTheDocument();
  const projetos = screen.getByText(/Projetos/i);
  expect(projetos).toBeInTheDocument();
});

test('renders theme toggle button and toggles theme on click', async () => {
  render(<Header />);
  const toggle = screen.getByRole('button', { name: /Alterar tema/i });
  expect(toggle).toBeInTheDocument();
  // initial theme is set by default; toggle should switch theme attribute
  const initialTheme = document.documentElement.getAttribute('data-theme') || 'light';
  await act(async () => { await userEvent.click(toggle); });
  const newTheme = document.documentElement.getAttribute('data-theme') || 'light';
  expect(newTheme).not.toBe(initialTheme);
});
