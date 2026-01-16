import React from 'react';
import styles from './About.module.css';

const About = () => (
  <section id="about" className={styles.section}>
    <div className={styles.container}>
      <h2>Sobre Mim</h2>
      <p className={styles.paragraph}>Sou um desenvolvedor em formação, estudando tecnologias modernas de front-end e back-end. Durante o curso, trabalhei em projetos com foco em React, roteamento, integração com APIs e boas práticas de desenvolvimento.</p>
      <p className={styles.paragraph}>Foco em aprendizado contínuo, comunicação com times e comprometimento com entregas de valor.</p>
    </div>
  </section>
);

export default About;