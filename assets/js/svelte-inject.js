const context = require.context("./svelte", false, /\.svelte/);
window.onload = function() {
  context.keys().forEach(file => {
    const componentName = file.replace(/\.\/|\.svelte/g, "");
    const targetId = `sveltex-${componentName}`;

    const root = document.getElementById(targetId);

    if (!root) {
      return;
    }

    const requiredApp = require(`./svelte/${componentName}.svelte`);

    const props = root.getAttribute("data-props");
    let parsedProps = {};
    if (props) {
      parsedProps = JSON.parse(props);
    }

    // FIXME: workaround hydrate not working
    root.innerHTML = ''

    new requiredApp.default({
      target: root,
      props: parsedProps
    });
  });
};
