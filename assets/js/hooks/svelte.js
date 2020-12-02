export default {
  mounted() {
    const componentName = this.el.id.replace('sveltex-', '')
    const requiredApp = require(`../svelte/${componentName}.svelte`)

    const json = this.el.getAttribute('data-props')
    let props = {}
    if (json) {
      props = JSON.parse(json)
    }

    // FIXME: workaround hydrate not working
    this.el.innerHTML = ''

    new requiredApp.default({
      target: this.el,
      props
    })
  }
}