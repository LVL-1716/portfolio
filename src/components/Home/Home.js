import React from 'react';
import styles from './Home.module.css';
import avatar from '../../assets/profile-placeholder.png';

const Home = () => (
  <section id="home" className={styles.home}>
    <div className={styles.container}>
      <div className={styles.left}>
        <h1>Olá, sou LVL-1716</h1>
        <p className={styles.sub}>Desenvolvedor Full-Stack em formação — criando soluções com React e melhores práticas.</p>
        <div className={styles.cta}>
          <a href="#projects" className={styles.ctaBtn}>Ver Projetos</a>
          <a href="#contact" className={styles.ctaBtnSecondary}>Entrar em contato</a>
        </div>
      </div>
      <div className={styles.right}>
        <img src={avatar} alt="Foto de perfil" className={styles.avatar} />
        <div className={styles.contactInfo}>
          <div>Email: <a href="mailto:seu-email@exemplo.com">seu-email@exemplo.com</a></div>
          <div>Local: Brasil</div>
        </div>
      </div>
    </div>
  </section>
);

export default Home;