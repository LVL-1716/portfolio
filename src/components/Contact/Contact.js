import React, { useState } from 'react';
import styles from './Contact.module.css';

const Contact = ({ targetEmail = 'seu-email@exemplo.com' }) => {
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
    window.location.href = `mailto:${targetEmail}?subject=Contato%20do%20site&body=${encodeURIComponent(`${form.name} - ${form.email}\n\n${form.message}`)}`;
    setSent(true);
    // Resetar o estado 'sent' após alguns segundos para que a mensagem de sucesso não fique permanentemente na tela.
    setTimeout(() => setSent(false), 5000);
  };

  return (
    <section id="contact" className={styles.section}>
      <div className={styles.container}>
        <h2>Contato</h2>
        <p className={styles.sub}>Abra uma conversa profissional — respondo em até 48h via e-mail.</p>
        <form onSubmit={handleSubmit} className={styles.form} aria-label="contact-form">
          <label>
            Nome
            <input type="text" name="name" value={form.name} onChange={handleChange} required />
          </label>
          <label>
            Email
            <input type="email" name="email" value={form.email} onChange={handleChange} required />
          </label>
          <label>
            Mensagem
            <textarea name="message" value={form.message} onChange={handleChange} rows={5} required />
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