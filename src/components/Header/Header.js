import React, { useEffect, useState } from 'react';
import styles from './Header.module.css';

const Header = () => {
  const [theme, setTheme] = useState(() => {
    // prefer saved value, then system preference, default light
    try {
      const saved = localStorage.getItem('theme');
      if (saved) return saved;
    } catch (e) { console.warn('Failed to read theme from localStorage', e); }
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) return 'dark';
    return 'light';
  });

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
    try { localStorage.setItem('theme', theme); } catch (e) { console.warn('Failed to save theme to localStorage', e); }
  }, [theme]);

  const toggleTheme = () => setTheme((t) => (t === 'light' ? 'dark' : 'light'));
  const handleNav = (e, id) => {
    e.preventDefault();
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ behavior: 'smooth' });
  };

  return (
    <header className={styles.header}>
      <div className={styles.container}>
        <a href="https://github.com/LVL-1716" target="_blank" rel="noreferrer" className={styles.brand}>Luciano Lima</a>
        <nav className={styles.nav}>
          <a href="#home" onClick={(e) => handleNav(e, 'home')}>Início</a>
          <a href="#projects" onClick={(e) => handleNav(e, 'projects')}>Projetos</a>
          <a href="#about" onClick={(e) => handleNav(e, 'about')}>Sobre</a>
          <a href="#skills" onClick={(e) => handleNav(e, 'skills')}>Habilidades</a>
          <a href="#contact" onClick={(e) => handleNav(e, 'contact')}>Contato</a>
        </nav>
        <div className={styles.themeToggle}>
          <button aria-label={`Alterar tema para ${theme === 'light' ? 'escuro' : 'claro'}`} aria-pressed={theme === 'dark'} onClick={toggleTheme} className={styles.toggleButton}>
            {theme === 'light' ? '🌞' : '🌙'}
          </button>
        </div>
      </div>
    </header>
  );
};

export default Header;