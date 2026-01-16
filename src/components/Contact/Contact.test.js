import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Contact from './Contact';

test('validates contact form and shows error message', () => {
  render(<Contact />);
  const submit = screen.getByRole('button', { name: /Enviar/i });
  fireEvent.click(submit);
  expect(screen.getByText(/Por favor preencha todos os campos/i)).toBeInTheDocument();
});

test('validates e-mail input format', () => {
  render(<Contact />);
  const name = screen.getByLabelText(/Nome/i);
  const email = screen.getByLabelText(/Email/i);
  const message = screen.getByLabelText(/Mensagem/i);

  fireEvent.change(name, { target: { value: 'Tester' } });
  fireEvent.change(email, { target: { value: 'invalid-email' } });
  fireEvent.change(message, { target: { value: 'Hello' } });
  const submit = screen.getByRole('button', { name: /Enviar/i });
  fireEvent.click(submit);
  expect(screen.getByText(/Email inválido/i)).toBeInTheDocument();
});
