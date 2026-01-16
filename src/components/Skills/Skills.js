import React from 'react';
import styles from './Skills.module.css';

const skills = [
  'React', 'JavaScript (ES6+)', 'HTML5 & CSS3', 'CSS Modules', 'Git/Github', 'React Router', 'REST APIs'
];

const Skills = () => (
  <section id="skills" className={styles.section}>
    <div className={styles.container}>
      <h2>Habilidades</h2>
      <ul className={styles.grid}>
        {skills.map(s => (
          <li key={s} className={styles.skill}>{s}</li>
        ))}
      </ul>
    </div>
  </section>
);

export default Skills;