import React, { useState } from 'react';
import styles from './Contact.module.css';

const Contact = () => {
  const [form, setForm] = useState({ name: '', email: '', message: '' });
  const [sent, setSent] = useState(false);
  const [error, setError] = useState('');

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  // Validate fields locally — return an error message or empty string if valid
  const validate = () => {
    if (!form.name || !form.email || !form.message) return 'Por favor preencha todos os campos.';
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) return 'Email inválido.';
    return '';
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const validation = validate();
    if (validation) { setError(validation); return; }
    setError('');
    // Expo/demo: abrir mailto
    window.location.href = `mailto:seu-email@exemplo.com?subject=Contato%20do%20site&body=${encodeURIComponent(`${form.name} - ${form.email}\n\n${form.message}`)}`;
    setSent(true);
  };

  return (
    <section id="contact" className={styles.section}>
      <div className={styles.container}>
        <h2>Contato</h2>
        <p className={styles.sub}>Abra uma conversa profissional — respondo em até 48h via e-mail.</p>
        <form onSubmit={handleSubmit} className={styles.form} aria-label="contact-form">
          <label>
            Nome
            <input name="name" value={form.name} onChange={handleChange} />
          </label>
          <label>
            Email
            <input name="email" value={form.email} onChange={handleChange} />
          </label>
          <label>
            Mensagem
            <textarea name="message" value={form.message} onChange={handleChange} rows={5} />
          </label>
          {error && <div className={styles.error}>{error}</div>}
          <div className={styles.actions}>
            <button type="submit" className={styles.btn}>Enviar</button>
          </div>
          {sent && <div className={styles.success}>Obrigado! Se o e-mail estiver configurado, seu app de e-mail será aberto para enviar a mensagem.</div>}
        </form>
      </div>
    </section>
  );
};

export default Contact;