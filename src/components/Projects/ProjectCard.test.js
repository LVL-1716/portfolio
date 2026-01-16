import React from 'react';
import { render, screen } from '@testing-library/react';
import ProjectCard from './ProjectCard';

const props = {
  title: 'Test Project',
  description: 'My project',
  tech: ['React'],
  repo: 'https://github.com',
  image: '',
};

test('renders project card with title and links', () => {
  render(<ProjectCard {...props} />);
  const title = screen.getByText('Test Project');
  expect(title).toBeInTheDocument();
  const link = screen.getByText(/Repositório/i);
  expect(link).toBeInTheDocument();
});
