import React from 'react';
import styles from './Footer.module.css';

const Footer = () => (
  <footer className={styles.footer}>
    <div className={styles.container}>
      <span>© {new Date().getFullYear()} LVL-1716 — Portfólio</span>
      <span>
        <a href="https://github.com/LVL-1716" target="_blank" rel="noreferrer">GitHub</a>
      </span>
    </div>
  </footer>
);

export default Footer;