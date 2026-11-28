<script src="https://cdn.tailwindcss.com"></script>
<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    ink: '#111312',
                    panel: '#1b1e1c',
                    acid: '#a3ff3f'
                }
            }
        }
    };
</script>
<style>
    body { font-family: Arial, Helvetica, sans-serif; }
    .display-font { font-family: inherit; }
    .rounded-xl { border-radius: .5rem; }
    .rounded-2xl { border-radius: .75rem; }
    h1.uppercase, h2.uppercase { text-transform: none; letter-spacing: normal; }
    button, a { transition-duration: .15s; }
</style>
