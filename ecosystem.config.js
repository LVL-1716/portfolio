module.exports = {
  apps: [
    {
      name: 'portfolio',
      script: 'http-server',
      args: 'build -p 5000 -a 0.0.0.0 -c-1',
      cwd: __dirname,
      env: {
        NODE_ENV: 'production'
      }
    }
  ]
};
