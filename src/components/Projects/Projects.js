import React from 'react';
import styles from './Projects.module.css';
import ProjectCard from './ProjectCard';
import placeholder from '../../assets/project-placeholder.png';
import tarefasImage from '../../assets/Tarefas.jpg';
import mfImage from '../../assets/MF.jpg';
import petImage from '../../assets/Pet.jpg';

// Minimal project metadata to render cards. Replace description and images as needed.
const githubProjects = [
  {
    id: 'tarefas-app',
    title: 'Tarefas App',
    description: 'App de tarefas com CRUD, autenticação simples e listagem por prioridade/datas.',
    tech: ['React', 'CSS Modules', 'LocalStorage'],
    repo: 'https://github.com/LVL-1716/tarefas-app',
    demo: '',
    image: tarefasImage,
  },
  {
    id: 'Pet',
    title: 'Pet',
    description: 'Projeto de cadastro de pets com imagem e filtros por espécie.',
    tech: ['React', 'Node.js', 'CSS Modules'],
    repo: 'https://github.com/LVL-1716/Pet',
    demo: '',
    image: petImage,
  },
  {
    id: 'MF',
    title: 'MF',
    description: 'Um projeto multifuncional que agrega exemplos de rotas e integração com APIs.',
    tech: ['React', 'React Router', 'API REST'],
    repo: 'https://github.com/LVL-1716/MF',
    demo: '',
    image: mfImage,
  }
];

const Projects = () => (
  <section id="projects" className={styles.section}>
    <div className={styles.container}>
      <h2>Projetos</h2>
      <p className={styles.sub}>Uma seleção de projetos desenvolvidos durante o curso.</p>
      <div className={styles.grid}>
        {githubProjects.map(p => (
          <ProjectCard key={p.id} {...p} />
        ))}
      </div>
    </div>
  </section>
);

export default Projects;