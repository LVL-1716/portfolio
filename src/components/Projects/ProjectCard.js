import React from 'react';
import PropTypes from 'prop-types';
import styles from './ProjectCard.module.css';

const ProjectCard = ({ title, description = '', tech = [], repo = '', demo = '', image = '' }) => (
  <article className={styles.card}>
    <img src={image} alt={`${title} screenshot`} className={styles.image} />
    <div className={styles.content}>
      <h3>{title}</h3>
      <p className={styles.description}>{description}</p>
      <div className={styles.tech}><strong>Tecnologias:</strong> {tech.join(', ')}</div>
      <div className={styles.links}>
        {repo && <a href={repo} target="_blank" rel="noreferrer">Repositório</a>}
        {demo && <a href={demo} target="_blank" rel="noreferrer">Demo</a>}
      </div>
    </div>
  </article>
);

ProjectCard.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string,
  tech: PropTypes.arrayOf(PropTypes.string),
  repo: PropTypes.string,
  demo: PropTypes.string,
  image: PropTypes.string,
};


export default ProjectCard;