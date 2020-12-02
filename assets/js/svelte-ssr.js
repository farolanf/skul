const fs = require('fs')
const path = require('path')
const compiler = require('svelte/compiler');

const render = (componentPath, props) => {
  try {
    const code = fs.readFileSync(componentPath, 'utf8')
    const component = compiler.compile(code, {
      generate: 'ssr',
      format: 'cjs',
      css: false,
      name: path.basename(componentPath, '.svelte')
    })
    const js = eval(component.js.code)
    const { html } = js.render(props)
    return { error: null, markup: html }
  }
  catch (err) {
    const response = {
      path: componentPath,
      error: {
        type: err.constructor.name,
        message: err.message,
        stack: err.stack,
      },
      markup: null,
      component: null,
    }
    return response
  }
}

module.exports = {
  render
}