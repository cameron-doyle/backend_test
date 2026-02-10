document.addEventListener('DOMContentLoaded', () => {
  const helloBtn = document.getElementById('hello-btn');
  const helloResult = document.getElementById('hello-result');
  const yearSpan = document.getElementById('year');

  if (yearSpan) {
    yearSpan.textContent = new Date().getFullYear();
  }

  if (helloBtn && helloResult) {
    helloBtn.addEventListener('click', async () => {
      helloBtn.disabled = true;
      const originalText = helloBtn.textContent;
      helloBtn.textContent = 'Calling backend...';
      helloResult.textContent = '';
      helloResult.classList.remove('error');

      try {
        const res = await fetch('/api/hello');
        if (!res.ok) {
          throw new Error(`Request failed with status ${res.status}`);
        }
        const data = await res.json();
        helloResult.textContent = data.message || 'Got a response!';
      } catch (err) {
        console.error(err);
        helloResult.textContent =
          'There was a problem calling the backend. Check the console.';
        helloResult.classList.add('error');
      } finally {
        helloBtn.disabled = false;
        helloBtn.textContent = originalText;
      }
    });
  }
});

