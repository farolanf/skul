let videoDeviceId
let audioDeviceId

export default {
  videoSelect: {
    mounted() {
      navigator.mediaDevices.enumerateDevices()
        .then(devices => {
          this.el.querySelectorAll('option').remove()
          devices.forEach(dev => {
            if (dev.kind === 'videoinput') {

            }
          })
        })
    }
  },
  audioSelect: {
    mounted() {

    }
  },
  mediaStream: {
    mounted() {
      const videoEl = this.el.querySelector('video')

      const constraints = { audio: true, video: true }
      navigator.mediaDevices.getUserMedia(constraints)
        .then(mediaStream => {
          videoEl.srcObject = mediaStream
        })
    }
  }
}