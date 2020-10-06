import mediaStream from './hooks/media-stream'

export default {
  autofocus: {
    mounted() {
      this.el.focus()
    }
  },
  ...mediaStream
}