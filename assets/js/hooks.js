import mediaStream from './hooks/media-stream'
import svelte from './hooks/svelte'

export default {
  autofocus: {
    mounted() {
      this.el.focus()
    }
  },
  svelte,
  ...mediaStream
}