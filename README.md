## Node.js Boilerplate Website

A minimal boilerplate project using **Node.js (Express)** as the backend and **HTML/CSS/JS** for the frontend.

### Structure

- `server.js` – Node.js/Express server (serves static files and exposes a sample API route).
- `public/index.html` – Main HTML page.
- `public/style.css` – Basic styling.
- `public/main.js` – Frontend JavaScript that calls the backend API.

### Setup & Run

1. Install dependencies:

   ```bash
   npm install
   ```

2. Start the server:

   ```bash
   npm start
   ```

3. Open your browser and visit:

   ```text
   http://localhost:8080
   ```

### Development Mode (Optional)

If you want auto-reload on changes (using `nodemon`):

```bash
npx nodemon server.js
```

